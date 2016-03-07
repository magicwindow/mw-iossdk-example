//
//  PaymentViewController.m
//  MagicWindowShow
//  收银台
//  Created by 刘家飞 on 16/2/27.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaySuccessViewController.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"

@interface PaymentViewController ()
{
    IBOutlet UIButton *_wechatBtn;
    IBOutlet UIButton *_bankBtn;
    NSString *_payOption;
}

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _payOption = @"微信支付";
}

- (void)selecttPayOption:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        {
            [_wechatBtn setImage:[UIImage imageNamed:@"pay_selected"] forState:UIControlStateNormal];
            [_bankBtn setImage:[UIImage imageNamed:@"pay_unselected"] forState:UIControlStateNormal];
            _payOption = @"微信支付";
            break;
        }
            
        default:
        {
            [_bankBtn setImage:[UIImage imageNamed:@"pay_selected"] forState:UIControlStateNormal];
            [_wechatBtn setImage:[UIImage imageNamed:@"pay_unselected"] forState:UIControlStateNormal];
            _payOption = @"支付宝支付";
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[PaySuccessViewController class]])
    {
        PaySuccessViewController *controller = [segue destinationViewController];
        controller.payOption = _payOption;
    }
    [MWApi setCustomEvent:even_pay attributes:@{@"pay_channel":_payOption}];
}

@end
