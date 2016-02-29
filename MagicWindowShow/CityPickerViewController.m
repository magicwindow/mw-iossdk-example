//
//  CityPickerViewController.m
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/2/25.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "CityPickerViewController.h"
#import "ChineseToPinyin.h"
#import <MagicWindowSDK/MWApi.h>

@interface CityPickerViewController ()
{
    NSMutableDictionary *_cityDic;
    NSMutableArray *_resultList;
    NSMutableArray *_titleList;
    NSMutableArray *_cityList;
    NSArray *_hotCityList;
    NSArray *_cityCodeList;
}

@end

@implementation CityPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
}

- (void)initData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CityList" ofType:@"plist"];
    _cityDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    _cityList = [NSMutableArray new];
    [[_cityDic allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_cityList addObjectsFromArray:_cityDic[obj]];
    }];
    _resultList = [NSMutableArray new];
    _titleList = [NSMutableArray new];
    [_titleList addObject:@"热门城市"];
    for (int i = 0; i < 26; i++) {
        if (i == 8 || i == 14 || i == 20 || i== 21) {
            continue;
        }
        NSString *cityKey = [NSString stringWithFormat:@"%c",i+65];
        [_titleList addObject:cityKey];
    }
    _hotCityList = @[@"上海",@"北京",@"广州",@"深圳",@"武汉",@"天津",@"西安",@"南京",@"杭州",@"成都",@"重庆",@"济南"];
    _cityCodeList = @[@"310000",@"110000",@"440100",@"440300",@"420100",@"120000",@"220403",@"320100",@"330100",@"510100",@"500000",@"370100"];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [_resultList removeAllObjects];
    [_cityList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[ChineseToPinyin pinyinFromChiniseString:obj] hasPrefix:[searchString uppercaseString]] || [obj hasPrefix:searchString])
        {
            [_resultList addObject:obj];
        }
    }];
    return YES;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 10)
    {
        return _titleList.count;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10)
    {
        if (section > 0)
        {
            NSString *key = [_titleList objectAtIndex:section];
            return [_cityDic[key] count];
        }
        else
        {
            return 1;
        }
    }
    else
    {
        return [_resultList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10)
    {
        if (indexPath.section == 0)
        {
            static NSString *Identifier = @"HotCityCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [_hotCityList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                int row = (int)idx/3;
                int num = (int)idx%3;
                float btnWidth = (CGRectGetWidth(tableView.frame)-15*3-50)/3;
                float btnHeight = 30;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(15+(btnWidth+15)*num, 15+(btnHeight+15)*row, btnWidth, btnHeight);
                [btn setTitle:_hotCityList[idx] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                btn.tag = idx;
                [btn addTarget:self action:@selector(hotCityBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn];
            }];
            return cell;
        }
        else
        {
            static NSString *Identifier = @"Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString *key = [_titleList objectAtIndex:indexPath.section];
            NSArray *valueList = _cityDic[key];
            cell.textLabel.text = valueList[indexPath.row];
            return cell;
        }
        
    }
    else
    {
        static NSString *Identifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _resultList[indexPath.row];
        return cell;
    }
}

//右侧索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView.tag == 10)
    {
        return _titleList;
    }
    else
    {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 10)
    {
        return _titleList[section];
    }
    else
    {
        return nil;
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10)
    {
        if (indexPath.section == 0)
        {
            return _hotCityList.count/3*(30+15);
        }
        else
        {
            return 50;
        }
    }
    else
    {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hotCityBtnPressed:(UIButton *)btn
{
    [MWApi setCityCode:_cityCodeList[btn.tag]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateCity:)])
    {
        [self.delegate updateCity:_hotCityList[btn.tag]];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
