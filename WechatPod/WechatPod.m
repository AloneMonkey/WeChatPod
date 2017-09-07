//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  WechatPod.m
//  WechatPod
//
//  Created by monkey on 2017/8/1.
//  Copyright (c) 2017年 Coder. All rights reserved.
//

#import "WechatPod.h"
#import "WeChatPluginConfig.h"
#import "CaptainHook.h"
#import <UIKit/UIKit.h>

@implementation WechatPod

+(WechatPod *)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

-(void)setStepCount:(NSInteger)step{
    [pluginConfig setStepCount:step];
}

-(void)setLocation:(CLLocationCoordinate2D)location{
    [pluginConfig setLocation:location];
}

-(void)setEnableRevoke:(BOOL)enableRevoke{
    [pluginConfig setEnableRevoke:enableRevoke];
}

-(void)setGameNumber:(NSInteger)gameNumber{
    [pluginConfig setGameNumber:gameNumber];
}

-(void)restore{
    [pluginConfig setStepCount:0];
    [pluginConfig setLocation:CLLocationCoordinate2DMake(0, 0)];
    [pluginConfig setEnableRevoke:NO];
    [pluginConfig setGameNumber:0];
}

@end
