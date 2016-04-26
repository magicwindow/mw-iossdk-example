//
//  O2ODetailController.h
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/13/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface O2ODetailController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backButtonClicked:(id)sender;
- (IBAction)shareButtonClicked:(id)sender;

@end
