//
//  BtnViewCell.h
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/18.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BtnViewCell : UITableViewCell
{
    NSUInteger _totleNum;
}

@property (nonatomic,strong) NSMutableArray *viewList;

- (void)initCell:(NSUInteger)totleNum;

@end
