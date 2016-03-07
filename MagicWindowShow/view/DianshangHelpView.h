//
//  DianshangHelpView.h
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/2/20.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DianshangHelpView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *helpView1;
@property (nonatomic, weak) IBOutlet UIImageView *helpView2;
@property (nonatomic, weak) IBOutlet UIImageView *helpView3;
@property (nonatomic, weak) IBOutlet UIButton *helpBtn;
@property (nonatomic, weak) IBOutlet UIButton *helpBtn1;
@property (nonatomic, weak) IBOutlet UIButton *helpBtn2;
@property (nonatomic, weak) IBOutlet UIButton *helpBtn3;

- (IBAction)btnPressed:(id)sender;


@end
