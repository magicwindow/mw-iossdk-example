//
//  O2ODetailController.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/13/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "O2ODetailController.h"
#import "O2OShowCell.h"

@interface O2ODetailController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation O2ODetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"O2OShowCell";
    [tableView registerNib:[UINib nibWithNibName:@"O2OShowCell" bundle:nil] forCellReuseIdentifier:identifier];
    O2OShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetWidth(tableView.frame)*385/400 + 223 + 88;
}

@end
