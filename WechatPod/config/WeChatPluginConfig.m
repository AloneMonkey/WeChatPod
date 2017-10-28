//
//  WeChatPluginConfig.m
//  WechatPod
//
//  Created by monkey on 2017/8/1.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <CaptainHook/CaptainHook.h>
#import "WeChatPluginConfig.h"

WeChatPluginConfig* pluginConfig = nil;

@implementation WeChatPluginConfig

+(WeChatPluginConfig *)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _stepCount = 0;
        _location = CLLocationCoordinate2DMake(0, 0);
        _enableRevoke = YES;
        _gameNumber = 0;
    }
    return self;
}

-(void)setLatitude:(double)latitude{
    _location = CLLocationCoordinate2DMake(latitude, _location.longitude > 0 ? _location.longitude : 0);
}

-(void)setLongitude:(double)longitude{
    _location = CLLocationCoordinate2DMake(_location.latitude > 0 ? _location.latitude : 0, longitude);
}

@end

CHConstructor{
    pluginConfig = [WeChatPluginConfig sharedInstance];
}

