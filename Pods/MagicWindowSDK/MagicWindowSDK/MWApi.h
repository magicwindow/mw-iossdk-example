//
//  MagicWindowApi.h
//  MagicWindowSampleApp
//
//  Created by 刘家飞 on 14/11/18.
//  Copyright (c) 2014年 MagicWindow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MWCampaignConfig.h"
#import <CoreLocation/CoreLocation.h>
#import "MWApiObject.h"

#define DEPRECATED(_version) __attribute__((deprecated))

/**
 *  当活动有更新的时候会触发该notification
 **/
#define MWUpdateCampaignNotification            @"MWUpdateCampaignNotification"
/**
 *  活动详情页面即将打开的时候会触发
 **/
#define MWWebViewWillAppearNotification         @"MWWebViewWillAppearNotification"
/**
 *  活动详情页面关闭的时候会触发
 **/
#define MWWebViewDidDisappearNotification       @"MWWebViewDidDisappearNotification"
/**
 *  @deprecated This method is deprecated starting in version 3.66
 *  @note Please use @code MWUpdateCampaignNotification @code instead.
 **/
#define MWRegisterAppSuccessedNotification      @"MWRegisterAppSuccessedNotification"  DEPRECATED(3.66)


typedef  void (^ _Nullable CallbackWithCampaignSuccess) (NSString *__nonnull key, UIView *__nonnull view, MWCampaignConfig *__nonnull campaignConfig);
typedef void (^ _Nullable CallbackWithCampaignFailure) (NSString *__nonnull key, UIView *__nonnull view, NSString *__nullable errorMessage);
typedef  NSDictionary * _Nullable (^ CallbackWithMLinkCampaign) (NSString *__nonnull key, UIView *__nonnull view);
typedef  BOOL (^ CallbackWithTapCampaign) (NSString *__nonnull key, UIView *__nonnull view);
typedef void(^ _Nullable CallBackMLink)(NSURL * __nonnull url ,NSDictionary * __nullable params);

@interface MWApi : NSObject

/**
 *  注册app
 *  需要在 application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 中调用
 *  @param appKey 魔窗后台注册的appkey
 */
+ (void)registerApp:(nonnull NSString *)appKey;

/**
 *  设置用户基本信息
 */
+ (void)setUserPhone:(nonnull NSString *)userPhone;
+ (void)setUserProfile:(nonnull MWUserProfile *)user;
/**
 * 退出登录的时候，取消当前的用户基本信息
 */
+ (void)cancelUserProfile;

/**
 *  设置渠道,默认为appStore
 *  @param channel 渠道key
 *  @return void
 */
+ (void)setChannelId:(nonnull NSString *)channel;

/** 
 *  设置是否打印sdk的log信息,默认不开启,在release情况下，不要忘记设为NO.
 */
+ (void)setLogEnable:(BOOL)enable;

/**
 *  设置是否抓取crash信息,默认开启.
 */
+ (void)setCaughtCrashesEnable:(BOOL)enable;

/**
 *  设置是否使用mlink，默认开启
 **/
+ (void)setMlinkEnable:(BOOL)enable;

/**
 * 用来获得当前sdk的版本号
 * return 返回sdk版本号
 */
+ (nonnull NSString *)sdkVersion;

#pragma mark Campaign
/**
 *  获取活动相关配置信息
 *  适用于pushViewController
 *  @param key 魔窗位key
 *  @param targetView 展示活动简介的view
 *  @param callback success 当成功获取到该魔窗位上活动的时候会调用这个回调  
 *  @param callback failure 当获取到该魔窗位上活动失败的时候会调用这个回调
 *  @return void
 */
+ (void)configAdViewWithKey:(nonnull NSString *)key withTarget:(nonnull UIView *)view
                    success:(CallbackWithCampaignSuccess)success
                    failure:(CallbackWithCampaignFailure)failure;

/**
 *  获取活动相关配置信息
 *  适用于presentViewController
 *  @param key 魔窗位key
 *  @param targetView 展示活动简介的view
 *  @param callback success 当成功获取到该魔窗位上活动的时候会调用这个回调
 *  @param callback failure 当获取到该魔窗位上活动失败的时候会调用这个回调
 *  @return void
 */
+ (void)configAdViewWithKey:(nonnull NSString *)key withTargetView:(nonnull UIView *)view withTargetViewController:(nonnull UIViewController *)controller
                    success:(CallbackWithCampaignSuccess)success
                    failure:(CallbackWithCampaignFailure)failure;

/**
 *  获取活动相关配置信息
 *  适用于所有的UIViewController
 *  @param key 魔窗位key
 *  @param target 展示活动简介的view
 *  @param callback success 当成功获取到该魔窗位上活动的时候会调用这个回调
 *  @param callback failure 当获取到该魔窗位上活动失败的时候会调用这个回调
 *  @param callback tap 当点击该魔窗位上活动的时候会调用这个回调，return YES 允许跳转，NO 不允许跳转
 *  @param callback mLinkHandler 当活动类型为mlink的时候，点击的该活动的时候，会调用这个回调，return mlink需要的相关参数
 *  @return void
 */
+ (void)configAdViewWithKey:(nonnull NSString *)key withTargetView:(nonnull UIView *)view withTargetViewController:(nullable UIViewController *)controller
                    success:(CallbackWithCampaignSuccess)success
                    failure:(CallbackWithCampaignFailure)failure
                        tap:(nullable CallbackWithTapCampaign)tap
                      mLinkHandler:(nullable CallbackWithMLinkCampaign)mLinkHandler;

/**
 *  判断单个魔窗位上是否有活动
 *  @param mwkey 魔窗位key
 *  @return yes:有处于活跃状态的活动；no：没有处于活跃状态的活动
 */
+(BOOL)isActiveOfmwKey:(nonnull NSString *)mwkey;

/**
 *  批量判断魔窗位上是否有活动
 *  @param mwKeys 魔窗位数组
 *  @return 有活动的魔窗位数组
 */
+(nullable NSArray *)mwkeysWithActiveCampign:(nonnull NSArray *)mwKeys;

/**
 *  自动打开webView,显示活动
 *  只有在成功获取到活动信息的时候，该方法才有效
 *  @param key 魔窗位key
 *  @return void
 */
+ (void)autoOpenWebViewWithKey:(nonnull NSString *)key withTargetView:(nonnull UIView *)view;

/**
 *  判断是否发送webview的相关通知（进入webView，关闭webView）
 *  只有在成功获取到活动信息的时候，该方法才有效
 *  @param enable YES:打开，NO:关闭。默认状态为NO
 *  @return void
 */
+ (void)setWebViewNotificationEnable:(BOOL)enable;

/**
 *  是否自定义活动详情页面的导航条按钮
 *  @param enable YES:自定义，NO:不自定义。默认状态为NO
 *  @return void
 */
+ (void)setWebViewBarEditEnable:(BOOL)enable;


#pragma mark Custom event

/**
 *  标识某个页面访问的开始，在合适的位置调用,name不能为空。
 *  @param name 页面的唯一标示，不能为空
 *  @return void
 */
+ (void)pageviewStartWithName:(nonnull NSString *)name;
/**
 *  标识某个页面访问的结束，与pageviewStartWithName配对使用，请参见Example程序，在合适的位置调用，name不能为空。
 */
+ (void)pageviewEndWithName:(nonnull NSString *)name;

/**
 * 自定义事件
 */
+ (void)setCustomEvent:(nonnull NSString *)eventId;

/**
 * 自定义事件
 */
+ (void)setCustomEvent:(nonnull NSString *)eventId attributes:(nullable NSDictionary *)attributes;


#pragma mark Location
/**
 *  设置经纬度信息
 *  @param latitude 纬度
 *  @param longitude 经度
 *  @return void
 */
+ (void)setLatitude:(double)latitude longitude:(double)longitude;

/** 
 *  设置经纬度信息
 *  @param location CLLocation 经纬度信息
 *  @return void
 */
+ (void)setLocation:(nonnull CLLocation *)location;

/**
 *  设置城市编码，以便获取相应城市的活动数据，目前仅支持到地级市
 *  国家标准的行政区划代码:http://files2.mca.gov.cn/www/201510/20151027164514222.htm
 *  @param code 城市编码
 *  @return void
 */
+ (void)setCityCode:(nonnull NSString *)code;

#pragma mark Share

/**
 *  处理第三方app通过URL启动App时传递的数据
 *
 *  需要在 application:handleOpenURL中调用。
 *  @param url 启动App的URL
 *  @param delegate对象，用来接收第三方app触发的消息。
 *  @return 成功返回YES，失败返回NO。
 */
+ (BOOL)handleOpenURL:(nonnull NSURL *)url delegate:(nullable id)delegate;

/**
 *  @deprecated This method is deprecated starting in version 3.66
 *  @note Please use @code handleOpenURL:delegate: @code instead.
 **/
+ (BOOL)handleOpenURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nullable id)annotation delegate:(nullable id)delegate DEPRECATED(3.66);

#pragma mark mLink
/**
 * 注册一个mlink handler，当接收到mlinkUrl的时候，会调用handler
 * 需要在 application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 中调用
 * @param key 后台注册mlink时生成的mlink key
 * @param handler mlink的回调
 */
+ (void)registerMLinkHandlerWithKey:(nonnull NSString *)key handler:(CallBackMLink)handler;

/**
 * 注册一个默认的mlink handler
 * 需要在 application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 中调用
 * @param handler mlink的回调
 */
+ (void)registerMLinkDefaultHandler:(CallBackMLink)handler;

/**
 * 根据不同的URL路由到不同的app展示页
 * 需要在 application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 中调用
 * @param url 传入上面方法中的openUrl
 */
+ (void)routeMLink:(nonnull NSURL *)url;

/**
 *  根据universal link路由到不同的app展示页
 *  需要在 application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler 中调用
 *  @param userActivity 传入上面方法中的userActivity
 */
+ (BOOL)continueUserActivity:(nonnull NSUserActivity *)userActivity;

@end
