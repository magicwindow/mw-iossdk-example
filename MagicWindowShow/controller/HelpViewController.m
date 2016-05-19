//
//  HelpViewController.m
//  MagicWindowShow
//  引导页
//  Created by 刘家飞 on 16/2/19.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "HelpViewController.h"
#import "ResourceService.h"
#import "ViewController.h"
#import "GlobalDefine.h"
#import <MagicWindowSDK/MWApi.h>

@interface HelpViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.scrollView bringSubviewToFront:self.view];
    [self.view addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame)*4, CGRectGetHeight(self.scrollView.frame)-20);
    for (int i = 0;i < 4 ; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame)*i, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.view.frame));
        imageView.tag = i;
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"help0%i",i+1]]];
        [_scrollView addSubview:imageView];
        
        if (i == 3)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame)*3+(CGRectGetWidth(self.scrollView.frame)-268)/2, CGRectGetHeight(self.scrollView.frame)-92-80, 268, 92);
            [btn setImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:btn];
        }
    }
}

- (void)btnPressed
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewController  *rootVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SideVC"];
    [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
    
    if ([self.mLinkKey isEqualToString:mLink_dianshangDetail])
    {
        self.mLinkKey = nil;
        
        UINavigationController *nav = [mainStoryBoard instantiateViewControllerWithIdentifier:@"dianShangNav"];
        nav.view.tag = 1007;
        [rootVC setCenterPanel: nav];
        [nav pushViewController:[mainStoryBoard instantiateViewControllerWithIdentifier:@"dianShangDetailVC"] animated:YES];
    }
    else if ([self.mLinkKey isEqualToString:mLink_campaignKey])
    {
        self.mLinkKey = nil;
        NSString *key = self.params[@"key"];
        
        UIView *view = [[UIView alloc] init];
        [rootVC.view addSubview:view];
        
        [MWApi configAdViewWithKey:key withTarget:view success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
            //成功获取到相关活动，并打开该活动
            [MWApi autoOpenWebViewWithKey:key withTargetView:view];
        } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
            //没有获取到相关活动，不做任何处理
            [view removeFromSuperview];
        }];
    }
    else if ([self.mLinkKey isEqualToString:mLink_O2Odetail])
    {
        self.mLinkKey = nil;
        
        UINavigationController *nav = [rootVC.storyboard instantiateViewControllerWithIdentifier:@"o2oNav"];
        nav.view.tag = 1007;
        [rootVC setCenterPanel: nav];
        [nav pushViewController:[rootVC.storyboard instantiateViewControllerWithIdentifier:@"O2OVC"] animated:YES];
    }
    else if ([self.mLinkKey isEqualToString:mLink_NewsDetail])
    {
        self.mLinkKey = nil;
        
        UINavigationController *nav = [rootVC.storyboard instantiateViewControllerWithIdentifier:@"newsNav"];
        nav.view.tag = 1007;
        [rootVC setCenterPanel: nav];
        [nav pushViewController:[rootVC.storyboard instantiateViewControllerWithIdentifier:@"CommunityViewController"] animated:YES];
    }
    else if ([self.mLinkKey isEqualToString:mLink_VideoDetail])
    {
        self.mLinkKey = nil;
        
        UINavigationController *nav = [mainStoryBoard instantiateViewControllerWithIdentifier:@"tukuNav"];
        nav.view.tag = 1007;
        [rootVC setCenterPanel: nav];
        [nav pushViewController:[mainStoryBoard instantiateViewControllerWithIdentifier:@"MovieDetailVC"] animated:YES];
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    NSInteger i = x/CGRectGetWidth(scrollView.frame);
    _pageControl.currentPage = i;
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
