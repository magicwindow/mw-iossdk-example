//
//  BtnViewCell.m
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/18.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "BtnViewCell.h"
#import "BtnView.h"

#define CELL_NUM            4
#define VIEW_HEIGHT         100

@implementation BtnViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)initCell:(NSUInteger)totleNum
{
    _totleNum = totleNum;
    _viewList = [[NSMutableArray alloc] init];
    for (int i = 0;i < _totleNum; i++)
    {
        BtnView *view = (BtnView *)[[NSBundle mainBundle] loadNibNamed:@"BtnView" owner:self options:nil][0];
        view.tag = i;
        [self addSubview:view];
        [_viewList addObject:view];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    float width = CGRectGetWidth(self.frame)/CELL_NUM;
    [_viewList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BtnView *view = (BtnView *)obj;
        NSInteger row = (NSInteger)idx/CELL_NUM;
        view.frame = CGRectMake(idx%CELL_NUM*width, VIEW_HEIGHT*row, width, VIEW_HEIGHT);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
