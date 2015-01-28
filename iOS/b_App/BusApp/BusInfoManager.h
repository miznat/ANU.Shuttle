//
//  BusInfoManager.h
//  BusApp
//
//  Created by lion on 3/19/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusInfo : NSObject
{
    NSInteger nRouteID;
    NSInteger nHour;
    NSInteger nMin;
}

-(id)initWithTime:(NSInteger)nID hour:(NSInteger)nRouteHour minute:(NSInteger) nRouteMin;
+ (void) readInitialData:(NSString *)dbPath;

@property (nonatomic) NSInteger nRouteID;
@property (nonatomic) NSInteger nHour;
@property (nonatomic) NSInteger nMin;

@end
