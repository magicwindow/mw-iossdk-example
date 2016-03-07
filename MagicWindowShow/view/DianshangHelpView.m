//
//  DianshangHelpView.m
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/2/20.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "DianshangHelpView.h"

@implementation DianshangHelpView

- (void)btnPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
        {
            self.helpView1.hidden = YES;
            self.helpBtn1.hidden = YES;
            self.helpView2.hidden = NO;
            self.helpBtn2.hidden = NO;
            break;
        }
        case 2:
        {
            self.helpView2.hidden = YES;
            self.helpBtn2.hidden = YES;
            self.helpView3.hidden = NO;
            self.helpBtn3.hidden = NO;
            break;
        }
            
        default:
            [self removeFromSuperview];
            break;
    }
}


@end
