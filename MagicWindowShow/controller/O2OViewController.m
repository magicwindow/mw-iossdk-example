//
//  O2OViewController.m
//  MagicWIndowShow
//  O2O页面
//  Created by 刘家飞 on 15/12/18.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "O2OViewController.h"
#import "BannerScrollCell.h"
#import "BtnView.h"
#import "ImageTableCell.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"
#import "UIImageView+WebCache.h"
#import "O2ODetailViewController.h"
#import "BtnViewCell.h"
#import "ResourceService.h"

#define BtnViewCellHeight                   114
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width

@interface O2OViewController ()
{
    NSMutableDictionary *_mwkeyDic;
    IBOutlet UITableView *_tableView;
}

@property (nonatomic, strong) O2ODomain *o2oResource;

@end

@implementation O2OViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[ResourceService sharedInstance] getO2OResource:^(O2ODomain *domain) {
        
        _o2oResource = domain;
        [_tableView reloadData];
        _tableView.hidden = NO;
    }];
    
    _mwkeyDic = [[NSMutableDictionary alloc] init];
    NSArray *list = [MWApi mwkeysWithActiveCampign:@[O2O_banner01,O2O_banner02,O2O_banner03,O2O_banner04,O2O_00_01,O2O_00_02,O2O_00_03,O2O_00_04,O2O_middle_01,O2O_middle_02,O2O_middle_03]];
    if (list == nil || list.count == 0)
    {
        return;
    }
    else
    {
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_mwkeyDic setObject:obj forKey:obj];
        }];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block NSString *mwkey;
    if (indexPath.row == 0)
    {
        NSString *identifier = @"BannerScrollCell";
        [tableView registerNib:[UINib nibWithNibName:@"BannerScrollCell" bundle:nil] forCellReuseIdentifier:identifier];
        BannerScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell initCell:4];
        [cell.imgLists enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            switch (idx) {
                case 0:
                {
                    mwkey = O2O_banner01;
                    break;
                }
                case 1:
                {
                    mwkey = O2O_banner02;
                    break;
                }
                case 2:
                {
                    mwkey = O2O_banner03;
                    break;
                }
                    
                default:
                    mwkey = O2O_banner04;
                    break;
            }
            UIImageView *imgView = (UIImageView *)obj;
            if ([_mwkeyDic objectForKey:mwkey] != nil)
            {
                [MWApi configAdViewWithKey:[_mwkeyDic objectForKey:mwkey] withTarget:imgView success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                    //
                    [imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
                } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                    //
                    NSLog(@"key:%@,error:%@",[_mwkeyDic objectForKey:mwkey],errorMessage);
                }];
            }
            else
            {
                [imgView sd_setImageWithURL:[NSURL URLWithString:_o2oResource.headList[idx]] placeholderImage:nil];
            }
        }];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        NSArray *titles = @[@"脖子",@"腰部",@"全身",@"更多"];
        NSString *identifier = @"BtnViewCell";
        [tableView registerNib:[UINib nibWithNibName:@"BtnViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        BtnViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell initCell:4];
        
        [cell.viewList  enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            switch (idx) {
                case 0:
                {
                    mwkey = O2O_00_01;
                    break;
                }
                case 1:
                {
                    mwkey = O2O_00_02;
                    break;
                }
                case 2:
                {
                    mwkey = O2O_00_03;
                    break;
                }
                    
                default:
                    mwkey = O2O_00_04;
                    break;
            }
            
            BtnView *btnView = (BtnView *)obj;
            if ([_mwkeyDic objectForKey:mwkey] != nil)
            {
                [MWApi configAdViewWithKey:[_mwkeyDic objectForKey:mwkey] withTarget:btnView success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                    //
                    [btnView.imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
                } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                    //
                    NSLog(@"key:%@,error:%@",[_mwkeyDic objectForKey:mwkey],errorMessage);
                }];
            }
            else
            {
                btnView.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_0%li",(long)idx+1]];
                btnView.titleLabel.text = titles[idx];
            }
            
        }];
        
        return cell;
        
    }
    else
    {
        NSString *identifier = @"ImageTableCell";
        [tableView registerNib:[UINib nibWithNibName:@"ImageTableCell" bundle:nil] forCellReuseIdentifier:identifier];
        ImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if ([MWApi isActiveOfmwKey:O2O_middle_01])
        {
            [MWApi configAdViewWithKey:O2O_middle_01 withTarget:cell.imgView1 success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                //
                [cell.imgView1 sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
                
            } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                //
                NSLog(@"key:%@,error:%@",O2O_middle_01,errorMessage);
            }];
        }
        else
        {
            [cell.imgView1 sd_setImageWithURL:[NSURL URLWithString:_o2oResource.contentList[0]] placeholderImage:nil];
        }
        if ([MWApi isActiveOfmwKey:O2O_middle_02])
        {
            [MWApi configAdViewWithKey:O2O_middle_02 withTargetView:cell.imgView2 withTargetViewController:self success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                //
                [cell.imgView2 sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
                
            } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                //
                NSLog(@"key:%@,error:%@",O2O_middle_02,errorMessage);
            } tap:nil mLinkHandler:^NSDictionary * _Nullable(NSString * _Nonnull key, UIView * _Nonnull view) {
                
                return @{@"name1":@"青岛啤酒",@"name2":@"雪花啤酒",@"name3":@"五粮液"};
            }];
        }
        else
        {
            [cell.imgView2 sd_setImageWithURL:[NSURL URLWithString:_o2oResource.contentList[1]] placeholderImage:nil];
        }
        if ([MWApi isActiveOfmwKey:O2O_middle_03])
        {
            [MWApi configAdViewWithKey:O2O_middle_03 withTargetView:cell.imgView3 withTargetViewController:self success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                //
                [cell.imgView3 sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
                
            } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                //
                NSLog(@"key:%@,error:%@",O2O_middle_03,errorMessage);
            } tap:nil mLinkHandler:^NSDictionary * _Nullable(NSString * _Nonnull key, UIView * _Nonnull view) {
                
                return @{@"name1":@"剑南春",@"name2":@"茅台酒",@"name3":@"梦之蓝"};
            }];
        }
        else
        {
            [cell.imgView3 sd_setImageWithURL:[NSURL URLWithString:_o2oResource.contentList[2]] placeholderImage:nil];
        }
        
        return cell;
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    float height = 0;
    switch (indexPath.row) {
        case 0:
        {
            height = 177;
            break;
        }
        case 1:
        {
            height = BtnViewCellHeight;
            break;
        }
        case 2:
        {
            height = (CGRectGetWidth(tableView.frame)-20)*224/360+10;
            break;
        }
            
        default:
            break;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    O2ODetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"O2OVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
