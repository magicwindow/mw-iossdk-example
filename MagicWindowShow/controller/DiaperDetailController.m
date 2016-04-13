//
//  DiaperDetailController.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/8/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "DiaperDetailController.h"
#import "GoodsShowCell.h"
#import <libWeChatSDK/WXApi.h>

typedef enum
{
    ShareTypeWXSession = 0,         //微信好友
    ShareTypeWXTimeline = 1,        //微信朋友圈
    //    ShareTypeSinaWeibo = 2,         //新浪微博
    //    ShareTypeQQ = 3,                //qq好友
    //    ShareTypeQQQZone = 4,           //qzone结合版
    
}MWShareType;

@interface DiaperDetailController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation DiaperDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabelViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *identifier = @"GoodsShowCell";
        [tableView registerNib:[UINib nibWithNibName:@"GoodsShowCell" bundle:nil] forCellReuseIdentifier:identifier];
        GoodsShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell setupCellWithImageWidth:self.view.frame.size.width];
        return cell;
    } else if (indexPath.row == 1) {
        NSString *identifier = @"OtherInfoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        return cell;
    } else {
        NSString *identifier = @"LongPictureCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
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
            height = CGRectGetWidth(tableView.frame)*400/400 + 109 + 10;
            break;
        }
        case 1:
        {
            height = 128;
            break;
        }
        case 2:
        {
            height = CGRectGetWidth(tableView.frame)*10213/640;
            break;
        }
        case 4:
        {
            height = 45 + (CGRectGetWidth(tableView.frame)*120/400)*2 + 32;
            break;
        }
        default:
            height = CGRectGetWidth(tableView.frame)*326/400;
            break;
    }
    return height;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)shareButtonClicked:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享该页面到：" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *wechatFriends = [UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sendWeChatWithScene:ShareTypeWXSession Title:@"HUGGIES好奇银装纸尿裤促销中" Content:@"美国品牌，妈妈们的第一选择！" ThumbImageData:UIImagePNGRepresentation([UIImage imageNamed:@"share-wechat"]) Url:@"http://documentation.magicwindow.cn/demo/49/index.html"];
    }];
    UIAlertAction *wechatMoments = [UIAlertAction actionWithTitle:@"朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sendWeChatWithScene:ShareTypeWXTimeline Title:@"HUGGIES好奇银装纸尿裤促销中" Content:@"美国品牌，妈妈们的第一选择！" ThumbImageData:UIImagePNGRepresentation([UIImage imageNamed:@"share-wechat"]) Url:@"http://documentation.magicwindow.cn/demo/49/index.html"];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:wechatFriends];
    [alert addAction:wechatMoments];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark Wechat
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
