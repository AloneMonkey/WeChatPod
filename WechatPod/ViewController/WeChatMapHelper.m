//
//  WeChatMapHelper.m
//  WechatPod
//
//  Created by Harry Twan on 08/11/2017.
//  Copyright © 2017 Coder. All rights reserved.
//

#import "WeChatMapHelper.h"

@implementation WeChatMapHelper

+ (WeChatMapHelper *)sharedInstance {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

+ (void)decodeLocation: (CLLocationCoordinate2D)locationPoint completionHandler: (handler)callback {
    CLLocation *location = [CLLocation.alloc initWithLatitude:locationPoint.latitude longitude:locationPoint.longitude];
    CLGeocoder *geocoder = [CLGeocoder.alloc init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error == nil && placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            NSString *name = placemark.locality;
            NSString *detail = placemark.name;
            if (callback) {
                callback(name, detail);
            }
        }
        else {
            NSLog(@"Reverse geocode location failure. error = %@", error);
        }
    }];
}

@end
