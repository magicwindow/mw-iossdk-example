//
//  OpenService.m
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/3/2.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "OpenService.h"

#define SERVICE_HEAD_LIST                       @"headList"
#define SERVICE_CONTENT_LIST                    @"contentList"
#define SERVICE_MIDDLE_LIST                     @"middleList"
#define SERVICE_INTERNET_LIST                   @"internetList"
#define SERVICE_SPORT_LIST                      @"sportList"
#define SERVICE_ENTERTAINMENT_LIST              @"entertainmentList"
#define SERVICE_DESC                            @"desc"
#define SERVICE_RESOURCE                        @"resource"
#define SERVICE_TITLE                           @"title"
#define SERVICE_URL                             @"url"

@implementation OpenService

- (void)GET:(NSString *)URLString localPath:(NSString *)fileName
    success:(void (^)(NSDictionary *responseObject))success
    failure:(void (^)(NSError *connectionError))failure
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",URLString]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            NSString *path =[[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
            data = [NSData dataWithContentsOfFile:path];
        }
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (object != nil && [object isKindOfClass:[NSDictionary class]])
        {
            success(object);
        }
        else
        {
            NSString *path =[[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
            data = [NSData dataWithContentsOfFile:path];
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            success(object);
        }
    }];
}

- (NSArray *)parseList:(id)object
{
    __block NSMutableArray *list = [NSMutableArray new];
    [object enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaseDomain *domain = [[BaseDomain alloc] init];
        domain.desc = obj[SERVICE_DESC];
        domain.imgUrl = obj[SERVICE_RESOURCE];
        domain.title = obj[SERVICE_TITLE];
        domain.url = obj[SERVICE_URL];
        [list addObject:domain];
    }];
    return list;
}

- (TourismDomain *)parseTourismResource:(NSDictionary *)responseObject
{
    TourismDomain *tourism = [[TourismDomain alloc] init];
    tourism.headList = responseObject[SERVICE_HEAD_LIST];
    tourism.contentList = [self parseList:responseObject[SERVICE_CONTENT_LIST]];
    return tourism;
}

- (NewsDomain *)parseNewsResource:(NSDictionary *)responseObject
{
    NewsDomain *newsDomain = [[NewsDomain alloc] init];
    newsDomain.internetList = [self parseList:responseObject[SERVICE_INTERNET_LIST]];
    newsDomain.sportList = [self parseList:responseObject[SERVICE_SPORT_LIST]];
    newsDomain.entertainmentList = [self parseList:responseObject[SERVICE_ENTERTAINMENT_LIST]];
    return newsDomain;
}

- (DianShangDomain *)parseDianShangResource:(NSDictionary *)responseObject
{
    DianShangDomain *dianshangDomain = [[DianShangDomain alloc] init];
    dianshangDomain.headList = responseObject[SERVICE_HEAD_LIST];
    dianshangDomain.middleList = responseObject[SERVICE_MIDDLE_LIST];
    dianshangDomain.contentList = [self parseList:responseObject[SERVICE_CONTENT_LIST]];
    return dianshangDomain;
}

- (O2ODomain *)parseO2OResource:(NSDictionary *)responseObject
{
    O2ODomain *o2oDomain = [[O2ODomain alloc] init];
    o2oDomain.headList = responseObject[SERVICE_HEAD_LIST];
    o2oDomain.contentList = responseObject[SERVICE_CONTENT_LIST];
    return o2oDomain;
}

- (TukuDomain *)parseTukuResource:(NSDictionary *)responseObject
{
    TukuDomain *tukuDomain = [[TukuDomain alloc]init];
    tukuDomain.contentList = [self parseList:responseObject];
    return tukuDomain;
}


@end
