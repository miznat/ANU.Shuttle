//
//  BusDBManager.m
//  BusApp
//
//  Created by Tanzim on 3/23/13.
//  Copyright (c) 2013 Tanzim. All rights reserved.
//

#import "BusDBManager.h"
#import "AppDelegate.h"
#import "FMDatabase.h"


@implementation TextInfo

@synthesize szText;
@synthesize nID;

@end

@implementation TimeListInfo

@synthesize nID,nHour,nMin;

@end


@implementation StopTime

@synthesize nHour, nMin;

@end

@implementation BusDBManager

@synthesize m_arrayTextList, m_arrayTimeList, m_arrayTimeListText;
@synthesize m_szDataBasePath;

-(id)initWithName:(NSString *)szDBPath
{
    m_arrayTimeList = [[NSMutableArray alloc] init];
    m_arrayTextList = [[NSMutableArray alloc] init];

    m_arrayTimeListText = [[NSMutableArray alloc] init];
    
    m_szDataBasePath = szDBPath;
    [self readInitialData:szDBPath];
    return self;
}

-(void) readInitialData:(NSString *)dbPath
{
    [m_arrayTextList removeAllObjects];
    FMDatabase* totalDB = [FMDatabase databaseWithPath:dbPath];
    [totalDB open];
    NSLog(@"Path:%@ ", dbPath);
    // Fetch all users
    FMResultSet *results = [totalDB executeQuery:@"select * from textlist"];
    while([results next]) {
        NSString *name = [results stringForColumn:@"text"];
        NSInteger nId  = [results intForColumn:@"Id"];
        TextInfo* infoText = [[TextInfo alloc] init];
        infoText.nID = nId;
        infoText.szText = name;
        [m_arrayTextList addObject:infoText];

        NSLog(@"User: %@ - %d",name, nId);
    }
   
//    results = [totalDB executeQuery:@"select * from x"];
//    [m_arrayStopX removeAllObjects];
//    while ([results next])
//    {
//        NSInteger nHour = [results intForColumn:@"Hour"];
//        NSInteger nMin  = [results intForColumn:@"Minute"];
//        StopTime* infoText = [[StopTime alloc] init];
//        infoText.nHour = nHour;
//        infoText.nMin = nMin;
//        [m_arrayStopX addObject:infoText];
//        [infoText release];
//
//        NSLog(@"Stop: %d- %d",nHour, nMin);
//
//    }
//        
//    results = [totalDB executeQuery:@"select * from y"];
//    [m_arrayStopY removeAllObjects];
//    while ([results next])
//    {
//        NSInteger nHour = [results intForColumn:@"Hour"];
//        NSInteger nMin  = [results intForColumn:@"Minute"];
//        StopTime* timeInfo = [[StopTime alloc] init];
//        timeInfo.nHour = nHour;
//        timeInfo.nMin = nMin;
//        [m_arrayStopY addObject:timeInfo];
//        [timeInfo release];
//        NSLog(@"Stop Y time: %d- %d",nHour, nMin);        
//    }
    
 
   
    [totalDB close];
}

-(NSString*)GetTextFromID:(int)nIdOfText
{
    int nCount = [m_arrayTextList count];

    if([m_arrayTextList count] == 0 || nIdOfText > nCount)
        return nil;
    for (int i = 0; i < nCount; i ++)
    {
        TextInfo* info = (TextInfo*)[m_arrayTextList objectAtIndex:i];
        if(info.nID == nIdOfText)
        {
            return  info.szText;
        }
    }
    return nil;
}

-(NSMutableArray*)GetReminTimeList:(NSInteger)hour minute:(NSInteger)min
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    m_szDataBasePath = [appDelgate getDBPath:@"todolist_ios.db"];
    int nCount = 0;

     [m_arrayTimeList removeAllObjects];
    FMDatabase* database = [FMDatabase databaseWithPath:m_szDataBasePath];
    [database open];
    NSString* query = [NSString stringWithFormat:@"select * from timelist where (Hour=%d and Minute > %d) or (Hour > %d) order by Hour, Minute", hour, min, hour];
    FMResultSet *results = [database executeQuery:query];
    
    while([results next]) {
        
        NSInteger nHour  = [results intForColumn:@"Hour"];
        NSInteger nMin  = [results intForColumn:@"Minute"];
        NSInteger nID = [results intForColumn:@"Id"];
        TimeListInfo* infoTime = [[TimeListInfo alloc] init];
        infoTime.nID = nID;
        infoTime.nMin = nMin;
        infoTime.nHour = nHour;
        [array addObject: infoTime];
        
        NSLog(@"User:%d ---- %d : %d",nID, nHour, nMin);
        nCount ++;
    }
    
    [database close];

    return array;
}

-(NSMutableArray*)GetTimeListByText:(int)nID
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    m_szDataBasePath = [appDelgate getDBPath:@"todolist_ios.db"];
    if(m_szDataBasePath == nil)
        return  0;
    int nCount = 0;
    [m_arrayTimeListText removeAllObjects];
    FMDatabase* database = [FMDatabase databaseWithPath:m_szDataBasePath];
    [database open];
    NSString* query = [NSString stringWithFormat:@"select * from timelist where Id = %d order by Hour, Minute", nID];
    FMResultSet *results = [database executeQuery:query];
    while([results next]) {
        NSInteger nHour  = [results intForColumn:@"Hour"];
        NSInteger nMin  = [results intForColumn:@"Minute"];
        TimeListInfo* infoTime = [[TimeListInfo alloc] init] ;
        infoTime.nID = nID;
        infoTime.nMin = nMin;
        infoTime.nHour = nHour;
        [array addObject:infoTime];
        NSLog(@"User: %d : %02d",nHour, nMin);
        nCount ++;
    }
    
    [database close];
    
    return  array;
}

-(NSMutableArray*)GetReminXList:(NSInteger)hour minute:(NSInteger)min
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    m_szDataBasePath = [appDelgate getDBPath:@"todolist_ios.db"];
    int nCount = 0;
    
    [m_arrayTimeList removeAllObjects];
    FMDatabase* database = [FMDatabase databaseWithPath:m_szDataBasePath];
    [database open];
    NSString* query = [NSString stringWithFormat:@"select * from x where (Hour=%d and Minute > %d) or (Hour > %d) order by Hour, Minute", hour, min, hour];
    FMResultSet *results = [database executeQuery:query];
    
    while ([results next])
    {
        NSInteger nHour = [results intForColumn:@"Hour"];
        NSInteger nMin  = [results intForColumn:@"Minute"];
        StopTime* infoText = [[StopTime alloc] init];
        infoText.nHour = nHour;
        infoText.nMin = nMin;
        [array addObject:infoText];
        NSLog(@"Stop: %d- %d",nHour, nMin);
        nCount ++;
    }

    
    [database close];
    
    return  array;
    
}
-(NSMutableArray*)GetReminYList:(NSInteger)hour minute:(NSInteger)min
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    m_szDataBasePath = [appDelgate getDBPath:@"todolist_ios.db"];
    int nCount = 0;
    
    [m_arrayTimeList removeAllObjects];
    FMDatabase* database = [FMDatabase databaseWithPath:m_szDataBasePath];
    [database open];
    NSString* query = [NSString stringWithFormat:@"select * from y where (Hour=%d and Minute > %d) or (Hour > %d) order by Hour, Minute", hour, min, hour];
    FMResultSet *results = [database executeQuery:query];
    
    while ([results next])
    {
        NSInteger nHour = [results intForColumn:@"Hour"];
        NSInteger nMin  = [results intForColumn:@"Minute"];
        StopTime* infoText = [[StopTime alloc] init];
        infoText.nHour = nHour;
        infoText.nMin = nMin;
        [array addObject:infoText];
        NSLog(@"Stop: %d- %d",nHour, nMin);
        nCount ++;
    }
    
    
    [database close];
    
    return  array;
}

-(void)dealloc
{
    [m_arrayTimeListText removeAllObjects];
    [m_arrayTimeList removeAllObjects];
    [m_arrayTextList removeAllObjects];

}

@end
