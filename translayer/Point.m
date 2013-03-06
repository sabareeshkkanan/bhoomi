//
//  Location.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/16/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "Point.h"

const double radconst=1.57079633;
@implementation Point
@synthesize point,Distance_,angle,Difference_;
-(id)initwithdata:(CLLocation*)thelocation
{
    [self setPoint:thelocation];
    return self;
}


-(void)calculateAngle:(CLLocation*)start
{
   
    [self setAngle:[self rtd:[self quadcalc:start :point ]]];
    [self setDistance_:[self distance:start :point]];
   
}

-(double) distance:(CLLocation*) point1 :(CLLocation*)point2
{
    return [point1 distanceFromLocation:point2];
}
-(double) tAdjacent:(CLLocation*) point1 :(CLLocation*)point2{
    CLLocation *p3=[[CLLocation alloc] initWithLatitude:point2.coordinate.latitude   longitude:point1.coordinate.longitude];
    
    return [self distance:point1 :p3];
}
-(double) tOpposite:(CLLocation*) point1 :(CLLocation*)point2{
    CLLocation *p3=[[CLLocation alloc] initWithLatitude:point2.coordinate.latitude   longitude:point1.coordinate.longitude];
    return [self distance:point2 :p3];
}
-(double) tAngle:(CLLocation*) point1 :(CLLocation*)point2
{
    double ang=[self tOpposite:point1 :point2]/[self tAdjacent:point1 :point2];
    ang=atan(ang);
    return ang;
}
-(float) quadcalc:(CLLocation*) point1 :(CLLocation*)point2
{
    double ang=[self tAngle:point1 :point2];
    if(point2.coordinate.longitude<=point1.coordinate.longitude && point2.coordinate.latitude>=point1.coordinate.latitude)
        return (4*radconst)-ang;
    else if (point2.coordinate.longitude<=point1.coordinate.longitude && point2.coordinate.latitude<=point1.coordinate.latitude)
        return (2*radconst)+ang;
    else if (point2.coordinate.longitude>=point1.coordinate.longitude && point2.coordinate.latitude<=point1.coordinate.latitude)
        return (radconst*2)-ang;
    else if (point2.coordinate.longitude>=point1.coordinate.longitude && point2.coordinate.latitude>=point1.coordinate.latitude)
        return ang;
    else
        return 0.0;
    
}
-(void)calculateDifference:(double)first{
    double difference=angle-first;
    while (difference < -180) difference += 360;
    while (difference > 180) difference -= 360;
    [self setDifference_:difference];
}


-(float) rtd:(float) radians
{
    return radians * 180 / M_PI;
}

@end
