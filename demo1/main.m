//
//  main.m
//  MacAgentTestModel
//
//  Created by Bernardo Breder on 05/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyThread : NSThread

@property (nonatomic, strong) NSLock *lock;

- (instancetype)initWithLock:(NSLock*)lock;

- (void)run;

@end

@implementation MyThread

- (instancetype)initWithLock:(NSLock*)lock
{
    if (!(self = [super initWithTarget:self selector:@selector(run) object:nil])) return nil;
    _lock = lock;
    [self start];
    return self;
}

- (void)run
{
    NSLog(@"Start Thread");
    sleep(1);
    @synchronized(_lock.class) {
        NSLog(@"[%x] Executing", self);
        sleep(1);
    }
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Hello, World!");
        NSLock *lock = [[NSLock alloc] init];
        MyThread* thread1 = [[MyThread alloc] initWithLock:lock];
        MyThread* thread2 = [[MyThread alloc] initWithLock:lock];
        while (!thread1.finished) sleep(1);
        while (!thread2.finished) sleep(1);
    }
    return 0;
}
