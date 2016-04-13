//
//  O2OShowCell.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/13/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "O2OShowCell.h"

@implementation O2OShowCell

- (void)awakeFromNib {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"¥138.00"];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, [attributedString length])];
    self.oldPriceLabel.attributedText = attributedString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
