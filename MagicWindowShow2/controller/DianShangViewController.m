//
//  DianShangViewController.m
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/9.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "DianShangViewController.h"
#import "BannerScrollCell.h"
#import "BtnView.h"
#import "ImageTableCell.h"
#import "FullIamge2Cell.h"
#import "GlobalDefine.h"
#import "BtnViewCell.h"
#import "CommonService.h"
#import <MagicWindowSDK/MWApi.h>

#define BtnViewCellHeight                   114
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width

@interface DianShangViewController ()

- (IBAction)logout;

@end

@implementation DianShangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logout
{
    CommonService *service = [[CommonService alloc] init];
    [service saveUserName:nil];
    [MWApi cancelUserProfile];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NSString *identifier = @"BannerScrollCell";
        [tableView registerNib:[UINib nibWithNibName:@"BannerScrollCell" bundle:nil] forCellReuseIdentifier:identifier];
        BannerScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell initCell:4];
        [cell.imgLists enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imgView = (UIImageView *)obj;
            imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"banner00%lu.png",(long)idx+1]];
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
            
            BtnView *btnView = (BtnView *)obj;
            btnView.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon0%li",(long)idx+1]];
            btnView.titleLabel.text = titles[idx];
            
        }];
        
        return cell;

    }
    else if (indexPath.row == 2)
    {
        NSString *identifier = @"ImageTableCell";
        [tableView registerNib:[UINib nibWithNibName:@"ImageTableCell" bundle:nil] forCellReuseIdentifier:identifier];
        ImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        return cell;
    }
    else
    {
        NSArray *list = @[@"意大利进口红酒优惠中",@"意大利红泡酒全新上市",@"高品质国宾酒热卖",@"迎新年 就喝智利葡萄酒",@"团圆年 喝好酒",@"过年屯年货 好酒大折扣",@"茅台贵香液限量3000瓶",@"葡萄酒全场促销"];
        NSString *identifier = @"FullIamge2Cell";
        [tableView registerNib:[UINib nibWithNibName:@"FullIamge2Cell" bundle:nil] forCellReuseIdentifier:identifier];
        FullIamge2Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"list00%li",indexPath.row -2]];
        cell.titleLabel.text = list[indexPath.row-3];
        
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
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"] animated:YES];
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
