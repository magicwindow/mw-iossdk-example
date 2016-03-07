//
//  DianShangViewController.m
//  MagicWIndowShow
//  电商页
//  Created by 刘家飞 on 15/12/9.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "DianShangViewController.h"
#import "BannerScrollCell.h"
#import "BtnView.h"
#import "ImageTableCell.h"
#import "FullIamge2Cell.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"
#import "UIImageView+WebCache.h"
#import "BtnViewCell.h"
#import "CommonService.h"
#import "DianshangHelpView.h"
#import "ResourceService.h"

#define BtnViewCellHeight                   114
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width

@interface DianShangViewController ()
{
    NSMutableDictionary *_mwkeyDic;
    IBOutlet UITableView *_tableView;
}

@property (nonatomic, strong) DianShangDomain *dianShangResource;

@end

@implementation DianShangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CommonService *service = [CommonService new];
    if ([service isDianshangFirstLauch])
    {
        DianshangHelpView *helpView = (DianshangHelpView *)[[NSBundle mainBundle] loadNibNamed:@"DianshangHelpView" owner:self options:nil][0];
        helpView.frame = [[UIScreen mainScreen] bounds];
        [self.navigationController.view addSubview:helpView];
    }
    
    [[ResourceService sharedInstance] getDianShangResource:^(DianShangDomain *domain) {
        _dianShangResource = domain;
        [_tableView reloadData];
        _tableView.hidden = NO;
    }];
        
    _mwkeyDic = [[NSMutableDictionary alloc] init];
    NSArray *list = [MWApi mwkeysWithActiveCampign:@[DianShang_banner01,DianShang_banner02,DianShang_banner03,DianShang_banner04,DianShang_OO_01,DianShang_OO_02,DianShang_OO_03,DianShang_OO_04,DianShang_OO_05,DianShang_OO_06,DianShang_OO_07,DianShang_OO_08,DianShang_middle_01,DianShang_middle_02,DianShang_middle_03,DianShang_01,DianShang_02,DianShang_03,DianShang_04,DianShang_05,DianShang_06,DianShang_07,DianShang_08]];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dianShangResource.contentList.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block NSString *mwkey;
    switch (indexPath.row) {
        case 2:
        {
            mwkey = DianShang_01;
            break;
        }
        case 3:
        {
            mwkey = DianShang_02;
            break;
        }
        case 4:
        {
            mwkey = DianShang_03;
            break;
        }
        case 5:
        {
            mwkey = DianShang_04;
            break;
        }
        case 6:
        {
            mwkey = DianShang_05;
            break;
        }
        case 7:
        {
            mwkey = DianShang_06;
            break;
        }
        case 8:
        {
            mwkey = DianShang_07;
            break;
        }
        case 9:
        {
            mwkey = DianShang_08;
            break;
        }

        default:
            break;
    }
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
                    mwkey = DianShang_banner01;
                    break;
                }
                case 1:
                {
                    mwkey = DianShang_banner02;
                    break;
                }
                case 2:
                {
                    mwkey = DianShang_banner03;
                    break;
                }
                    
                default:
                    mwkey = DianShang_banner04;
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
                [imgView sd_setImageWithURL:[NSURL URLWithString:_dianShangResource.headList[idx]] placeholderImage:nil];
            }
        }];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        NSArray *titles = @[@"新品",@"热销",@"特惠",@"分类",@"超市",@"充值",@"预告",@"更多"];
        NSString *identifier = @"BtnViewCell";
        [tableView registerNib:[UINib nibWithNibName:@"BtnViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        BtnViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell initCell:8];
        
        [cell.viewList  enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            switch (idx) {
                case 0:
                {
                    mwkey = DianShang_OO_01;
                    break;
                }
                case 1:
                {
                    mwkey = DianShang_OO_02;
                    break;
                }
                case 2:
                {
                    mwkey = DianShang_OO_03;
                    break;
                }
                case 3:
                {
                    mwkey = DianShang_OO_04;
                    break;
                }
                case 4:
                {
                    mwkey = DianShang_OO_05;
                    break;
                }
                case 5:
                {
                    mwkey = DianShang_OO_06;
                    break;
                }
                case 6:
                {
                    mwkey = DianShang_OO_07;
                    break;
                }
                    
                default:
                    mwkey = DianShang_OO_08;
                    break;
            }
            
            BtnView *btnView = (BtnView *)obj;
            if ([_mwkeyDic objectForKey:mwkey] != nil)
            {
                [MWApi configAdViewWithKey:[_mwkeyDic objectForKey:mwkey] withTarget:btnView success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                    //
                    [btnView.imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
                    btnView.titleLabel.text = campaignConfig.title;
                } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                    //
                    NSLog(@"key:%@,error:%@",[_mwkeyDic objectForKey:mwkey],errorMessage);
                }];
            }
            else
            {
                btnView.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon0%li",(long)idx+1]];
                btnView.titleLabel.text = titles[idx];
            }
            
        }];
        
        return cell;

    }
    else if (indexPath.row == 2)
    {
        NSString *identifier = @"ImageTableCell";
        [tableView registerNib:[UINib nibWithNibName:@"ImageTableCell" bundle:nil] forCellReuseIdentifier:identifier];
        ImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if ([MWApi isActiveOfmwKey:DianShang_middle_01])
        {
            [MWApi configAdViewWithKey:DianShang_middle_01 withTarget:cell.imgView1 success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                //
                [cell.imgView1 sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
                
            } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                //
                NSLog(@"key:%@,error:%@",DianShang_middle_01,errorMessage);
            }];
        }
        else
        {
            [cell.imgView1 sd_setImageWithURL:[NSURL URLWithString:_dianShangResource.middleList[0]] placeholderImage:nil];
        }
        if ([MWApi isActiveOfmwKey:DianShang_middle_02])
        {
            [MWApi configAdViewWithKey:DianShang_middle_02 withTarget:cell.imgView2 success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                //
                [cell.imgView2 sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
                
            } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                //
                NSLog(@"key:%@,error:%@",DianShang_middle_02,errorMessage);
            }];
        }
        else
        {
            [cell.imgView2 sd_setImageWithURL:[NSURL URLWithString:_dianShangResource.middleList[1]] placeholderImage:nil];
        }
        if ([MWApi isActiveOfmwKey:DianShang_middle_03])
        {
            [MWApi configAdViewWithKey:DianShang_middle_03 withTarget:cell.imgView3 success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                //
                [cell.imgView3 sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
                
            } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                //
                NSLog(@"key:%@,error:%@",DianShang_middle_03,errorMessage);
            }];
        }
        else
        {
            [cell.imgView3 sd_setImageWithURL:[NSURL URLWithString:_dianShangResource.middleList[2]] placeholderImage:nil];
        }

        return cell;
    }
    else
    {
        NSString *identifier = @"FullIamge2Cell";
        
        //不复用cell，由于每个cell都是一个魔窗位，cell不能复用，否则点击事件会发生错乱
        FullIamge2Cell *cell = (FullIamge2Cell *)[[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        
        if([_mwkeyDic objectForKey:mwkey] != nil)
        {
            [MWApi configAdViewWithKey:[_mwkeyDic objectForKey:mwkey] withTarget:cell.imgView success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                //
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"list00%li",indexPath.row -2]]];
                cell.titleLabel.text = campaignConfig.title;
                
            } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                //
                NSLog(@"key:%@,error:%@",[_mwkeyDic objectForKey:mwkey],errorMessage);
            }];
        }
        else
        {
            BaseDomain *resource = _dianShangResource.contentList[indexPath.row-3];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:resource.imgUrl] placeholderImage:nil];
            cell.titleLabel.text = resource.title;
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
            height = BtnViewCellHeight*1.9;
            break;
        }
        case 2:
        {
            height = (CGRectGetWidth(tableView.frame)-20)*224/360+10;
            break;
        }
            
        default:
            height = 240;
            break;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"dianShangDetailVC"] animated:YES];
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
