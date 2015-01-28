//
//  FirstViewController.h
//  BusApp
//
//  Created by lion on 3/19/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"



@interface FirstViewController : GAITrackedViewController<UITableViewDelegate, UITableViewDataSource>
{
    int m_nCurrentHour;
    int m_nCurrentMin;
    int m_nShowCount;
    int m_nPreveHour;
    int m_nPreveMin;

    IBOutlet UITableView* timeTableView;
    NSMutableArray* m_arrayTime;
    
}

-(void)GetCurrentTime;
-(void)GetDisplayData;

@end

@interface TimeTable : NSObject
{
    NSString* szRouteName;
    NSInteger nRouteHour;
    NSInteger nRouteMin;
}

@property(nonatomic, retain)     NSString* szRouteName;
@property(nonatomic) NSInteger nRouteHour;
@property(nonatomic) NSInteger nRouteMin;

@property (retain, nonatomic) IBOutlet UINavigationBar *navBar;

@end
