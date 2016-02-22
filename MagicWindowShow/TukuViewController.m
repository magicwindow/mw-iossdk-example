//
//  TukuViewController.m
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/10.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "TukuViewController.h"
#import "TwoImageCell.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"
#import "UIImageView+WebCache.h"

@interface TukuViewController ()
{
    NSArray *_list;
    NSMutableDictionary *_mwkeyDic;
}

@end

@implementation TukuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _list = @[@{@"t":@"疾速追杀",@"d":@"动作片"},
              @{@"t":@"星际穿越",@"d":@"科幻片"},
              @{@"t":@"魔法黑森林",@"d":@"奇幻片"},
              @{@"t":@"消失的爱人",@"d":@"悬疑片"},
              @{@"t":@"布达佩斯大饭店",@"d":@"喜剧"},
              @{@"t":@"模仿游戏",@"d":@"惊悚片"}];
    
    _mwkeyDic = [[NSMutableDictionary alloc] init];
    NSArray *list = [MWApi mwkeysWithActiveCampign:@[Tuku_01,Tuku_02,Tuku_03,Tuku_04,Tuku_05,Tuku_06]];
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
    NSString *identifier = @"TwoImageCell";
    [tableView registerNib:[UINib nibWithNibName:@"TwoImageCell" bundle:nil] forCellReuseIdentifier:identifier];
    TwoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSInteger leftIndex = indexPath.row*2+1;
    NSInteger rightIndex = indexPath.row*2+2;
    NSString *leftMwKey;
    NSString *rightMwKey;
    switch (indexPath.row) {
        case 0:
        {
            leftMwKey = Tuku_01;
            rightMwKey = Tuku_02;
            break;
        }
        case 1:
        {
            leftMwKey = Tuku_03;
            rightMwKey = Tuku_04;
            break;
        }
        case 2:
        {
            leftMwKey = Tuku_05;
            rightMwKey = Tuku_06;
            break;
        }
            
        default:
            break;
    }
    if ([_mwkeyDic objectForKey:leftMwKey] != nil)
    {
        [MWApi configAdViewWithKey:[_mwkeyDic objectForKey:leftMwKey] withTarget:cell.leftImg success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
            //
            [cell.leftImg sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"tuku_0%li",(long)leftIndex]]];
            cell.leftTitle.text = campaignConfig.title;
            cell.leftDesc.text = campaignConfig.desc;
            
        } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
            //
            NSLog(@"key:%@,error:%@",[_mwkeyDic objectForKey:leftMwKey],errorMessage);
        }];
    }
    else
    {
        cell.leftImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"tuku_0%li",(long)leftIndex]];
        cell.leftTitle.text = _list[leftIndex-1][@"t"];
        cell.leftDesc.text = _list[leftIndex-1][@"d"];
    }
    
    if ([_mwkeyDic objectForKey:rightMwKey] != nil)
    {
        [MWApi configAdViewWithKey:[_mwkeyDic objectForKey:rightMwKey] withTarget:cell.rightImg success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
            //
            [cell.rightImg sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"tuku_0%li",(long)rightIndex]]];
            cell.rightTitle.text = campaignConfig.title;
            cell.rightDesc.text = campaignConfig.desc;
            
        } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
            //
            NSLog(@"key:%@,error:%@",[_mwkeyDic objectForKey:rightMwKey],errorMessage);
        }];
    }
    else
    {
        cell.rightImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"tuku_0%li",(long)rightIndex]];
        cell.rightTitle.text = _list[rightIndex-1][@"t"];
        cell.rightDesc.text = _list[rightIndex-1][@"d"];
    }

    return cell;
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGRectGetWidth(tableView.frame)*177/363+10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
