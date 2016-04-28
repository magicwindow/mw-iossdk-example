//
//  LeftViewController.m
//  MagicWIndowShow
//  左侧滑栏页
//  Created by 刘家飞 on 15/12/1.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "LeftViewController.h"
#import <JASidePanels/UIViewController+JASidePanel.h>
#import <JASidePanels/JASidePanelController.h>

@implementation ProfileCell

@end

@implementation MenuCell


@end

@interface LeftViewController ()
{
    IBOutlet UITableView *_tableView;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"版本号%@", version];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
        return cell;
    }
    else
    {
        MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
        NSString *imgName;
        switch (indexPath.row) {
            case 1:
            {
                cell.title.text = @"旅游";
                imgName = @"sidebar_travel";
                break;
            }
            case 2:
            {
                cell.title.text = @"电商";
                imgName = @"sidebar_shopping";
                break;
            }
            case 3:
            {
                cell.title.text = @"O2O";
                imgName = @"sidebar_o2o";
                break;
            }
            case 4:
            {
                cell.title.text = @"电影";
                imgName = @"sidebar_movie";
                break;
            }
            case 5:
            {
                cell.title.text = @"资讯";
                imgName = @"sidebar_news";
                break;
            }
            case 6:
            {
                cell.title.text = @"联系我们";
                imgName = @"sidebar_contact";
            }
                
            default:
                break;
        }
        cell.img.image = [UIImage imageNamed:imgName];
        return cell;
    }
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 148;
    }
    else
        
    {
        return 61;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"MeNav"]];
            break;
        }
        case 1:
        {
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"tourismNav"]];
            break;
        }
        case 2:
        {
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"dianShangNav"]];
            break;
        }
        case 3:
        {
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"o2oNav"]];
            break;
        }
        case 4:
        {
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"tukuNav"]];
            break;
        }
        case 5:
        {
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"newsNav"]];
            break;
        }
        case 6:
        {
            [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"ContactNav"]];
            break;
        }
            
        default:
            break;
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
