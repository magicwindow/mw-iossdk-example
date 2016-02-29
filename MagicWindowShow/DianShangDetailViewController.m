//
//  DianShangDetailViewController.m
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/2/27.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "DianShangDetailViewController.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"

@implementation DianShangDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [MWApi setCustomEvent:event_goods];
}

@end
