//
//  AREvents.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "AREvents.h"

@implementation AREvents
@synthesize name,alt,user,_startDate,_endDate,media,notes,eventType;
@synthesize sortDate,_description;
-(id)initwithArray:(NSArray*)data
{
    eventType=@"public";
    alt=[data valueForKey:@"alt"];
    name=[data valueForKey:@"name"];
    notes=[data valueForKey:@"notes"];
    user=[data valueForKey:@"user"];
    media=[[NSMutableArray alloc] init];
    _startDate=[data valueForKey:@"startDate"];
    _endDate=[data valueForKey:@"endDate"];
    _description=[data valueForKey:@"description"];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    sortDate=[NSNumber numberWithDouble:[[dateFormatter dateFromString:_startDate] timeIntervalSince1970]];
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
    _startDate=[dateFormatter stringFromDate:obj.startDate];
    _endDate=[dateFormatter stringFromDate:obj.endDate];
    notes=obj.notes;
    sortDate=[NSNumber numberWithDouble:[obj.startDate timeIntervalSince1970]];
    return self;
}
-(void)populateMedia:(NSArray*)datax{
    for(NSArray *objx in datax){
        
             ARMedia *med=[[ARMedia alloc] initwitharray:objx];
        [media addObject:med];
        
       
    }
}

@end
