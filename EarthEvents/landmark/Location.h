//
//  Location.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/16/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
// each point in landmark is represented by this class

#import "SensorData.h"
@interface Location:NSObject

@property(nonatomic,retain)CLLocation *point;
@property(nonatomic)float Distance_;
@property(nonatomic)float angle;
@property(nonatomic)float Difference_;
-(void)calculateAngle:(CLLocation*)start;
-(void)calculateDifference:(double)first;
-(id)initwithdata:(CLLocation*)thelocation;
@end