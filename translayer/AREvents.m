//
//  AREvents.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "AREvents.h"

@implementation AREvents
@synthesize name,alt,info,user,startDate,endDate,media,notes,eventType;
-(id)initwithArray:(NSArray*)data
{
    eventType=@"public";
    alt=[data valueForKey:@"alt"];
    name=[data valueForKey:@"name"];
    info=[data valueForKey:@"info"];
    user=[data valueForKey:@"user"];
    media=[[NSMutableArray alloc] init];
    startDate=[data valueForKey:@"startDate"];
    endDate=[data valueForKey:@"endDate"];
    [self populateMedia:[data valueForKey:@"media"]];
    return self;
}
-(id)initwithEKEvent:(EKEvent *)obj
{
   NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSTimeZone *gmt = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:gmt];
    eventType=@"personal";
    name=obj.title;
    startDate=[dateFormatter stringFromDate:obj.startDate];
    endDate=[dateFormatter stringFromDate:obj.endDate];
    notes=obj.notes;
   
    return self;
}
-(void)populateMedia:(NSArray*)datax{
    for(NSArray *objx in datax){
        
             ARMedia *med=[[ARMedia alloc] initwitharray:objx];
        [media addObject:med];
        
       
    }
}

@end
