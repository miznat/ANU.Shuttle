//
//  RouteInfoManager.h
//  BusApp
//
//  Created by lion on 3/19/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface RouteTime : NSObject
{
    NSInteger nBusHour;
    NSInteger nBusMin;
    
}

@property (nonatomic)     NSInteger nBusHour;
@property (nonatomic)     NSInteger nBusMin;

@end


@interface RouteInfo : NSObject{
    NSInteger routeID;
    NSString*   routeName;
}


@property (nonatomic) NSInteger routeID;
@property (nonatomic, retain) NSString* routeName;

//static method
+ (void) readInitialData:(NSString *)dbPath;
-(id)initWithName:(NSString *)route idRoute:(NSInteger)nIndex;

@end
