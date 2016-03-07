//
//  BannerScrollView.h
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/1.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerScrollCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *imgLists;
@property (nonatomic, assign) NSUInteger totlePage;
@property (nonatomic, assign) NSUInteger currentPage;

- (void)initCell:(NSUInteger)totlePage;

@end
