//
//  RouteInfoManager.m
//  BusApp
//
//  Created by lion on 3/19/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import "RouteInfoManager.h"
#import "AppDelegate.h"
#import "FMDatabase.h"

@implementation RouteTime

@synthesize nBusHour, nBusMin;

@end


@implementation RouteInfo

@synthesize routeID, routeName;

+ (void) readInitialData:(NSString *)dbPath
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.m_pRouteInfoDB = [FMDatabase databaseWithPath:dbPath];
    [appDelegate.m_pRouteInfoDB open];
    NSLog(@"Path:%@ ", dbPath);
    // Fetch all users
    FMResultSet *results = [appDelegate.m_pRouteInfoDB executeQuery:@"select * from routeinfo"];
    while([results next]) {
        NSString *name = [results stringForColumn:@"routename"];
        NSInteger nId  = [results intForColumn:@"routeid"];
        RouteInfo* infoRoute = [[RouteInfo alloc] initWithName:name idRoute:nId];
        [appDelegate.arrayRouteInfo addObject:infoRoute];
        NSLog(@"User: %@ - %d",name, nId);
    }
    [appDelegate.m_pRouteInfoDB close];
}

-(id)initWithName:(NSString *)route idRoute:(NSInteger)nIndex
{
    self.routeName = route;
    self.routeID = nIndex;
    
    return self;
}

@end
