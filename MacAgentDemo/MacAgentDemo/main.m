//
//  main.m
//  MacAgentDemo
//
//  Created by Bernardo Breder on 13/05/15.
//  Copyright (c) 2015 MacAgent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacAgent.h"

int main(int argc, const char * argv[]) {
    for (;;) {
        @autoreleasepool {
            MAEnvironment *env = [[MAEnvironment alloc] init];
            MAAgent *agent = [[MAAgent alloc] init];
            [env startAgent:agent];
            [env close];
        }        
    }
    return 0;
}
