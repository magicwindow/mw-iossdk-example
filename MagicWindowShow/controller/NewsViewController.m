//
//  NewsViewController.m
//  MagicWIndowShow
//  资讯页
//  Created by 刘家飞 on 15/12/10.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "ResourceService.h"
#import "CommunityViewController.h"

@interface NewsViewController ()
{
    NSInteger _currentIndex;
    NSDictionary *_list;
    NSMutableDictionary *_mwkeyDic;
}

@property (nonatomic, strong) NewsDomain *newsResource;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[ResourceService sharedInstance] getNewsResource:^(NewsDomain *domain) {
        _newsResource = domain;
        [_tableView reloadData];
        _tableView.hidden = NO;
    }];
    
    _currentIndex = 0;
    
    _mwkeyDic = [[NSMutableDictionary alloc] init];
    NSArray *list = [MWApi mwkeysWithActiveCampign:@[News_internet_01,News_internet_02,News_internet_03,News_sport_01,News_sport_02,News_sport_03,News_fun_01,News_fun_02,News_fun_03]];
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

- (void)tabSelect:(id)sender
{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    _currentIndex = segment.selectedSegmentIndex;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    float num = 0;
    switch (_currentIndex) {
        case 0:
        {
            num = _newsResource.internetList.count;
            break;
        }
        case 1:
        {
            num = _newsResource.sportList.count;
            break;
        }
            
        default:
        {
            num = _newsResource.entertainmentList.count;
            break;
        }
            
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"NewsCell";
    //不复用cell
    NewsCell *cell = (NewsCell *)[[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
    
    NSString *mwkey;
    NSArray *list;
    if (_currentIndex == 0)
    {
        list = _newsResource.internetList;
        switch (indexPath.row) {
            case 0:
            {
                mwkey = News_internet_01;
                break;
            }
            case 1:
            {
                mwkey = News_internet_02;
                break;
            }
            case 2:
            {
                mwkey = News_internet_03;
                break;
            }
                
            default:
                break;
        }
    }
    else if (_currentIndex == 1)
    {
        list = _newsResource.sportList;
        switch (indexPath.row) {
            case 0:
            {
                mwkey = News_sport_01;
                break;
            }
            case 1:
            {
                mwkey = News_sport_02;
                break;
            }
            case 2:
            {
                mwkey = News_sport_03;
                break;
            }
                
            default:
                break;
        }
    }
    else if (_currentIndex == 2)
    {
        list = _newsResource.entertainmentList;
        switch (indexPath.row) {
            case 0:
            {
                mwkey = News_fun_01;
                break;
            }
            case 1:
            {
                mwkey = News_fun_02;
                break;
            }
            case 2:
            {
                mwkey = News_fun_03;
                break;
            }
                
            default:
                break;
        }
    }
    if ([_mwkeyDic objectForKey:mwkey] != nil)
    {
        [MWApi configAdViewWithKey:[_mwkeyDic objectForKey:mwkey] withTarget:cell success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
            //
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:nil];
            cell.titleLabel.text = campaignConfig.title;
            cell.desc.text = campaignConfig.desc;
            
        } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
            //
            NSLog(@"key:%@,error:%@",[_mwkeyDic objectForKey:mwkey],errorMessage);
        }];
    }
    else
    {
        BaseDomain *domain = list[indexPath.row];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:domain.imgUrl] placeholderImage:nil];
        cell.titleLabel.text = domain.title;
        cell.desc.text = domain.desc;
    }
    
    if (_currentIndex == 0 && indexPath.row == 0) {
        cell.titleLabel.text = @"小而美的综合体，iPhone SE 深度体验";
        cell.desc.text = @"几天前，Apple 过了它的第 40 个生日。想想 Apple 给我带来了多少好玩有趣的产品和服务，无趣地想象了一番没有 Apple 的世界，或许会有不同，我们会失去 iPod、MacBook、iTunes 甚至是上个月发布的「史上最平价的 iPhone」- iPhone SE。而到今天，我把玩 iPhone SE 已经有几天时间了，也该是时候跟大家分享这几天我的使用感受了。";
        [cell.imgView sd_cancelCurrentImageLoad];
        cell.imgView.image = [UIImage imageNamed:@"community_phone.jpg"];
    }
    
    return cell;
    
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == 0 && indexPath.row == 0)
    {
        CommunityViewController *communityVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommunityViewController"];
        [self.navigationController pushViewController:communityVC animated:YES];
    }
    else
    {
        NSArray *list;
        switch (_currentIndex) {
            case 0:
                list = _newsResource.internetList;
                break;
            case 1:
                list = _newsResource.sportList;
                break;
                
            default:
                list = _newsResource.entertainmentList;
                break;
        }
        WebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
        BaseDomain *domain = list[indexPath.row];
        webVC.url = domain.url;
        [self.navigationController pushViewController:webVC animated:YES];
    }
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
