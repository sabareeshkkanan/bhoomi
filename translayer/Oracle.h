//
//  GetLocation.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/19/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

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
    SensorData *PreviousData;
    NSMutableDictionary *data;
    __weak id<CloudUpdate> delegate;
    NSString *url;
    
}
@property(nonatomic,weak)id<CloudUpdate> delegate;
@property SensorData *sensordata;
@property NSMutableArray *places;
-(void)setDelegate:(id<CloudUpdate>)delegate;
@property (nonatomic,retain) Sensors *sensors;;

@end
