//
//  DianShangTableViewController.m
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/3/7.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "DianShangTableViewController.h"
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

@interface DianShangTableViewController ()

- (IBAction)logout;

@end

@implementation DianShangTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
    NSArray *viewControllers = self.navigationController.viewControllers;
    if ([viewControllers[0] isKindOfClass:[controller class]])
    {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:viewControllers];
        [arr removeObjectAtIndex:0];
        self.navigationController.viewControllers = arr;
    }
}

- (void)logout
{
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count == 1)
    {
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        controller.navigationController.navigationBarHidden = YES;
        NSMutableArray *arr = [NSMutableArray arrayWithArray:viewControllers];
        [arr insertObject:controller atIndex:0];
        self.navigationController.viewControllers = arr;
    }
    
    CommonService *service = [[CommonService alloc] init];
    [service saveUserName:nil];
    [MWApi cancelUserProfile];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
