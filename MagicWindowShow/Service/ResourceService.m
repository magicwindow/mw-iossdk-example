//
//  ShowService.m
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/3/3.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "ResourceService.h"
#import "OpenService.h"

@interface ResourceService ()
{
    TourismDomain *_tourismDomain;
    NewsDomain *_newsDomain;
    DianShangDomain *_dianshangDomain;
    O2OListDomain *_o2oDomain;
    TukuDomain *_tukuDomain;
    O2ODetailDomain *_o2oDetailDomain;
    DianShangDetailDomain *_dianShangDetailDomain;
    TravelDetailDomain *_travelDetailDomain;
}

@end

@implementation ResourceService

+ (id)sharedInstance
{
    static ResourceService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[ResourceService alloc] init];
    });
    return service;
}

- (void)getTourismResource:(void (^)(TourismDomain *domain))resource
{
    if (_tourismDomain != nil)
    {
        resource(_tourismDomain);
        return;
    }
    
    OpenService *service = [[OpenService alloc] init];
    [service GET:@"http://121.40.195.177/list/travelList.json" localPath:@"travelList" success:^(NSDictionary *responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            TourismDomain *tourism = [service parseTourismResource:responseObject];
            _tourismDomain = tourism;
            resource(tourism);
        });
        
    } failure:^(NSError *connectionError) {
        //
    }];
}

- (void)getNewsResource:(void (^)(NewsDomain *domain))resource
{
    if (_newsDomain != nil)
    {
        resource(_newsDomain);
        return;
    }
    
    OpenService *service = [[OpenService alloc] init];
    [service GET:@"http://121.40.195.177/list/newsList.json" localPath:@"newsList" success:^(NSDictionary *responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NewsDomain *domain = [service parseNewsResource:responseObject];
            _newsDomain = domain;
            resource(domain);
        });
        
    } failure:^(NSError *connectionError) {
        //
    }];
}

- (void)getDianShangResource:(void (^)(DianShangDomain *domain))resource
{
    if (_dianshangDomain != nil)
    {
        resource(_dianshangDomain);
        return;
    }
    
    OpenService *service = [[OpenService alloc] init];
    [service GET:@"http://121.40.195.177/list/businessList.json" localPath:@"businessList" success:^(NSDictionary *responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            DianShangDomain *domain = [service parseDianShangResource:responseObject];
            _dianshangDomain = domain;
            resource(domain);
        });
        
    } failure:^(NSError *connectionError) {
        //
    }];
}

- (void)getDianShangDetailResource:(void (^)(DianShangDetailDomain *))resource
{
    if (_dianShangDetailDomain != nil)
    {
        resource(_dianShangDetailDomain);
        return;
    }
    
    OpenService *service = [[OpenService alloc] init];
    [service GET:@"http://121.40.195.177/list/shopDetail.json" localPath:@"shopDetail" success:^(NSDictionary *responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            DianShangDetailDomain *domain = [service parseDianShangDetailResource:responseObject];
            _dianShangDetailDomain = domain;
            resource(domain);
        });
        
    } failure:^(NSError *connectionError) {
        //
    }];
}

- (void)getO2OResource:(void (^)(O2OListDomain *domain))resource
{
    if (_o2oDomain != nil)
    {
        resource(_o2oDomain);
        return;
    }
    
    OpenService *service = [[OpenService alloc] init];
    [service GET:@"http://121.40.195.177/list/o2oList.json" localPath:@"o2oList" success:^(NSDictionary *responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            O2OListDomain *domain = [service parseO2OResource:responseObject];
            _o2oDomain = domain;
            resource(domain);
        });
        
    } failure:^(NSError *connectionError) {
        //
    }];
}

- (void)getO2ODetailResource:(void (^)(O2ODetailDomain *))resource
{
    if (_o2oDetailDomain != nil)
    {
        resource(_o2oDetailDomain);
        return;
    }
    
    OpenService *service = [[OpenService alloc] init];
    [service GET:@"http://121.40.195.177/list/o2oDetail.json" localPath:@"o2oDetail" success:^(NSDictionary *responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            O2ODetailDomain *domain = [service parseO2ODetailResource:responseObject];
            _o2oDetailDomain = domain;
            resource(domain);
        });
        
    } failure:^(NSError *connectionError) {
        //
    }];
}

- (void)getTukuResource:(void (^)(TukuDomain *domain))resource
{
    if (_tukuDomain != nil)
    {
        resource(_tukuDomain);
        return;
    }
    
    OpenService *service = [[OpenService alloc] init];
    [service GET:@"http://121.40.195.177/list/picList.json" localPath:@"picList" success:^(NSDictionary *responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            TukuDomain *domain = [service parseTukuResource:responseObject];
            _tukuDomain = domain;
            resource(domain);
        });
        
    } failure:^(NSError *connectionError) {
        //
    }];
}

- (void)getTravelDetailResource:(void (^)(TravelDetailDomain *))resource
{
    if (_travelDetailDomain != nil)
    {
        resource(_travelDetailDomain);
        return;
    }
    
    OpenService *service = [[OpenService alloc] init];
    [service GET:@"http://121.40.195.177/list/travelDetail.json" localPath:@"travelDetail" success:^(NSDictionary *responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            TravelDetailDomain *domain = [service parseTravelDetailResource:responseObject];
            _travelDetailDomain = domain;
            resource(domain);
        });
        
    } failure:^(NSError *connectionError) {
        //
    }];
}

@end
