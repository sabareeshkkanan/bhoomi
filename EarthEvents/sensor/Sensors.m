//
//  Sensors.m
//  sensors
//
//  Created by sabareesh kkanan subramani on 10/5/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "Sensors.h"

@implementation Sensors
@synthesize locationManager,motionManager,data;
const double radconst=1.57079633;
-(id) init
{
    
    self = [super init];
    if (self)
    {
        data=[SensorData alloc];
    
        locationManager=[[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest ;
        locationManager.delegate=self;
        motionManager = [[CMMotionManager alloc]  init];
        motionManager.deviceMotionUpdateInterval = 1.0/60.0;
        
    }
    return self;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    [data setCompass:newHeading];
    if(newHeading.trueHeading<0.5||newHeading.trueHeading>359.5)
        refattitude=motionManager.deviceMotion.attitude;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
  //  CLLocation *fakelocation=[[CLLocation alloc] initWithLatitude:33.12914631901343 longitude:-117.15909898281097];
    CLLocation *f2=[[CLLocation alloc] initWithLatitude:33.1303132355608 longitude:-117.15802609920502];
   //     CLLocation *f3=[[CLLocation alloc] initWithLatitude:33.13025820458865 longitude:-117.1581843495369];
    
         [data setGps:f2];
//[data setGps:newLocation];
    
       
    
}


-(void) motion:(BOOL) what{
    if(what){
        [motionManager startDeviceMotionUpdates];
        [motionManager startAccelerometerUpdates];}
    else{
        [motionManager stopDeviceMotionUpdates];
    [motionManager stopAccelerometerUpdates];}
}
-(void) gps:(BOOL) what{
    if(what)
        [locationManager startUpdatingLocation];
    else
        [locationManager stopUpdatingLocation];
}
-(void)compass:(BOOL) what{
    if(what)
        [locationManager startUpdatingHeading];
    else
        [locationManager stopUpdatingHeading];
}
-(void)start{
    [self motion:YES];
    [self gps:YES];
    [self compass:YES];
}
-(void)stop
{
    [self motion:NO];
    [self gps:NO];
    [self compass:NO];
}
-(SensorData*) update
{
    [data setAcceleration:motionManager.accelerometerData];
    CMAttitude *currentAttitude=motionManager.deviceMotion.attitude;
    [data setRealAttitude:motionManager.deviceMotion.attitude];
if(refattitude)
    [currentAttitude multiplyByInverseOfAttitude:refattitude];
    [data setAttitude:currentAttitude];
    
    return data;
    
}


- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    return YES;
}

@end