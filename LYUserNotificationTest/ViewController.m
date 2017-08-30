//
//  ViewController.m
//  LYUserNotificationTest
//
//  Created by 李勇 on 17/7/11.
//  Copyright © 2017年 李勇. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //本地推送触发源
    UNTimeIntervalNotificationTrigger *timerTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    //本地推送内容
    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
    notificationContent.badge = @(1);
    notificationContent.body = @"我是body我是body我是body我是body我是body";
    notificationContent.sound = [UNNotificationSound defaultSound];
    //铃声名字一定要写全了，包括后缀名
//    notificationContent.sound = [UNNotificationSound soundNamed:@"sounds.caf"];
    notificationContent.subtitle = @"定时推送，60秒后后重复";
    notificationContent.title = @"本地推送";
    notificationContent.launchImageName = @"launchimage-4.7.png";
    notificationContent.userInfo = @{};
    //本地推送的附件
    NSURL *attachmentURL = [[NSBundle mainBundle] URLForResource:@"movie1" withExtension:@"mp4"];
    NSError *error = nil;
    NSMutableDictionary *optionsDic = [NSMutableDictionary dictionaryWithCapacity:0];
    //UNNotificationAttachmentOptionsTypeHintKey保存描述文件的类型统一类型标识符(UTI)(例如：kUTTypeImage,kUTTypeJPEG2000,kUTTypeTIFF,kUTTypePICT,kUTTypeGIF ,kUTTypePNG,kUTTypeQuickTimeImage，需要导入头文件#import<MobileCoreServices/MobileCoreServices.h>)
    //UNNotificationAttachmentOptionsThumbnailHiddenKey保存缩略图是否显示
    optionsDic[UNNotificationAttachmentOptionsThumbnailHiddenKey] = @(NO);
    //UNNotificationAttachmentOptionsThumbnailClippingRectKey保存缩略图的裁剪尺寸和位置
//    optionsDic[UNNotificationAttachmentOptionsThumbnailClippingRectKey] = NSStringFromCGRect(CGRectMake(0.25, 0.25, 0.5, 0.5));
    optionsDic[UNNotificationAttachmentOptionsThumbnailClippingRectKey] = (__bridge_transfer id _Nullable)(CGRectCreateDictionaryRepresentation(CGRectMake(0, 0, 0.75 ,0.75)));
    //UNNotificationAttachmentOptionsThumbnailTimeKey保存视频缩略图在整个视频中的秒数位置
    optionsDic[UNNotificationAttachmentOptionsThumbnailTimeKey] = @(2);
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"test"
                                                                                          URL:attachmentURL
                                                                                      options:optionsDic
                                                                                        error:&error];
    if (!error)
    {
        notificationContent.attachments = @[attachment];
    }
    
    //通知请求
    UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:@"com.ly.usernotification.12345"
                                                                                      content:notificationContent
                                                                                      trigger:timerTrigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest
                                                           withCompletionHandler:^(NSError * _Nullable error) {
                                                               NSLog(@"本地通知添加成功");
                                                           }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
