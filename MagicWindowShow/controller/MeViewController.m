//
//  MeViewController.m
//  MagicWIndowShow
//  个人中心页
//  Created by 刘家飞 on 15/9/11.
//  Copyright (c) 2015年 cafei. All rights reserved.
//

#import "MeViewController.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"
#import "UIImageView+WebCache.h"
#import "CommonService.h"

@implementation MeCell


@end

@interface MeViewController ()
{
    NSMutableDictionary *_mwkeyDic;
    NSArray *_list;
}

@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mwkeyDic = [[NSMutableDictionary alloc] init];
    NSArray *list = [MWApi mwkeysWithActiveCampign:@[me_01,me_02,me_03,me_04,me_05,me_06,me_07]];
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
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *mwkey;
    NSString *title;
    NSString *imgName;
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopCell"];
        return cell;
    }
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 6)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpaceCell"];
        return cell;
    }
    else
    {
        MeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeCell"];
        switch (indexPath.row) {
            case 2:
            {
                CommonService *service = [[CommonService alloc] init];
                if ([service hasLogin])
                {
                    title = @"退出";
                }
                else
                {
                    title = @"登录";
                }
                imgName = @"icon-0";
                break;
            }
            case 4:
            {
                mwkey = me_01;
                title = @"我的消息";
                imgName = @"icon-1";
                break;
            }
            case 5:
            {
                mwkey = me_02;
                title = @"功能介绍";
                imgName = @"icon-2";
                break;
            }
            case 7:
            {
                mwkey = me_03;
                title = @"意见反馈";
                imgName = @"icon-3";
                break;
            }
            case 8:
            {
                mwkey = me_04;
                title = @"用户满意度调查，赢Apple Watch!";
                imgName = @"icon-4";
                break;
            }
            case 9:
            {
                mwkey = me_05;
                title = @"分享应用给好友";
                imgName = @"icon-5";
                break;
            }
            case 10:
            {
                mwkey = me_06;
                title = @"邀请好友赢积分";
                imgName = @"icon-6";
                break;
            }
            case 11:
            {
                mwkey = me_07;
                title = @"去App Store给我们个好评吧!";
                imgName = @"icon-7";
                break;
            }
            case 12:
            {
                title = @"引导页";
                imgName = @"icon-8";
                break;
            }
                
            default:
                break;
        }
        
        if([_mwkeyDic objectForKey:mwkey] != nil)
        {
            [MWApi configAdViewWithKey:[_mwkeyDic objectForKey:mwkey] withTarget:cell success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                //
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:imgName]];
                cell.titlelabel.text = campaignConfig.title;
                
            } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                //
                NSLog(@"key:%@,error:%@",[_mwkeyDic objectForKey:mwkey],errorMessage);
            }];
        }
        else
        {
            cell.imgView.image = [UIImage imageNamed:imgName];
            cell.titlelabel.text = title;
        }
        
        return cell;
    }
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 175;
    }
    else if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 6)
    {
        return 15;
    }
    else
    {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        CommonService *service = [[CommonService alloc] init];
        if ([service hasLogin])
        {
            [service saveUserName:nil];
            [MWApi cancelUserProfile];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        else
        {
            [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"] animated:YES];
        }
    }
    
    if (indexPath.row == 12)
    {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HelpVC"] animated:YES];
    }
    
    if (indexPath.row == 11)
    {
        CommonService *service = [[CommonService alloc] init];
        [service performSelector:@selector(getRemoteNotification) withObject:nil afterDelay:5];
    }
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
