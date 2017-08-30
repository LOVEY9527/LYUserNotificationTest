//
//  LYNotificationManager.m
//  LYUserNotificationTest
//
//  Created by 李勇 on 17/7/11.
//  Copyright © 2017年 李勇. All rights reserved.
//

#import "LYNotificationManager.h"
#import <JPUSHService.h>
#import <UIKit/UIKit.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface LYNotificationManager()<JPUSHRegisterDelegate>

@end

@implementation LYNotificationManager

/**
 单例类获取方法

 @return 单例
 */
+ (instancetype)sharedNotificationManager
{
    static LYNotificationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LYNotificationManager alloc] init];
    });
    
    return sharedInstance;
}

/**
 配置基本信息
 
 @param launchOptions 启动参数
 */
+ (void)configInfoWithOptions:(NSDictionary *)launchOptions
{
    [[self sharedNotificationManager] configInfoWithOptions:launchOptions];
}

- (void)configInfoWithOptions:(NSDictionary *)launchOptions
{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:kLYNMJPushAppKey
                          channel:@"APP STORE"
                 apsForProduction:NO];
}

/**
 注册deviceToken

 @param deviceToken 手机token
 */
+ (void)registeDeviceToken:(NSData *)deviceToken
{
    [[self sharedNotificationManager] registeDeviceToken:deviceToken];
}

- (void)registeDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark - JPUSHRegisterDelegate

//App处于前台接收通知时
//下面这个代理方法，只会是app处于前台状态 前台状态 and 前台状态下才会走，后台模式下是不会走这里的
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
        willPresentNotification:(UNNotification *)notification
        withCompletionHandler:(void (^)(NSInteger options))completionHandler
{
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        NSLog(@"iOS10 前台收到远程通知:%@", content);
    }else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
}

//App通知的点击事件
//下面这个代理方法，只会是用户点击消息才会触发，如果使用户长按（3DTouch）、弹出Action页面等并不会触发。
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
        didReceiveNotificationResponse:(UNNotificationResponse *)response
        withCompletionHandler:(void(^)())completionHandler
{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知:%@", content);
        
    }else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    // 系统要求执行这个方法
    completionHandler();
}

@end
