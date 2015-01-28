//
//  BusInfoManager.m
//  BusApp
//
//  Created by Tanzim on 3/19/13.
//  Copyright (c) 2013 Tanzim. All rights reserved.
//

#import "BusInfoManager.h"
#import "AppDelegate.h"
#import "FMDatabase.h"

@implementation BusInfo

@synthesize nRouteID, nHour, nMin;

+ (void) readInitialData:(NSString *)dbPath
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.m_pBusInfoDB = [FMDatabase databaseWithPath:dbPath];
    [appDelegate.m_pBusInfoDB open];
    NSLog(@"Path:%@ ", dbPath);
    // Fetch all users
    FMResultSet *results = [appDelegate.m_pBusInfoDB executeQuery:@"select * from businfo"];
    while([results next]) {
        NSInteger nId  = [results intForColumn:@"routeid"];
        NSInteger nTimeHour = [results intForColumn:@"hour"];
        NSInteger nTimeMin = [results intForColumn:@"min"];
        BusInfo* infoRoute = [[BusInfo alloc] initWithTime:nId hour:nTimeHour minute:nTimeMin];
        [appDelegate.arrayBusInfo addObject:infoRoute];
        NSLog(@"User: %d - %d:%d", nId, nTimeHour, nTimeMin);
    }
    [appDelegate.m_pBusInfoDB close];
}

-(id)initWithTime:(NSInteger)nID hour:(NSInteger)nRouteHour minute:(NSInteger) nRouteMin
{
    self.nRouteID = nID;
    self.nHour = nRouteHour;
    self.nMin = nRouteMin;
    return self;
}

@end
