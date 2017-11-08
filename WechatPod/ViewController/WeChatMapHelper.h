//
//  WeChatMapHelper.h
//  WechatPod
//
//  Created by Harry Twan on 08/11/2017.
//  Copyright © 2017 Coder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^handler)(NSString *, NSString *);

@interface WeChatMapHelper : NSObject

+ (WeChatMapHelper *)sharedInstance;
+ (void)decodeLocation: (CLLocationCoordinate2D)locationPoint completionHandler: (handler)callback;

@end
