//
//  LoginViewController.h
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/1.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController2 : UIViewController

@property (nonatomic, strong) NSString *name1;
@property (nonatomic, strong) NSString *name2;
@property (nonatomic, strong) NSString *name3;
@property (nonatomic, assign) BOOL isMlink;

- (IBAction)loginPressed:(id)sender;
-(IBAction)textFiledReturnEditing:(id)sender;

@end
