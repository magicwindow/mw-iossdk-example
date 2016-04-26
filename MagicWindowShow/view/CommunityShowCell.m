//
//  CommunityShowCell.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/14/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "CommunityShowCell.h"

@implementation CommunityShowCell

- (void)awakeFromNib {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"几天前，Apple 过了它的第 40 个生日。想想 Apple 给我带来了多少好玩有趣的产品和服务，无趣地想象了一番没有 Apple 的世界，或许会有不同，我们会失去 iPod、MacBook、iTunes 甚至是上个月发布的「史上最平价的 iPhone」- iPhone SE。而到今天，我把玩 iPhone SE 已经有几天时间了，也该是时候跟大家分享这几天我的使用感受了。"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.articleBodyLabel.text.length)];
    self.articleBodyLabel.attributedText = attributedString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
