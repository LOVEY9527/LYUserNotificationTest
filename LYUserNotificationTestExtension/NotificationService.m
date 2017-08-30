//
//  NotificationService.m
//  LYUserNotificationTestExtension
//
//  Created by 李勇 on 17/7/11.
//  Copyright © 2017年 李勇. All rights reserved.
//

#import "NotificationService.h"
//#import "UIImageView+WebCache.h"
#import <UIKit/UIKit.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler
{
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    if ([request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
//        NSInteger originalBadge = [[UIApplication sharedApplication] applicationIconBadgeNumber];
//        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:originalBadge + request.content.badge];
    }
//    NSURL *localURL = [[NSBundle mainBundle] URLForResource:@"pic" withExtension:@"jpg"];
//    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"test"
//                                                                                          URL:localURL
//                                                                                      options:nil
//                                                                                        error:nil];
//    self.bestAttemptContent.attachments = @[attachment];
    NSString *imgUrl = [NSString stringWithFormat:@"%@", request.content.userInfo[@"imageURL"]];
    if ([imgUrl length] > 0)
    {
        [self loadAttachmentForUrlString:imgUrl withType:@"image" completionHandle:^(UNNotificationAttachment *attach) {
            
            if (attach)
            {
                self.bestAttemptContent.attachments = [NSArray arrayWithObject:attach];
            }
            self.contentHandler(self.bestAttemptContent);
            
        }];
    }else
    {
        self.contentHandler(self.bestAttemptContent);
    }
}

- (void)loadAttachmentForUrlString:(NSString *)urlStr
                          withType:(NSString *)type
                  completionHandle:(void(^)(UNNotificationAttachment *attach))completionHandler
{
    __block UNNotificationAttachment *attachment = nil;
    NSURL *attachmentURL = [NSURL URLWithString:urlStr];
    NSString *fileExt = [self fileExtensionForMediaType:type];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session downloadTaskWithURL:attachmentURL
                completionHandler:^(NSURL *temporaryFileLocation, NSURLResponse *response, NSError *error) {
                    if (error != nil) {
                        NSLog(@"%@", error.localizedDescription);
                    } else {
                        NSFileManager *fileManager = [NSFileManager defaultManager];
                        NSURL *localURL = [NSURL fileURLWithPath:[temporaryFileLocation.path stringByAppendingString:fileExt]];
                        [fileManager moveItemAtURL:temporaryFileLocation toURL:localURL error:&error];
                        
                        NSError *attachmentError = nil;
                        attachment = [UNNotificationAttachment attachmentWithIdentifier:@"" URL:localURL options:nil error:&attachmentError];
                        if (attachmentError) {
                            NSLog(@"%@", attachmentError.localizedDescription);
                        }
                    }
                    completionHandler(attachment);
                }] resume];
    
}

- (NSString *)fileExtensionForMediaType:(NSString *)type {
    NSString *ext = type;
    if ([type isEqualToString:@"image"]) {
        ext = @"jpg";
    }
    if ([type isEqualToString:@"video"]) {
        ext = @"mp4";
    }
    if ([type isEqualToString:@"audio"]) {
        ext = @"mp3";
    }
    return [@"." stringByAppendingString:ext];
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
