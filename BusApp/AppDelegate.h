//
//  AppDelegate.h
//  BusApp
//
//  Created by Tanzim on 3/19/13.
//  Copyright (c) 2013 Tanzim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@class BusDBManager;
@class ECSlidingViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString* __weak szBusInfoDBPath;
    NSString* __weak szRouteInfoDbPath;
    NSString* szTotalDBPath;
    
    FMDatabase* __weak m_pBusInfoDB;
    FMDatabase* __weak m_pRouteInfoDB;
    BusDBManager* m_pBusDBManager;
    
    NSMutableArray* arrayRouteInfo;
    NSMutableArray* arrayBusInfo;
}

- (NSString *) getDBPath:(NSString*)szName;
- (void) copyDatabaseIfNeeded:(NSString*)szName;
-(void)GetDisplayData;


@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ECSlidingViewController *slideMenuController;

@property (nonatomic, weak) NSString* szBusInfoDBPath;
@property (nonatomic, weak) NSString* szRouteInfoDbPath;
@property (nonatomic, weak) FMDatabase* m_pBusInfoDB;
@property (nonatomic, weak) FMDatabase* m_pRouteInfoDB;
@property (nonatomic) BusDBManager* m_pBusDBManager;
@property (nonatomic, strong) NSMutableArray* arrayRouteInfo;
@property (nonatomic, strong) NSMutableArray* arrayBusInfo;

@end
