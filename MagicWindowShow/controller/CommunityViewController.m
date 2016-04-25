//
//  CommunityViewController.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/14/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "CommunityViewController.h"
#import "SocialShareHelper.h"
#import "CommunityShowCell.h"

@interface CommunityViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) SocialShareHelper *socialShareHelper;
@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
    self.socialShareHelper = [[SocialShareHelper alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillDisappear:animated];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *identifier = @"CommunityShowCell";
        [tableView registerNib:[UINib nibWithNibName:@"CommunityShowCell" bundle:nil] forCellReuseIdentifier:identifier];
        CommunityShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        return cell;
    } else if (indexPath.row == 1) {
        NSString *identifier = @"CommunityAuthorCell";
        [tableView registerNib:[UINib nibWithNibName:@"CommunityAuthorCell" bundle:nil] forCellReuseIdentifier:identifier];
        CommunityShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        return cell;
    } else {
        NSString *identifier = @"CommunityCommentCell";
        [tableView registerNib:[UINib nibWithNibName:@"CommunityCommentCell" bundle:nil] forCellReuseIdentifier:identifier];
        CommunityShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    switch (indexPath.row) {
        case 0:
        {
            height = (CGRectGetWidth(tableView.frame) - 24)*250/376 + 350;
            break;
        }
        case 1:
        {
            height = 110;
            break;
        }
        case 2:
        {
            height = 310;
            break;
        }
        default:
            height = 0;
            break;
    }
    return height;
}

#pragma mark - IBActions

- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareButtonClicked:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享该页面到：" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *wechatFriends = [UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.socialShareHelper sendWeChatWithScene:ShareTypeWXSession Title:@"【魔窗Demo】在微信中一键唤起App中对应帖子页" Content:@"若已安装过Demo，点击评论下方“查看所有评论”，一键打开App中的帖子查看详情" ThumbImageData:UIImagePNGRepresentation([UIImage imageNamed:@"community_share_wechat"]) Url:@"http://documentation.magicwindow.cn/demo/community/dist/"];
    }];
    UIAlertAction *wechatMoments = [UIAlertAction actionWithTitle:@"朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.socialShareHelper sendWeChatWithScene:ShareTypeWXTimeline Title:@"【魔窗Demo】在微信中一键唤起App中对应帖子页" Content:@"若已安装过Demo，点击评论下方“查看所有评论”，一键打开App中的帖子查看详情" ThumbImageData:UIImagePNGRepresentation([UIImage imageNamed:@"community_share_wechat"]) Url:@"http://documentation.magicwindow.cn/demo/community/dist/"];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:wechatFriends];
    [alert addAction:wechatMoments];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
