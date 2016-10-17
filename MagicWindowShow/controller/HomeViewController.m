//
//  HomeViewController.m
//  MagicWIndowShow
//  旅游页面
//  Created by 刘家飞 on 15/9/11.
//  Copyright (c) 2015年 cafei. All rights reserved.
//

#import "HomeViewController.h"
#import "FullImageCell.h"
#import <MagicWindowSDK/MWApi.h>
#import <JASidePanels/UIViewController+JASidePanel.h>
#import <JASidePanels/JASidePanelController.h>
#import "BannerScrollCell.h"
#import "FullImageCell.h"
#import "GlobalDefine.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "WebViewController.h"
#import "SanyaViewController.h"
#import "CommonService.h"
#import "HomeHelpView.h"
#import "CityPickerViewController.h"
#import "ResourceService.h"
#import <MagicWindowSDK/MWFloatView.h>

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,CityPickerDelegate>

@property (nonatomic, strong, nullable) NSArray *keyList;
@property (nonatomic, strong) NSMutableDictionary *mwkeyDic;
@property (nonatomic, strong) TourismDomain *tourismResource;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
/* 暂时不添加此引导页
    CommonService *service = [CommonService new];
    if ([service isLvyouFirstLauch])
    {
        HomeHelpView *helpView = (HomeHelpView *)[[NSBundle mainBundle] loadNibNamed:@"HomeHelpView" owner:self options:nil][0];
        helpView.frame = [[UIScreen mainScreen] bounds];
        [self.navigationController.view addSubview:helpView];
    }
*/
    [[ResourceService sharedInstance] getTourismResource:^(TourismDomain *domain) {
        
        _tourismResource = domain;
        [_tableView reloadData];
        _tableView.hidden = NO;
    }];
    
    _keyList = @[Home_banner01,Home_banner02,Home_banner03,Home_banner04,Home_banner05,Home_01,Home_02,Home_03,Home_04,Home_05,Home_06,Home_07,Home_08];
    
    //注册活动更新通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCampaign) name:MWUpdateCampaignNotification object:nil];
    
    self.mwkeyDic = [[NSMutableDictionary alloc] init];
    //判断魔窗位上是否有活动
    NSArray *list = [MWApi mwkeysWithActiveCampign:_keyList];
    if (list == nil || list.count == 0)
    {
        return;
    }
    else
    {
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.mwkeyDic setObject:obj forKey:obj];
        }];
    }
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    MWFloatView *view = [[MWFloatView alloc] initWithYPoint:75];
    [view showInView:self.view];
}

- (void)updateCampaign
{
    //收到活动更新通知
    //判断当前页面的魔窗位上是否有活动
    NSArray *list = [MWApi mwkeysWithActiveCampign:_keyList];
    if (list == nil || list.count == 0)
    {
        return;
    }
    else
    {
        //更新活动
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.mwkeyDic setObject:obj forKey:obj];
        }];
        [_tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tourismResource.contentList.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NSString *identifier = @"BannerScrollCell";
        [tableView registerNib:[UINib nibWithNibName:@"BannerScrollCell" bundle:nil] forCellReuseIdentifier:identifier];
        BannerScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        BOOL banner01 = [MWApi isActiveOfmwKey:Home_banner01];
        [cell initCell:4+ (banner01? 1:0)];
        [cell.imgLists enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *mwkey;
            switch (idx) {
                case 0:
                {
                    mwkey = banner01? Home_banner01:Home_banner02;
                    break;
                }
                case 1:
                {
                    mwkey = banner01? Home_banner02:Home_banner03;
                    break;
                }
                case 2:
                {
                    mwkey = banner01? Home_banner03:Home_banner04;
                    break;
                }
                case 3:
                {
                    mwkey = banner01? Home_banner04:Home_banner05;
                    break;
                }
                default:
                    mwkey = Home_banner05;
                    break;
            }
            UIImageView *imgView = (UIImageView *)obj;
            if ([self.mwkeyDic objectForKey:mwkey] != nil)
            {
                //添加魔窗位
                if (imgView.tag == idx)
                {
                    
                    [MWApi configAdViewWithKey:[self.mwkeyDic objectForKey:mwkey] withTargetView:imgView withTargetViewController:self success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                        //成功活动到活动信息，加载活动页面
                        [imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:@"570-250"]];
                        
                    } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                        //获取活动信息失败
                        NSLog(@"key:%@,error:%@",[self.mwkeyDic objectForKey:mwkey],errorMessage);
                        
                    } tap:nil mLinkHandler:^NSDictionary * _Nullable(NSString * _Nonnull key, UIView * _Nonnull view) {
                        //如果该活动是mlink，返回相应的动态参数
                        return @{@"key":Home_03};
                    }];
                }
            }
            else
            {
                NSString *imgUrlStr = _tourismResource.headList[banner01? idx-1:idx];
                [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:[UIImage imageNamed:@"570-250"]];
            }
            
            
        }];
        return cell;
    }
    else
    {
        NSString *identifier = @"FullImageCell";
        
        //不复用cell，由于每个cell都是一个魔窗位，cell不能复用，否则点击事件会发生错乱
        FullImageCell *cell = (FullImageCell *)[[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        
        NSString *mwkey ;
        switch (indexPath.row) {
            case 1:
            {
                mwkey = Home_01;
                break;
            }
            case 2:
            {
                mwkey = Home_02;
                break;
            }
            case 3:
            {
                mwkey = Home_03;
                break;
            }
            case 4:
            {
                mwkey = Home_04;
                break;
            }
            case 5:
            {
                mwkey = Home_05;
                break;
            }
            case 6:
            {
                mwkey = Home_06;
                break;
            }
            case 7:
            {
                mwkey = Home_07;
                break;
            }
            case 8:
            {
                mwkey = Home_08;
                break;
            }
                
            default:
                break;
        }
        if ([self.mwkeyDic objectForKey:mwkey])
        {
            //加载魔窗位
            [MWApi configAdViewWithKey:[self.mwkeyDic objectForKey:mwkey] withTargetView:cell withTargetViewController:self success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
                
                //成功获取该魔窗位上的活动信息，展示相关活动信息
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:@"570-250"]];
                cell.titleLabel.text = campaignConfig.title;
                cell.desc.text = campaignConfig.desc;
                
            } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
                //没有获取到活动
                NSLog(@"key:%@,error:%@",[self.mwkeyDic objectForKey:mwkey],errorMessage);
                
            } tap:nil mLinkHandler:^NSDictionary * _Nullable(NSString * _Nonnull key, UIView * _Nonnull view) {
                if ([mwkey isEqualToString: Home_03])
                {
                    return @{@"name1":@"青岛啤酒",@"name2":@"雪花啤酒",@"name3":@"五粮液"};
                }
                else if ([mwkey isEqualToString:Home_04])
                {
                    return @{@"name1":@"剑南春",@"name2":@"茅台酒",@"name3":@"梦之蓝"};
                }
                else if ([mwkey isEqualToString:Home_05])
                {
                    return @{@"name1":@"泸州老窖",@"name2":@"汾酒",@"name3":@"古井贡酒"};
                }
                else
                {
                    return nil;
                }
                
            }];
        }
        else
        {
            BaseDomain *resource = _tourismResource.contentList[indexPath.row-1];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:resource.imgUrl] placeholderImage:[UIImage imageNamed:@"570-250"]];
            cell.titleLabel.text = resource.title;
            cell.desc.text = resource.desc;
        }
        
        return cell;
    }
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 177;
    }
    else
        
    {
        return 219;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
    if (indexPath.row == 1)
    {
        SanyaViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"sanyaVC"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else
    {
        WebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
        BaseDomain *resource = _tourismResource.contentList[indexPath.row-1];
        webVC.url =resource.url;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark CityPickerDelegate
- (void)updateCity:(NSString *)city
{
    [self.navigationItem.rightBarButtonItem setTitle:city];
}

- (void)selectCityBtnPressed:(id)sender
{
    CityPickerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CityVC"];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[CityPickerViewController class]])
    {
        CityPickerViewController *controller = [segue destinationViewController];
        controller.delegate = self;
    }
}


@end
