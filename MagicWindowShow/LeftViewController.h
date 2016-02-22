//
//  LeftViewController.h
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/1.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell


@end

@interface MenuCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *img;
@property (nonatomic, weak) IBOutlet UILabel *title;

@end

@interface LeftViewController : UIViewController

@end
