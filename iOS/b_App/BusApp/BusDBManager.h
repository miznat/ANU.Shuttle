//
//  BusDBManager.h
//  BusApp
//
//  Created by lion on 3/23/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextInfo : NSObject
{
    NSInteger nID;
    NSString* szText;
}

@property(nonatomic)     NSInteger nID;
@property(nonatomic, retain)     NSString* szText;

@end

@interface TimeListInfo : NSObject
{
    NSInteger nHour;
    NSInteger nMin;
    NSInteger nID;
}

@property(nonatomic)     NSInteger nHour;
@property(nonatomic)     NSInteger nMin;
@property(nonatomic)     NSInteger nID;

@end

@interface StopTime : NSObject
{
    NSInteger nHour;
    NSInteger nMin;
}

@property(nonatomic)     NSInteger nHour;
@property(nonatomic)     NSInteger nMin;

@end

@interface BusDBManager : NSObject
{
    NSMutableArray* m_arrayTextList;
    NSMutableArray* m_arrayTimeList;
    NSMutableArray* m_arrayTimeListText;
    NSString* m_szDataBasePath;
    
}

@property(nonatomic, retain)     NSMutableArray* m_arrayTextList;
@property(nonatomic, retain)     NSMutableArray* m_arrayTimeList;
@property(nonatomic, retain)     NSMutableArray* m_arrayTimeListText;
@property(nonatomic, retain)        NSString* m_szDataBasePath;

-(void) readInitialData:(NSString *)dbPth;
-(id)initWithName:(NSString *)szDBPath;
-(NSMutableArray*)GetReminTimeList:(NSInteger)hour minute:(NSInteger)min;
-(NSString*)GetTextFromID:(int)nIdOfText;
-(NSMutableArray*)GetTimeListByText:(int)nID;
-(NSMutableArray*)GetReminXList:(NSInteger)hour minute:(NSInteger)min;
-(NSMutableArray*)GetReminYList:(NSInteger)hour minute:(NSInteger)min;


@end
