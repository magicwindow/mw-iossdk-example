//
//  ShoppinglistViewController.m
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/2/27.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "ShoppinglistViewController.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"

@interface ShoppinglistViewController ()

@end

@implementation ShoppinglistViewController

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
    
    [MWApi setCustomEvent:event_shoppingList];
}


@end
