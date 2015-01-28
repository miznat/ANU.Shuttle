//
//  MenuViewController.m
//  BusApp
//
//  Created by Kirill Ivonin on 28.01.15.
//  Copyright (c) 2015 lion. All rights reserved.
//

#import "MenuViewController.h"
#import "ECSlidingViewController.h"

@interface MenuViewController () {
    NSArray *menuItems;
    NSArray *menuItemsNames;
}

@property (nonatomic, strong) ECSlidingViewController *slideVC;

@end

@implementation MenuViewController
@synthesize tableView;

-  (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    menuItemsNames = @[NSLocalizedString(@"UniSafe", @"UniSafe"),NSLocalizedString(@"UniStops", @"UniStops"),NSLocalizedString(@"Fenner Bus", @"Fenner Bus"),NSLocalizedString(@"INFO", @"INFO")];
    menuItems = @[@"FirstViewController",@"SecondViewController",@"Times2ViewController",@"InfoViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ECSlidingViewController *)slideVC
{
    UIViewController *viewController = self.parentViewController ? self.parentViewController : self.presentingViewController;
    while (! (viewController == nil || [viewController isKindOfClass:[ECSlidingViewController class]])) {
        viewController = viewController.parentViewController ?: viewController.presentingViewController;
    }
    return (ECSlidingViewController *)viewController;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuItems.count;
}

- (UITableViewCell*)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = cell.isSelected ? [UIColor colorWithRed:0. green:0. blue:1. alpha:1.] : [UIColor colorWithRed:1. green:1. blue:0 alpha:1.];
    cell.textLabel.text = menuItemsNames[indexPath.row];
    [cell.textLabel setFont:[UIFont fontWithName:@"LithosPro-Black" size:20]];
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [aTableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor colorWithRed:0. green:0. blue:1. alpha:1.];
    self.slideVC.topViewController = [[NSClassFromString(menuItems[indexPath.row]) alloc] initWithNibName:menuItems[indexPath.row] bundle:nil];
    [self.slideVC resetTopViewAnimated:YES];
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
