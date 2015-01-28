//
//  Times2ViewController.h
//  BusApp
//
//  Created by lion on 3/19/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface Times2ViewController : GAITrackedViewController<UITableViewDataSource, UITableViewDelegate>
{
    int m_nSelectedIdx;
    IBOutlet UITableView* TimetableView;
    IBOutlet UIButton* btnToUni;
    IBOutlet UIButton* btnToFenner;
    IBOutlet UILabel*  lbToUni;
    IBOutlet UILabel*  lbTOFenner;
    int m_nCurrentHour;
    int m_nCurrentMin;
    int m_nPrevHour;
    int m_nPrevMin;
    NSMutableArray* m_arrayShow;
}

-(void)GetShowData;
-(void)GetCurrentTime;
-(IBAction)changeSelectedIdx:(id)sender;


@end
