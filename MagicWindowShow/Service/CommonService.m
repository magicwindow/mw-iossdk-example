//
//  CommonService.m
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/2/19.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "CommonService.h"
#import <UIKit/UIKit.h>

#define KEY_FIRST_LAUCH             @"key_first_lauch"
#define KEY_LVYOU_FIRST_LAUCH       @"key_lvyou_first_lauch"
#define KEY_DIANSHANG_FIRST_LAUCH   @"key_dianshang_first_lauch"
#define KEY_USER_NAME               @"key_user_name"

@implementation CommonService

- (BOOL)isFirstLauch
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id firstObj = [defaults objectForKey:KEY_FIRST_LAUCH];
    if (firstObj == nil)
    {
        [defaults setBool:NO forKey:KEY_FIRST_LAUCH];
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isLvyouFirstLauch
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id firstObj = [defaults objectForKey:KEY_LVYOU_FIRST_LAUCH];
    if (firstObj == nil)
    {
        [defaults setBool:NO forKey:KEY_LVYOU_FIRST_LAUCH];
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isDianshangFirstLauch
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id firstObj = [defaults objectForKey:KEY_DIANSHANG_FIRST_LAUCH];
    if (firstObj == nil)
    {
        [defaults setBool:NO forKey:KEY_DIANSHANG_FIRST_LAUCH];
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)saveUserName:(NSString *)userName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (userName != nil && userName.length > 0)
    {
        [defaults setObject:userName forKey:KEY_USER_NAME];
    }
    else
    {
        [defaults removeObjectForKey:KEY_USER_NAME];
    }
}

- (BOOL)hasLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:KEY_USER_NAME] != nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSString *)getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (void)checkUpdate {
    NSURL *url = [NSURL URLWithString:@"http://demoapp.test.magicwindow.cn/v1/demoapp/checkUpdate"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *parameter = @{@"os":@"1", @"currentVersion":[self getAppVersion]};
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameter options:0 error:&error];
    [request setHTTPBody:postData];
    
    NSLog(@"currentVersion:%@", [self getAppVersion]);
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error:%@", error);
            return;
        } else {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", json);
            NSDictionary *result = [json objectForKey:@"result"];
            if (result) {
                BOOL shouldUpgrade = [[result objectForKey:@"upgrade"] boolValue];
                BOOL isForceUpgrade = [[result objectForKey:@"forceUpgrade"] boolValue];
                NSString *newVersionUrl = [result objectForKey:@"newVersionUrl"];
                NSString * desc = [result objectForKey:@"desc"];
                desc = [desc stringByReplacingOccurrencesOfString:@"<span>" withString:@""];
                desc = [desc stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
                desc = [desc stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
                if (!shouldUpgrade) {
                    return;
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self handleUpgrade:isForceUpgrade withMessage:desc withUrl:newVersionUrl];
                    });
                }
            }
        }
    }];
    [dataTask resume];
}

- (void)handleUpgrade:(BOOL)isForceUpgrade withMessage:(NSString *)message withUrl:(NSString *)url {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"检测到新版本" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *update = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }];
    UIAlertAction *forceUpdate = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]]; 
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    if (isForceUpgrade) {
        [alert addAction:forceUpdate];
    } else {
        [alert addAction:update];
        [alert addAction:cancel];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
