//
//  NewsViewController.h
//  MagicWIndowShow
//  资讯页
//  Created by 刘家飞 on 15/12/10.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;

- (IBAction)tabSelect:(id)sender;

@end
