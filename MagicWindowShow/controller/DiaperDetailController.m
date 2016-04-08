//
//  DiaperDetailController.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/8/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "DiaperDetailController.h"
#import "GoodsShowCell.h"

@interface DiaperDetailController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation DiaperDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabelViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *identifier = @"GoodsShowCell";
        [tableView registerNib:[UINib nibWithNibName:@"GoodsShowCell" bundle:nil] forCellReuseIdentifier:identifier];
        GoodsShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell setupCellWithImageWidth:self.view.frame.size.width];
        return cell;
    } else if (indexPath.row == 1) {
        NSString *identifier = @"OtherInfoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        return cell;
    } else {
        NSString *identifier = @"LongPictureCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    switch (indexPath.row) {
        case 0:
        {
            height = CGRectGetWidth(tableView.frame)*400/400 + 109 + 10;
            break;
        }
        case 1:
        {
            height = 128;
            break;
        }
        case 2:
        {
            height = CGRectGetWidth(tableView.frame)*10213/640;
            break;
        }
        case 4:
        {
            height = 45 + (CGRectGetWidth(tableView.frame)*120/400)*2 + 32;
            break;
        }
        default:
            height = CGRectGetWidth(tableView.frame)*326/400;
            break;
    }
    return height;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
