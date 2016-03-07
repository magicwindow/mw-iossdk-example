//
//  LoginViewController.m
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/1.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "LoginViewController2.h"
#import <MagicWindowSDK/MWApi.h>
#import <MagicWindowSDK/MWApiObject.h>
#import "CommonService.h"
#import "GoodsDetailViewController.h"

@interface LoginViewController2 ()
{
    IBOutlet UITextField *_userName;
    IBOutlet UITextField *_password;
}

@end

@implementation LoginViewController2

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
    
    if (self.isMlink)
    {
        GoodsDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
        detailVC.name1 = self.name1;
        detailVC.name2 = self.name2;
        detailVC.name3 = self.name3;
        [self.navigationController pushViewController:detailVC animated:YES];
        
        self.isMlink = NO;
    }
    else
    {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"DianShangVC"] animated:YES];
    }
    
}


-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}

@end
