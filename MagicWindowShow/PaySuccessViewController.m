//
//  PaySuccessViewController.m
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/2/27.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "DianShangViewController.h"

@interface PaySuccessViewController ()
{
    IBOutlet UILabel *_payOptionLabel;
}

- (IBAction)goBackToHome:(id)sender;

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _payOptionLabel.text = _payOption;
}

- (void)goBackToHome:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
