//
//  LYNotificationManager.h
//  LYUserNotificationTest
//
//  Created by 李勇 on 17/7/11.
//  Copyright © 2017年 李勇. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kLYNMJPushAppKey = @"8aae2d1c3bf3be5013471b33";

@interface LYNotificationManager : NSObject

/**
 配置基本信息

 @param launchOptions 启动参数
 */
+ (void)configInfoWithOptions:(NSDictionary *)launchOptions;

/**
 注册deviceToken
 
 @param deviceToken 手机token
 */
+ (void)registeDeviceToken:(NSData *)deviceToken;

@end
