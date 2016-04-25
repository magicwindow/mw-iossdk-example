//
//  OpenService.h
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/3/2.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowDomain.h"

@interface OpenService : NSObject

- (void)GET:(NSString *)URLString localPath:(NSString *)fileName success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *connectionError))failure;

- (TourismDomain *)parseTourismResource:(NSDictionary *)responseObject;

- (NewsDomain *)parseNewsResource:(NSDictionary *)responseObject;

- (DianShangDomain *)parseDianShangResource:(NSDictionary *)responseObject;

- (DianShangDetailDomain *)parseDianShangDetailResource:(NSDictionary *)responseObject;

- (O2OListDomain *)parseO2OResource:(NSDictionary *)responseObject;

- (O2ODetailDomain *)parseO2ODetailResource:(NSDictionary *)responseObject;

- (TukuDomain *)parseTukuResource:(NSDictionary *)responseObject;

- (TravelDetailDomain *)parseTravelDetailResource:(NSDictionary *)responseObject;

@end
