//
//  LoginViewController.m
//  MagicWIndowShow
//  登录页面
//  Created by 刘家飞 on 15/12/1.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "LoginViewController.h"
#import <MagicWindowSDK/MWApi.h>
#import <MagicWindowSDK/MWApiObject.h>
#import "CommonService.h"

@interface LoginViewController ()
{
    IBOutlet UITextField *_userName;
    IBOutlet UITextField *_password;
}

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginPressed:(id)sender
{
    if (_userName.text.length == 0 || _password.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入用户名和密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    MWUserProfile *userProfile = [[MWUserProfile alloc] init];
    userProfile.mwUserName = _userName.text;
    userProfile.mwUserId = @"0000001";
    CommonService *service = [[CommonService alloc] init];
    [service saveUserName:_userName.text];
    [MWApi setUserProfile:userProfile];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
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
