//
//  HomeViewController.m
//  MagicWIndowShow
//
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
#import "TourismDetailViewController.h"
#import "CommonService.h"
#import "HomeHelpView.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong, nullable) NSArray *keyList;
@property (nonatomic, strong) NSArray *labelList;
@property (nonatomic, strong) NSMutableDictionary *mwkeyDic;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CommonService *service = [CommonService new];
    if ([service isLvyouFirstLauch])
    {
        HomeHelpView *helpView = (HomeHelpView *)[[NSBundle mainBundle] loadNibNamed:@"HomeHelpView" owner:self options:nil][0];
        helpView.frame = [[UIScreen mainScreen] bounds];
        [self.navigationController.view addSubview:helpView];
    }
    
    self.labelList = @[@{@"t":@"东方的夏威夷",@"d":@"美丽的三亚，浪漫天涯",@"u":@"http://www.mafengwo.cn/i/2886980.html"},
                       @{@"t":@"京都动物园一日游",@"d":@"在繁华的京都中感受另一个日本",@"u":@"http://www.mafengwo.cn/poi/6255228.html?sfrom=ginfo_img_poi"},
                       @{@"t":@"绿竹林里的静谧",@"d":@"走在路上，感受心灵的净化",@"u":@"http://www.mafengwo.cn/i/3172827.html"},
                       @{@"t":@"灌篮高手的回忆",@"d":@"年少时的那个篮球梦你还记得么？",@"u":@"http://www.mafengwo.cn/i/3187584.html"},
                       @{@"t":@"夜色·星空",@"d":@"星空下的大草原",@"u":@"http://www.mafengwo.cn/travel-news/219893.html"},
                       @{@"t":@"雪山下的油菜花",@"d":@"一场静谧的旅行，一片黄色的花海",@"u":@"http://www.mafengwo.cn/z/1003.html"},
                       @{@"t":@"娜鲁萱岛度假村",@"d":@"梦中的伊甸园之菲律宾之旅",@"u":@"http://www.mafengwo.cn/i/2996095.html"},
                       @{@"t":@"一场说走就走的旅行",@"d":@"记录菲律宾海滨8日游",@"u":@"http://www.mafengwo.cn/i/2860772.html"}
                       ];
    
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
    return 9;
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
                        [imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
                        
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
                imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"banner0%lu.png",self.mwkeyDic.allValues.count == 0? idx+1:idx]];
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
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"0%li.png",(long)indexPath.row]]];
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
            cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%li.png",(long)indexPath.row]];
            NSDictionary *dic = self.labelList[indexPath.row-1];
            cell.titleLabel.text = dic[@"t"];
            cell.desc.text = dic[@"d"];
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
        TourismDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tourismDVC"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else
    {
        WebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
        NSDictionary *dic = self.labelList[indexPath.row-1];
        webVC.url = dic[@"u"];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
