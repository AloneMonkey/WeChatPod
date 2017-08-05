//
//  WechatStepHook.m
//  WechatPod
//
//  Created by monkey on 2017/8/1.
//  Copyright © 2017年 Coder. All rights reserved.
//

/**
 1. 修改步数
 */


#import "CaptainHook.h"
#import "WeChatPluginConfig.h"
#import <Foundation/Foundation.h>

typedef void (^CMStepQueryHandler)(NSInteger numberOfSteps, NSError *error);
CMStepQueryHandler origHandler = nil;

CMStepQueryHandler newHandler = ^(NSInteger numberSteps, NSError *error){
    NSLog(@"获取到的步数  %lu", numberSteps);
    if(pluginConfig.stepCount != 0){
        numberSteps = pluginConfig.stepCount;
    }
    NSLog(@"修改后的步数  %lu", numberSteps);
    origHandler(numberSteps,error);
};

CHDeclareClass(CMStepCounter);

CHOptimizedMethod4(self, void, CMStepCounter,queryStepCountStartingFrom, NSData*, from, to, NSData*, to, toQueue, NSOperationQueue*, queue, withHandler, CMStepQueryHandler, handler){
        origHandler = [handler copy];
        handler = newHandler;
        
    CHSuper4(CMStepCounter, queryStepCountStartingFrom, from, to, to, toQueue, queue, withHandler, handler);
}

CHConstructor{
    CHLoadLateClass(CMStepCounter);
    CHClassHook4(CMStepCounter, queryStepCountStartingFrom, to, toQueue, withHandler);
}
