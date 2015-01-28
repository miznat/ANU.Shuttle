//
//  MenuViewController.h
//  BusApp
//
//  Created by Kirill Ivonin on 28.01.15.
//  Copyright (c) 2015 lion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
