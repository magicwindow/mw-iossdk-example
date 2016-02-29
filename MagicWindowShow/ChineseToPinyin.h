//
//  ChineseToPinyin.h
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/2/26.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChineseToPinyin : NSObject

+ (NSString *) pinyinFromChiniseString:(NSString *)string;
+ (char) sortSectionTitle:(NSString *)string;

char pinyinFirstLetter(unsigned short hanzi);

@end
