//
//  MAEnvironment.m
//  MacAgentLibrary
//
//  Created by Bernardo Breder on 13/05/15.
//  Copyright (c) 2015 MacAgent. All rights reserved.
//

#import "MacAgent.h"

@interface MAMessage : NSObject

@end

@interface MALocalMessage : MAMessage

@end

@interface MAEnvironmentEntry : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) SEL selector;

@property (nonatomic, weak) MAAgent *agent;

@end

@interface MAEnvironment ()

@property (nonatomic, strong) NSMutableArray *agents;

@property (nonatomic, strong) NSMutableArray *selectorArray;

@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, assign) BOOL closing;

@end

@implementation MAEnvironment

#define SELECTOR_COMPARISON ^NSComparisonResult(id obj1, id obj2) { return [((MAEnvironmentEntry*)obj1).name compare:((MAEnvironmentEntry*)obj2).name]; }

- (instancetype)init
{
    if (!(self = [super init])) return nil;
    _agents = [[NSMutableArray alloc] init];
    _queue = [[NSOperationQueue alloc] init];
    _queue.maxConcurrentOperationCount = 32;
    _queue.qualityOfService = NSQualityOfServiceBackground;
    _selectorArray = [[NSMutableArray alloc] init];
    _closing = false;
    return self;
}

- (void)startAgent:(MAAgent*)agent
{
    SelectorArray *selectors = agent.agentSelectorArray;
    if (selectors.count == 0) return;
    @synchronized(self) {
        for (NSValue *selectorValue in selectors) {
            SEL selector = selectorValue.pointerValue;
            if (![agent respondsToSelector:selector]) continue;
            MAEnvironmentEntry *entry = [[MAEnvironmentEntry alloc] init];
            entry.name = NSStringFromSelector(selector);
            entry.selector = selector;
            entry.agent = agent;
            [_selectorArray addObject:entry];
        }
        _selectorArray = [[NSMutableArray alloc] initWithArray:[_selectorArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [((MAEnvironmentEntry*)obj1).name compare:((MAEnvironmentEntry*)obj2).name];
        }]];
        [_agents addObject:agent];
    }
    agent.environment = self;
}

- (void)sendBroadcastMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block
{
    if (_closing) return;
    if (!block) block = ^(NSDictionary* context){};
    for (MAEnvironmentEntry *entry in [self entrysOfSelector:selector]) {
        [_queue addOperation:[NSBlockOperation blockOperationWithBlock:^() {
            [entry.agent fireReceiveMessageListener:context];
            [entry.agent receiveMessage:entry.selector withContext:context returning:block];
        }]];
    }
}

- (NSArray*)entrysOfSelector:(SEL)selector
{
    MAEnvironmentEntry *example = [[MAEnvironmentEntry alloc] init];
    example.name = NSStringFromSelector(selector);
    NSMutableArray *entrys = [[NSMutableArray alloc] init];
    @synchronized(self) {
        NSInteger count = _selectorArray.count;
        NSInteger index = [_selectorArray indexOfObject:example inSortedRange:NSMakeRange(0, count) options:NSBinarySearchingFirstEqual usingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [((MAEnvironmentEntry*)obj1).name compare:((MAEnvironmentEntry*)obj2).name];
        }];
        while (index < count) {
            MAEnvironmentEntry *entry = _selectorArray[index];
            if (entry.selector != selector) break;
            [entrys addObject:entry];
            index++;
        }
    }
    return entrys;
}

- (void)close
{
    _closing = true;
    while (_queue.operationCount > 0) {
        [NSThread sleepForTimeInterval:1.0];
    }
    [_selectorArray removeAllObjects];
    [_agents removeAllObjects];
    _closing = false;
}

@end

@implementation MAEnvironmentEntry

@end