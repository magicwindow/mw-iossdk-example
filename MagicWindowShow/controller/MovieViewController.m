//
//  MovieViewController.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/21/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "MovieViewController.h"
#import "SocialShareHelper.h"

@interface MovieViewController () <UIWebViewDelegate>
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isLoaded;
@property (strong, nonatomic) SocialShareHelper *socialShareHelper;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _progressView.progress = 0;
    _webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://documentation.magicwindow.cn/demo/video/dist/?app=1"]];
    [_webView loadRequest:request];
    _socialShareHelper = [[SocialShareHelper alloc] init];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _webView.scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    _progressView.progress = 0;
    _isLoaded = false;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _isLoaded = true;
}

- (void)timerCallback {
    if (_isLoaded) {
        if (_progressView.progress >= 1) {
            _progressView.hidden = true;
            [_timer invalidate];
        } else {
            _progressView.progress += 0.1;
        }
    } else {
        _progressView.progress += 0.01;
        if (_progressView.progress >= 0.7) {
            _progressView.progress = 0.7;
        }
    }
}
- (IBAction)shareButtonClicked:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享该页面到：" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *wechatFriends = [UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.socialShareHelper sendWeChatWithScene:ShareTypeWXSession Title:@"【魔窗Demo】在微信中一键唤起App中对应视频播放页" Content:@"若已安装过Demo，点击视频下方“下载App，享受3倍流畅度！”一键打开App观看视频" ThumbImageData:UIImagePNGRepresentation([UIImage imageNamed:@"movie_share_wechat.jpg"]) Url:@"http://documentation.magicwindow.cn/demo/video/dist"];
    }];
    UIAlertAction *wechatMoments = [UIAlertAction actionWithTitle:@"朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.socialShareHelper sendWeChatWithScene:ShareTypeWXTimeline Title:@"【魔窗Demo】在微信中一键唤起App中对应视频播放页" Content:@"若已安装过Demo，点击视频下方“下载App，享受3倍流畅度！”一键打开App观看视频" ThumbImageData:UIImagePNGRepresentation([UIImage imageNamed:@"movie_share_wechat.jpg"]) Url:@"http://documentation.magicwindow.cn/demo/video/dist/"];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:wechatFriends];
    [alert addAction:wechatMoments];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
