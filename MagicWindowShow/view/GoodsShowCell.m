//
//  GoodsShowCell.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/8/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "GoodsShowCell.h"

@implementation GoodsShowCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellWithImageWidth:(CGFloat)width {
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(width * 4, width);
    for (int i = 0;i < 4 ; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(width * i, 0, width, width);
        imageView.tag = i;
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diaper0%i.jpg", i + 1]]];
        [_scrollView addSubview:imageView];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    NSInteger i = x/CGRectGetWidth(scrollView.frame);
    _pageControl.currentPage = i;
}

@end
