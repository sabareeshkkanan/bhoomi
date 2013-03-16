//
//  SensorData.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/16/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>

@interface SensorData : NSObject

@property (nonatomic, retain)   CLLocation *gps;
@property (nonatomic, retain)   CLHeading *compass;
@property (nonatomic, retain)   CMAttitude *attitude;
@property (nonatomic, retain)   CMAttitude *RealAttitude;
@property (nonatomic, retain)   CMAccelerometerData *Acceleration;


-(double)lat;
-(double)lng;
-(double)heading;
-(double)headAccu;
-(double)gpsaccu;
@end