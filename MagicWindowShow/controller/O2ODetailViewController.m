//
//  O2ODetailViewController.m
//  MagicWIndowShow
//  O2O详情页
//  Created by 刘家飞 on 15/12/9.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "O2ODetailViewController.h"
#import "O2OTableCell.h"
//#import <MagicWindowSDK/MWApi.h>
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"
#import "UIImageView+WebCache.h"

@interface O2ODetailViewController ()
{
    NSMutableDictionary *_mwkeyDic;
}

@property (nonatomic, strong) NSArray *labelList;

@end

@implementation O2ODetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.labelList = @[@{@"t":@"王伟",@"d":@"33岁，从业10年，高级按摩师，中国推拿协会会员"},
                       @{@"t":@"张刚",@"d":@"28岁，从事中医理疗多年，擅长颈椎、腰椎按摩"},
                       @{@"t":@"李华",@"d":@"35岁，从业8年，拥有大量临床理疗经验，手法娴熟"},
                       @{@"t":@"章梅",@"d":@"30岁，擅长中医推拿，经络调理，脏腑理疗，颈椎病，肩周炎"},
                       @{@"t":@"张扬飞",@"d":@"28岁，手法柔和，娴熟，渗透，细腻，擅长调理肩颈腰腿肌肉僵硬"}];
    
    _mwkeyDic = [[NSMutableDictionary alloc] init];
    NSArray *list = [MWApi mwkeysWithActiveCampign:@[O2O_1,O2O_2,O2O_3,O2O_4,O2O_5]];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"O2OTableCell";
    [tableView registerNib:[UINib nibWithNibName:@"O2OTableCell" bundle:nil] forCellReuseIdentifier:identifier];
    O2OTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSString *mwkey ;
    switch (indexPath.row) {
        case 0:
        {
            mwkey = O2O_1;
            break;
        }
        case 1:
        {
            mwkey = O2O_2;
            break;
        }
        case 2:
        {
            mwkey = O2O_3;
            break;
        }
        case 3:
        {
            mwkey = O2O_4;
            break;
        }
            
        default:
            mwkey = O2O_5;
            break;
    }
    
    if ([_mwkeyDic objectForKey:mwkey])
    {
        [MWApi configAdViewWithKey:[_mwkeyDic objectForKey:mwkey] withTarget:cell success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
            //
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"0%li.png",(long)indexPath.row]]];
            cell.titleLabel.text = campaignConfig.title;
            cell.desc.text = campaignConfig.desc;
            
        } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
            //
            NSLog(@"key:%@,error:%@",[_mwkeyDic objectForKey:mwkey],errorMessage);
        }];
    }
    else
    {
        cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%li.png",(long)indexPath.row]];
        NSDictionary *dic = self.labelList[indexPath.row];
        cell.titleLabel.text = dic[@"t"];
        cell.desc.text = dic[@"d"];
        cell.imgView.image = [UIImage imageNamed:@"avatar002.png"];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
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
