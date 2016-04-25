//
//  DiaperDetailController.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/8/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "DiaperDetailController.h"
#import "GoodsShowCell.h"
#import "SocialShareHelper.h"
#import "UIImageView+WebCache.h"
#import "ResourceService.h"

@interface LongPictureCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imgView;

@end

@implementation LongPictureCell

@end

@interface DiaperDetailController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) SocialShareHelper *socialShareHelper;
@property (strong, nonatomic) DianShangDetailDomain *dianshangDetailResource;
@end

@implementation DiaperDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.socialShareHelper = [[SocialShareHelper alloc] init];
    
    [[ResourceService sharedInstance] getDianShangDetailResource:^(DianShangDetailDomain *domain) {
        _dianshangDetailResource = domain;
        [_tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        [cell.imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imgview = (UIImageView *)obj;
            [imgview sd_setImageWithURL:[NSURL URLWithString:_dianshangDetailResource.headList[idx]] placeholderImage:nil];
        }];
        return cell;
    } else if (indexPath.row == 1) {
        NSString *identifier = @"OtherInfoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        return cell;
    } else {
        NSString *identifier = @"LongPictureCell";
        LongPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_dianshangDetailResource.contentImgUrl] placeholderImage:nil];
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

- (IBAction)shareButtonClicked:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享该页面到：" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *wechatFriends = [UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.socialShareHelper sendWeChatWithScene:ShareTypeWXSession Title:@"HUGGIES好奇银装纸尿裤促销中" Content:@"美国品牌，妈妈们的第一选择！" ThumbImageData:UIImagePNGRepresentation([UIImage imageNamed:@"share-wechat"]) Url:@"http://documentation.magicwindow.cn/demo/49/index.html"];
    }];
    UIAlertAction *wechatMoments = [UIAlertAction actionWithTitle:@"朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.socialShareHelper sendWeChatWithScene:ShareTypeWXTimeline Title:@"HUGGIES好奇银装纸尿裤促销中" Content:@"美国品牌，妈妈们的第一选择！" ThumbImageData:UIImagePNGRepresentation([UIImage imageNamed:@"share-wechat"]) Url:@"http://documentation.magicwindow.cn/demo/49/index.html"];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:wechatFriends];
    [alert addAction:wechatMoments];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
