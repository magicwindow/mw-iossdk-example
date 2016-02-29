//
//  CommonService.h
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/2/19.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonService : NSObject

- (void)saveUserName:(nullable NSString *)userName;
- (BOOL)hasLogin;

@end
