//
//  OrderDetailsViewController.m
//  MagicWindowShow
//  填写订单
//  Created by 刘家飞 on 16/2/27.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"

@interface OrderDetailsViewController ()

@end

@implementation OrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [MWApi setCustomEvent:event_order];
}


@end
