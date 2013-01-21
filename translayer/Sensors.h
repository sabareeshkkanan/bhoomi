//
//  Sensors.h
//  sensors
//
//  Created by sabareesh kkanan subramani on 10/5/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//


#import "Quad.h"


@interface Sensors : NSObject  <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CMMotionManager     *motionManager;
    NSOperationQueue    *opQ;
    float               updatedHeading;
    CMAttitude *refattitude;
    SensorData *data;
}
@property (nonatomic, retain) CLLocationManager	*locationManager;
@property (nonatomic, retain) CMMotionManager     *motionManager;
@property (nonatomic, retain) SensorData *data;;
-(void)motion:(BOOL) what;
-(void)gps:(BOOL) what;
-(void)compass:(BOOL) what;
-(void)start;
-(void)stop;
-(SensorData*) update;


@end


