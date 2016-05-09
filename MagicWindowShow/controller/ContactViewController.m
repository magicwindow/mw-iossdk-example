//
//  ContactViewController.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 5/9/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "ContactViewController.h"
#import "SocialShareHelper.h"

@interface ContactViewController ()
@property (strong, nonatomic) SocialShareHelper *socialShareHelper;
@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _socialShareHelper = [[SocialShareHelper alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)shareButtonClicked:(id)sender {
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"contact_us"], 1);
    NSData *thumbImageData = UIImageJPEGRepresentation([UIImage imageNamed:@"contact_girl"], 0.1);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享到：" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *wechatFriends = [UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.socialShareHelper sendWeChatWithScene:ShareTypeWXSession imageData: imageData ThumbImageData:thumbImageData];
    }];
    UIAlertAction *wechatMoments = [UIAlertAction actionWithTitle:@"朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.socialShareHelper sendWeChatWithScene:ShareTypeWXTimeline imageData: imageData ThumbImageData:thumbImageData];;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:wechatFriends];
    [alert addAction:wechatMoments];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
