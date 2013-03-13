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
@synthesize sortDate,_description,dates;
-(id)initwithArray:(NSArray*)data
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    eventType=@"public";
    alt=[data valueForKey:@"alt"];
    name=[data valueForKey:@"name"];
    notes=[[data valueForKey:@"notes"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ];
    user=[data valueForKey:@"user"];
    media=[[NSMutableArray alloc] init];
    _startDate=[dateFormatter dateFromString:[data valueForKey:@"startDate"]];
    _endDate=[dateFormatter dateFromString:[data valueForKey:@"endDate"]];
    _description=[[data valueForKey:@"description"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ];
    sortDate=[NSNumber numberWithDouble:[_startDate timeIntervalSince1970]];
    
    
    
    [self populateMedia:[data valueForKey:@"media"]];
    [self formatDate];
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
    _startDate=obj.startDate;
    _endDate=obj.endDate;
    notes=[obj.notes stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ];
    sortDate=[NSNumber numberWithDouble:[obj.startDate timeIntervalSince1970]];
    [self formatDate];
    return self;
}
-(void)populateMedia:(NSArray*)datax{
    for(NSArray *objx in datax){
        
             ARMedia *med=[[ARMedia alloc] initwitharray:objx];
        [media addObject:med];
        
       
    }
}  
-(void)formatDate
{
    NSDateFormatter *year=[[NSDateFormatter alloc] init];
    year.dateFormat=@"yyyy";
    NSDateFormatter *month=[[NSDateFormatter alloc] init];
    month.dateFormat=@"MMM";
    NSDateFormatter *day=[[NSDateFormatter alloc] init];
    day.dateFormat=@"dd";
    NSDateFormatter *time=[[NSDateFormatter alloc] init];
    time.dateFormat=@"HH:mm";
    NSDateFormatter *week=[[NSDateFormatter alloc] init];
    week.dateFormat=@"EEE";
    NSDateFormatter *result=[[NSDateFormatter alloc] init];
    result.dateFormat=@"EEE, MMM dd, HH:mm";
         dates=[result stringFromDate:_startDate];
  if([[year stringFromDate:_startDate] isEqualToString:[year stringFromDate:_endDate]])
    {
            if([[day stringFromDate:_startDate] isEqualToString:[day stringFromDate:_endDate]])
                dates=[dates stringByAppendingFormat:@" - %@",[time stringFromDate:_endDate]];
            else
                dates=[dates stringByAppendingFormat:@" - %@, %@ %@, %@",[week stringFromDate:_endDate],[month stringFromDate:_endDate],[day stringFromDate:_endDate],[time stringFromDate:_endDate]];
    }
    else
        dates=[dates stringByAppendingFormat:@" - %@, %@ %@, %@, %@",[week stringFromDate:_endDate],[month stringFromDate:_endDate],[day stringFromDate:_endDate],[year stringFromDate:_endDate],[time stringFromDate:_endDate]];
        
}

@end
