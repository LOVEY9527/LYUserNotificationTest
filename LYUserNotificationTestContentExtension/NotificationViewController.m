//
//  NotificationViewController.m
//  LYUserNotificationTestContentExtension
//
//  Created by 李勇 on 17/7/13.
//  Copyright © 2017年 李勇. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    
//    self.contentHandler = contentHandler;
//    // copy发来的通知，开始做一些处理
//    self.bestAttemptContent = [request.content mutableCopy];
//    // Modify the notification content here...
//    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
//    // 重写一些东西
//    self.bestAttemptContent.title = @"我是标题";
//    self.bestAttemptContent.subtitle = @"我是子标题";
//    self.bestAttemptContent.body = @"来自徐不同";
//    // 附件
//    NSDictionary *dict =  self.bestAttemptContent.userInfo;
//    NSDictionary *notiDict = dict[@"aps"];
//    NSString *imgUrl = [NSString stringWithFormat:@"%@",notiDict[@"imageAbsoluteString"]];
//    
////    ！！！！！ 这里是重点！！！！！！！！！！！！
//    // 我在这里写死了category1，其实在收到系统推送时，每一个推送内容最好带上一个catagory，跟服务器约定好了，这样方便我们根据categoryIdentifier来自定义不同类型的视图，以及action
//    self.bestAttemptContent.categoryIdentifier = @"myNotificationCategory";
}

@end
