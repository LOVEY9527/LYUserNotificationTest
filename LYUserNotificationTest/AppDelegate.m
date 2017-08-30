//
//  AppDelegate.m
//  LYUserNotificationTest
//
//  Created by 李勇 on 17/7/11.
//  Copyright © 2017年 李勇. All rights reserved.
//

#import "AppDelegate.h"
#import "LYNotificationManager.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [LYNotificationManager configInfoWithOptions:launchOptions];
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
//    {
//        UNUserNotificationCenter *userNotificationCenter = [UNUserNotificationCenter currentNotificationCenter];
//        userNotificationCenter.delegate = self;
//        [userNotificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound
//                                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
//                                                  if (granted)
//                                                  {
//                                                      //点击允许
//                                                      [userNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//                                                          NSLog(@"userNotificationSetting:%@", settings);
//                                                      }];
//                                                  }else{
//                                                      //点击不允许
//                                                      NSLog(@"请求推送权限失败");
//                                                  }
//                                              }];
//    }
//    
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//        //iOS10特有
//        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//        // 必须写代理，不然无法监听通知的接收与点击
//        center.delegate = self;
//        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
//            if (granted) {
//                // 点击允许
//                NSLog(@"注册成功");
//                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//                    NSLog(@"%@", settings);
//                }];
//            } else {
//                // 点击不允许
//                NSLog(@"注册失败");
//            }
//        }];
//    }else if ([[UIDevice currentDevice].systemVersion floatValue] >8.0){
//        //iOS8 - iOS10
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
//        
//    }else if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
//        //iOS8系统以下
//        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
//    }
//    // 注册获得device Token
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [LYNotificationManager registeDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"获取deviceToken失败！！！");
}

#pragma mark - UNUserNotificationCenterDelegate

//- (void)userNotificationCenter:(UNUserNotificationCenter *)center
//       willPresentNotification:(UNNotification *)notification
//         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
//{
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
//    
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        NSLog(@"iOS10 前台收到远程通知:%@", content);
//        
//    }
//    else {
//        // 判断为本地通知
//        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
//    }
//    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
//    completionHandler(UNNotificationPresentationOptionBadge|
//                      UNNotificationPresentationOptionSound|
//                      UNNotificationPresentationOptionAlert);
//}

//- (void)userNotificationCenter:(UNUserNotificationCenter *)center
//        didReceiveNotificationResponse:(UNNotificationResponse *)response
//        withCompletionHandler:(void(^)())completionHandler
//{
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        NSLog(@"iOS10 收到远程通知:%@", content);
//        
//    }
//    else {
//        // 判断为本地通知
//        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
//    }
//    
//    completionHandler();  // 系统要求执行这个方法
//}

@end
