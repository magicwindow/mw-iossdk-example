//
//  WebViewController.h
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/17.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
{
    IBOutlet UIWebView *_webView;
}

@property (nonatomic, strong) NSString *url;

@end
