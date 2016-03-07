//
//  ResourceService.h
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/3/3.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowDomain.h"

@interface ResourceService : NSObject

+ (id)sharedInstance;

- (void)getTourismResource:(void (^)(TourismDomain *domain))resource;

- (void)getNewsResource:(void (^)(NewsDomain *domain))resource;

- (void)getDianShangResource:(void (^)(DianShangDomain *domain))resource;

- (void)getO2OResource:(void (^)(O2ODomain *domain))resource;

- (void)getTukuResource:(void (^)(TukuDomain *domain))resource;

@end

