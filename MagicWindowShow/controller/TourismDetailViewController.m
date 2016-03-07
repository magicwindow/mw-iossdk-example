//
//  TourismDetailViewController.m
//  MagicWindowShow
//  旅游详情页－三亚
//  Created by 刘家飞 on 16/1/23.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "TourismDetailViewController.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"
#import "UIImageView+WebCache.h"

@interface DetailBtnCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *btnView;

@end

@implementation DetailBtnCell

@end

@interface DetailBannerCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *uberView;

@end

@implementation DetailBannerCell


@end

@interface TourismDetailViewController ()
{
    NSArray *_bottomViewList;
}

@end

@implementation TourismDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *list = @[Home_detail_hotel,Home_detail_plane,Home_detail_dianping];
    _bottomViewList = [MWApi mwkeysWithActiveCampign:list];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2 + ((_bottomViewList == nil || _bottomViewList.count == 0)? 0:1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0)
    {
        NSString *identifier = @"detailBannerCell";
        DetailBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if ([MWApi isActiveOfmwKey:Home_detail_uber])
        {
            [MWApi configAdViewWithKey:Home_detail_uber withTargetView:cell.uberView withTargetViewController:self success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                
                [cell.uberView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:@"uber"]];
            } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                
            } tap:nil mLinkHandler:^NSDictionary * _Nullable(NSString * _Nonnull key, UIView * _Nonnull view) {
                return nil;
            }];
        }
        else
        {
            cell.uberView.hidden = YES;
        }
        
        return cell;
    }
    else if (indexPath.row == 1)
    {
        NSString *identifier = @"TourismCell";
        [tableView registerNib:[UINib nibWithNibName:@"TourismCell" bundle:nil] forCellReuseIdentifier:@"TourismCell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

        return cell;
    }
//    else
//    {
//        NSString *identifier = @"DetailBtnCell";
//        DetailBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        [MWApi configAdViewWithKey:Home_detail_01 withTargetView:cell.btnView withTargetViewController:self success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
//            [cell.btnView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:@"sanya_btn"]];
//        } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
//            
//            cell.btnView.hidden = YES;
//        } tap:nil mLinkHandler:^NSDictionary * _Nullable(NSString * _Nonnull key, UIView * _Nonnull view) {
//            return nil;
//        }];
//        
//        return cell;
//    }
    else
    {
        NSString *identifier = @"BtnCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        float btnWidth = 80;
        float btnHeiht = 100;
        float spaceWidth = (CGRectGetWidth(tableView.frame)-btnWidth*_bottomViewList.count)/(_bottomViewList.count+1);
        
        [_bottomViewList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceWidth+(btnWidth+spaceWidth)*idx, 35, btnWidth, btnHeiht)];
            [cell addSubview:imgView];
            
            [MWApi configAdViewWithKey:obj withTargetView:imgView withTargetViewController:self success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                
                [imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
            } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                
                imgView.hidden = YES;
            } tap:nil mLinkHandler:^NSDictionary * _Nullable(NSString * _Nonnull key, UIView * _Nonnull view) {
                return nil;
            }];

        }];

        return cell;
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    switch (indexPath.row) {
        case 0:
        {
            height = CGRectGetWidth(tableView.frame)*244/400;
            break;
        }
        case 1:
        {
            height = CGRectGetWidth(tableView.frame)*357/400;
            break;
        }
        default:
            height = 200;
            break;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
