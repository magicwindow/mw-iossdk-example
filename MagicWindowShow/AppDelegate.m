//
//  AppDelegate.m
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/9/11.
//  Copyright (c) 2015年 cafei. All rights reserved.
//

#import "AppDelegate.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"
#import "ViewController.h"
#import <JASidePanels/UIViewController+JASidePanel.h>
#import "LeftViewController.h"
#import "CommonService.h"

@interface AppDelegate ()
{
    UIView *_view;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    CommonService *service = [CommonService new];
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if ([service isFirstLauch])
    {
        self.window.rootViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"HelpNav"];
    }
    else
    {
        self.window.rootViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SideVC"];
    }

    //注册魔窗
    [MWApi registerApp:APP_KEY];
    //注册魔窗mlink事件
    [self registerMlink];
    //添加监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeView) name:MWWebViewDidDisappearNotification object:nil];

    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //根据不同的URL路由到不同的app展示页
    [MWApi routeMLink:url];
    return [MWApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    //根据不同的URL路由到不同的app展示页
    [MWApi routeMLink:url];
    return [MWApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options
{
    //根据不同的URL路由到不同的app展示页
    [MWApi routeMLink:url];
    return [MWApi handleOpenURL:url delegate:self];
}
 
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    //根据不同的URL路由到不同的app展示页
    return [MWApi continueUserActivity:userActivity];
}

- (void)registerMlink
{
    //注册mlink default handler
    [MWApi registerMLinkDefaultHandler:^(NSURL * _Nonnull url, NSDictionary * _Nullable params) {
        
        NSLog(@"url = %@",url);
    }];
    //注册mlink key 为viewKey的handler事件
    [MWApi registerMLinkHandlerWithKey:@"viewKey" handler:^(NSURL * _Nonnull url, NSDictionary * _Nullable params) {
        
        if (params == nil)
        {
            return ;
        }
        
        NSString *viewName = params[@"view"];
        if (viewName == nil || viewName.length == 0)
        {
            return;
        }
        //接收到相应请求，打开相应的页面
        [self openNativeViewWithName:viewName];

    }];
    
    //注册mlink key 为campaignKey的handler事件
    [MWApi registerMLinkHandlerWithKey:@"campaignKey" handler:^(NSURL * _Nonnull url, NSDictionary * _Nullable params) {
        
        //魔窗位活动跳转
        if (params != nil && params[@"key"] != nil)
        {
            NSString *str = params[@"key"];
            //接收到打开魔窗位的请求，活动相关活动信息并打开活动
            [self openCampaignViewWithKey:str];
        }
    }];
}

//接收到打开魔窗位的请求，活动相关活动信息并打开活动
- (void)openCampaignViewWithKey:(NSString *)key
{
    _view = [[UIView alloc] init];
    ViewController *rootVC = (ViewController *)self.window.rootViewController;
    [rootVC.view addSubview:_view];
    
    [MWApi configAdViewWithKey:key withTarget:_view success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
        //成功获取到相关活动，并打开该活动
        [MWApi autoOpenWebViewWithKey:key withTargetView:_view];
    } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
        //没有获取到相关活动，不做任何处理
        [_view removeFromSuperview];
    }];
}

- (void)openNativeViewWithName:(NSString *)viewName
{
    ViewController *rootVC = (ViewController *)self.window.rootViewController;

    NSString *VCidentifier;
    if ([viewName isEqualToString:@"lvyou"])
    {
        VCidentifier = @"tourismNav";
    }
    else if ([viewName isEqualToString:@"O2O"])
    {
        VCidentifier = @"o2oNav";
    }
    else if ([viewName isEqualToString:@"dianshang"])
    {
        VCidentifier = @"dianShangNav";
    }
    else if ([viewName isEqualToString:@"zixun"])
    {
        VCidentifier = @"newsNav";
    }
    else if ([viewName isEqualToString:@"tuku"])
    {
        VCidentifier = @"tukuNav";
    }
    else if ([viewName isEqualToString:@"user"])
    {
        VCidentifier = @"MeNav";
    }
    
    if (VCidentifier == nil)
    {
        return;
    }
    [rootVC showLeftPanelAnimated:YES];
    [rootVC setCenterPanel:[rootVC.storyboard instantiateViewControllerWithIdentifier:VCidentifier]];
}

- (void)removeView
{
    if (_view != nil)
    {
        [_view removeFromSuperview];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
