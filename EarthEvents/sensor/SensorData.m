//
//  SensorData.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/16/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//  SensorData model . Class Sensors populates this model with current sensor data when ever it is requested.

#import "SensorData.h"


@implementation SensorData
@synthesize gps,compass,attitude,RealAttitude,Acceleration;
-(id)init
{
    gps=[CLLocation alloc];
    compass=[CLHeading alloc];
    attitude=[CMAttitude alloc];
    RealAttitude=[CMAttitude alloc];
    Acceleration=[CMAccelerometerData alloc];
   
    return self;
}
-(double)lat
{
    return gps.coordinate.latitude;
}
-(double)lng{
    return gps.coordinate.longitude;
}
-(double)heading{
    return compass.trueHeading;
}
-(double)gpsaccu{
    return [gps horizontalAccuracy];
}

-(double) headAccu{
    return compass.headingAccuracy;
}







@end