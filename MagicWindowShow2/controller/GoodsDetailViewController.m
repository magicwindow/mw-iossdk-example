//
//  GoodsDetailViewController.m
//  MagicWindowShow
//
//  Created by 刘家飞 on 16/2/25.
//  Copyright © 2016年 cafei. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface DCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *label1;
@property (nonatomic, weak) IBOutlet UILabel *label2;
@property (nonatomic, weak) IBOutlet UILabel *label3;
@property (nonatomic, weak) IBOutlet UILabel *label4;

@end

@implementation DCell

@end


@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray *viewControllers = self.navigationController.viewControllers;
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DianShangVC"];
    if (![viewControllers[0] isKindOfClass:[controller class]])
    {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:viewControllers];
        controller.navigationItem.hidesBackButton = YES;
        [arr replaceObjectAtIndex:0 withObject:controller];
        self.navigationController.viewControllers = arr;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCell"];
    if (self.name1 != nil) cell.label1.text = self.name1;
    if (self.name2 != nil) cell.label2.text = self.name2;
    if (self.name3 != nil) cell.label3.text = self.name3;
    if (self.name4 != nil) cell.label4.text = self.name4;
    return cell;

}

#pragma mark -

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGRectGetWidth(self.view.frame)*590/400;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
