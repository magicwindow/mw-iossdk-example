//
//  BannerScrollView.m
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/1.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "BannerScrollCell.h"

#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width

@implementation BannerScrollCell

- (void)awakeFromNib {
    // Initialization code
   
}

- (void)initCell:(NSUInteger)totlePage
{
    _totlePage = totlePage;
    _pageControl.numberOfPages = _totlePage;
    _pageControl.currentPage = 0;
    _imgLists = [[NSMutableArray alloc]init];
    for (int i = 0;i < _totlePage ; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = i;
        [_scrollView addSubview:imageView];
        [_imgLists addObject:imageView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(_scrollView.frame));
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame)*_totlePage, CGRectGetHeight(_scrollView.frame));
    [_imgLists enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imgView = (UIImageView *)obj;
        imgView.frame = CGRectMake(idx*CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
        
    }];
    
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    NSInteger i = x/CGRectGetWidth(scrollView.frame);
    _pageControl.currentPage = i;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
