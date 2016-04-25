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

- (void)getDianShangDetailResource:(void (^)(DianShangDetailDomain *domain))resource;

- (void)getO2OResource:(void (^)(O2OListDomain *domain))resource;

- (void)getO2ODetailResource:(void (^)(O2ODetailDomain *domain))resource;

- (void)getTukuResource:(void (^)(TukuDomain *domain))resource;

- (void)getTravelDetailResource:(void (^)(TravelDetailDomain *domain))resource;

@end

