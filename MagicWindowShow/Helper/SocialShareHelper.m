//
//  SocialShareHelper.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/13/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "SocialShareHelper.h"

@implementation SocialShareHelper

- (void)sendWeChatWithScene:(MWShareType)scene Title:(NSString *)title Content:(NSString *)content ThumbImageData:(NSData *)thumbImageData Url:(NSString *)url
{
    [self sendLinkContentToWeChatWithWithScene:(MWShareType)scene Title:title Content:content ThumbImageData:thumbImageData Url:url];
}


- (void)sendLinkContentToWeChatWithWithScene:(MWShareType)scene Title:(NSString *)title
                                     Content:(NSString *)content
                              ThumbImageData:(NSData *)thumbImageData
                                         Url:(NSString *)url
{
    WXMediaMessage *message = [[WXMediaMessage alloc] init];
    message.title = title;
    message.description = content;
    message.thumbData = thumbImageData;
    
    WXWebpageObject *webObj = [[WXWebpageObject alloc] init];
    webObj.webpageUrl = url;
    
    message.mediaObject = webObj;
    [self sendMediaMessageToWXWithWithScene:(MWShareType)scene Message:message];
}

- (void)sendMediaMessageToWXWithWithScene:(MWShareType)scene Message:(WXMediaMessage *)message
{
    int wxScene = -1;
    switch (scene) {
        case ShareTypeWXSession:
        {
            wxScene = WXSceneSession;
            break;
        }
        case ShareTypeWXTimeline:
        {
            wxScene = WXSceneTimeline;
            break;
        }
            
        default:
            break;
    }
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = wxScene;
    [WXApi sendReq:req];
}

@end
