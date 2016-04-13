//
//  GoodsShowCell.h
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/8/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsShowCell : UITableViewCell <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *imageList;
@property (assign, nonatomic) NSUInteger totalPage;
@property (assign, nonatomic) NSUInteger currentPage;

- (void)setupCellWithImageWidth:(CGFloat)width;
@end
