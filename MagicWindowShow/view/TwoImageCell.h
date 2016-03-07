//
//  TwoImageCell.h
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/10.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoImageCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *leftImg;
@property (nonatomic, weak) IBOutlet UILabel *leftTitle;
@property (nonatomic, weak) IBOutlet UILabel *leftDesc;

@property (nonatomic, weak) IBOutlet UIImageView *rightImg;
@property (nonatomic, weak) IBOutlet UILabel *rightTitle;
@property (nonatomic, weak) IBOutlet UILabel *rightDesc;

@end
