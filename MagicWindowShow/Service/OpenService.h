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

- (O2ODomain *)parseO2OResource:(NSDictionary *)responseObject;

- (TukuDomain *)parseTukuResource:(NSDictionary *)responseObject;

@end
