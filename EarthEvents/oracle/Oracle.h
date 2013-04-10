//
//  GetLocation.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/19/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
// Important class that keeps the information upto location. Please check the report for more information

#import "Sensors.h"
#import "ARCloud.h"
#import "calendar.h"
@class Oracle;
@protocol CloudUpdate <NSObject>
-(void)QuadChanged:(NSArray*)places;
@end

@interface Oracle : NSObject<CloudResponse,retriveCalendar>
{
   
    ARCloud *cloud;
    CLLocation *PreviousData;
    NSMutableDictionary *data;
    __weak id<CloudUpdate> delegate;
    NSString *url;
    
}
@property(nonatomic,weak)id<CloudUpdate> delegate;
@property SensorData *sensordata;
@property NSMutableArray *places;
-(void)setDelegate:(id<CloudUpdate>)delegate;
@property (nonatomic,retain) Sensors *sensors;;
-(void)forceUpdate;
@end
