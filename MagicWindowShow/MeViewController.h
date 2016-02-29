//
//  MeViewController.h
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/9/11.
//  Copyright (c) 2015年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *titlelabel;

@end

@interface MeViewController : UITableViewController

@end
