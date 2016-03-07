//
//  NewsCell.h
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/10.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *desc;

@end
