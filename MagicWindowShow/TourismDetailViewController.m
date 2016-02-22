//
//  TourismDetailViewController.m
//  MagicWindowShow
//
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

@interface TourismDetailViewController ()

@end

@implementation TourismDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0)
    {
        NSString *identifier = @"detailBannerCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        NSString *identifier = @"TourismCell";
        [tableView registerNib:[UINib nibWithNibName:@"TourismCell" bundle:nil] forCellReuseIdentifier:@"TourismCell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        return cell;
    }
    else
    {
        NSString *identifier = @"DetailBtnCell";
        DetailBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        [MWApi configAdViewWithKey:Home_detail_01 withTargetView:cell.btnView withTargetViewController:self success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
            [cell.btnView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:@"sanya_btn"]];
        } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
            
        } tap:nil mLinkHandler:^NSDictionary * _Nullable(NSString * _Nonnull key, UIView * _Nonnull view) {
            return nil;
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
            height = CGRectGetWidth(tableView.frame)*104/400;
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
