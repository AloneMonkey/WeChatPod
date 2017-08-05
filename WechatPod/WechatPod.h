//
//  WechatPod.h
//  WechatPod
//
//  Created by monkey on 2017/8/1.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/**
 WechatPod对外接口模块
 */
@interface WechatPod :NSObject

/**
 设置微信步数
 
 @param step 走的步数
 */
-(void)setStepCount:(NSInteger) step;

/**
 设置经纬度
 
 @param location 经纬度
 */
-(void)setLocation:(CLLocationCoordinate2D) location;

/**
 开启消息防撤回(默认开启）
 
 @param enableRevoke 是否开启
 */
-(void)setEnableRevoke:(BOOL) enableRevoke;


/**
 游戏作弊
 
 @param gameNumber 设置的值
 1. 为剪刀
 2. 为石头
 3. 为布
 4~9 分别对应骰子的1~6
 */
-(void)setGameNumber:(NSInteger) gameNumber;

@end
