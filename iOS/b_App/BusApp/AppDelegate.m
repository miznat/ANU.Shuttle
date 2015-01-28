//
//  AppDelegate.m
//  BusApp
//
//  Created by lion on 3/19/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"

#import "SecondViewController.h"
#import "Times2ViewController.h"
#import "RouteInfoManager.h"
#import "BusInfoManager.h"
#import "InfoViewController.h"
#import "BusDBManager.h"
#import "GAI.h"

//#import <Scringo/ScringoAgent.h>

@implementation AppDelegate

@synthesize szRouteInfoDbPath, szBusInfoDBPath;
@synthesize arrayBusInfo, arrayRouteInfo;
@synthesize m_pBusInfoDB, m_pRouteInfoDB;
@synthesize m_pBusDBManager;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

#define FLURRY_API_KEY @"xxP6QQCYB5PM67FPN9Z9NF"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
   // [ScringoAgent startSession:@"MW921uFiZ4DKkisTNdEMi9VDmCDgUidR" locationManager:nil];
    
    // Start Flurry Analytics
	[Flurry startSession:FLURRY_API_KEY];
	
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    // Optional: set debug to YES for extra debugging information.
    [GAI sharedInstance].debug = YES;
    // Create tracker instance.
    id<GAITracker> googleTracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-39220154-2"];
    
    
    
    szTotalDBPath = [self getDBPath:@"todolist_ios.db"];

    [self copyDatabaseIfNeeded:@"todolist_ios.db"];
    
    m_pBusDBManager = [[BusDBManager alloc] initWithName:szTotalDBPath];
//    [self GetDisplayData];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil] autorelease];
    UIViewController *viewController2 = [[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil] autorelease];
    
    UIViewController *viewController3= [[[Times2ViewController alloc] initWithNibName:@"Times2ViewController" bundle:nil] autorelease];
    UIViewController *viewController4= [[[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil] autorelease];
    

    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = @[viewController1, viewController2, viewController3, viewController4];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    if(arrayRouteInfo)
    {
        [arrayRouteInfo removeAllObjects];
        [arrayRouteInfo release];
    }
    if(arrayBusInfo)
    {
        [arrayBusInfo removeAllObjects];
        [arrayBusInfo release];
    }
}


- (void) copyDatabaseIfNeeded:(NSString*)szName {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath:szName];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:szName];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

- (NSString *) getDBPath:(NSString*)szName {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:szName];
}

-(void)GetDisplayData
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    int m_nShowCount = [m_pBusDBManager GetReminTimeList:10 minute:10];
    
}
/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/



@end
