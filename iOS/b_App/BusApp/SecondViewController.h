//
//  SecondViewController.h
//  BusApp
//
//  Created by lion on 3/19/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface SecondViewController : GAITrackedViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray* m_pArrayTimes;
    IBOutlet UIView* m_detailView;
    IBOutlet UITableView* m_detailTableView;
    IBOutlet UITableView* m_OrgTableView;
    IBOutlet UILabel*     m_lbTitleDetail;
    BOOL    m_fShowDetail;
    int m_nDeteilCount;
    int m_nSelectedIdx;
}

@property(nonatomic, assign)     NSMutableArray* m_pArrayTimes;
-(void)readData: (int)nID;
-(IBAction)onBack:(id)sender;
-(void)animationView:(UIView*)view initFrame:(CGRect)sFrame endFrame:(CGRect)eFrame initAlpha:(float)sAlpha endAlpha:(float)eAlpha  animationtime:(float)rTime;
-(void)showDetailView;

@end