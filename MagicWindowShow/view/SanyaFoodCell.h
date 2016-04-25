//
//  SanyaFoodCell.h
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/7/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SanyaFoodCell : UITableViewCell
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *foodImageWidthConstraint;
@property (strong, nonatomic) IBOutlet UIImageView *moreFoodImageView;
@property (strong, nonatomic) IBOutlet UIImageView *food1ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *food2ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *food3ImageView;

@end
