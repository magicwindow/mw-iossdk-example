//
//  SocialShareHelper.h
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/13/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libWeChatSDK/WXApi.h>

typedef enum
{
    ShareTypeWXSession = 0,         //微信好友
    ShareTypeWXTimeline = 1,        //微信朋友圈
    //    ShareTypeSinaWeibo = 2,         //新浪微博
    //    ShareTypeQQ = 3,                //qq好友
    //    ShareTypeQQQZone = 4,           //qzone结合版
    
}MWShareType;

@interface SocialShareHelper : NSObject

- (void)sendWeChatWithScene:(MWShareType)scene Title:(NSString *)title Content:(NSString *)content ThumbImageData:(NSData *)thumbImageData Url:(NSString *)url;

@end
