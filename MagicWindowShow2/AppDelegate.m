//
//  AppDelegate.m
//  MagicWindowShow2
//
//  Created by 刘家飞 on 16/2/25.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobalDefine.h"
#import <MagicWindowSDK/MWApi.h>
#import "GoodsDetailViewController.h"
#import "CommonService.h"
#import "LoginViewController2.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //注册魔窗
    [MWApi registerApp:APP_KEY];
    //注册魔窗mlink事件
    [self registerMlink];
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
    UINavigationController *rootVC = (UINavigationController *)self.window.rootViewController;
    [MWApi registerMLinkDefaultHandler:^(NSURL * _Nonnull url, NSDictionary * _Nullable params) {
        NSLog(@"default handler with url = %@",[url absoluteString]);
    }];
    
    [MWApi registerMLinkHandlerWithKey:@"goodsDetailKey" handler:^(NSURL * _Nonnull url, NSDictionary * _Nullable params) {
        
        CommonService *service = [[CommonService alloc] init];
        if ([service hasLogin])
        {
            GoodsDetailViewController *detailVC = [rootVC.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            detailVC.name1 = params[@"name1"];
            detailVC.name2 = params[@"name2"];
            detailVC.name3 = params[@"name3"];
            [rootVC pushViewController:detailVC animated:YES];
        }
        else
        {
            LoginViewController2 *loginVC = (LoginViewController2 *)rootVC.topViewController;
            loginVC.isMlink = YES;
            loginVC.name1 = params[@"name1"];
            loginVC.name2 = params[@"name2"];
            loginVC.name3 = params[@"name3"];
        }
        
    }];

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
