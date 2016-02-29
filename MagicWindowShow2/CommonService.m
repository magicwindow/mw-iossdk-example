//
//  CommonService.m
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/2/19.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "CommonService.h"

#define KEY_USER_NAME               @"key_user_name"

@implementation CommonService

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

@end
