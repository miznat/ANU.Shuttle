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

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    NSString* szBusInfoDBPath;
    NSString* szRouteInfoDbPath;
    NSString* szTotalDBPath;
    
    FMDatabase* m_pBusInfoDB;
    FMDatabase* m_pRouteInfoDB;
    BusDBManager* m_pBusDBManager;
    
    NSMutableArray* arrayRouteInfo;
    NSMutableArray* arrayBusInfo;
}

- (NSString *) getDBPath:(NSString*)szName;
- (void) copyDatabaseIfNeeded:(NSString*)szName;
-(void)GetDisplayData;


@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, assign) NSString* szBusInfoDBPath;
@property (nonatomic, assign) NSString* szRouteInfoDbPath;
@property (nonatomic, assign) FMDatabase* m_pBusInfoDB;
@property (nonatomic, assign) FMDatabase* m_pRouteInfoDB;
@property (nonatomic, assign) BusDBManager* m_pBusDBManager;
@property (nonatomic, retain) NSMutableArray* arrayRouteInfo;
@property (nonatomic, retain) NSMutableArray* arrayBusInfo;

@end
