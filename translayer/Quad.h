//
//  Quad.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/16/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "Location.h"
#import "AREvents.h"
#import "angleAnalyzer.h"
#import <EventKit/EventKit.h>
@interface Quad : NSObject
{
    
  
    NSArray *temploc;
    NSArray *location;
    NSNumber *LargeAngle,*state,*minimumdistance;
    int Selected1,Seleceted2;
    float a1,a2;
    
}
@property(nonatomic,retain)   NSString *AltName,*LocationName,*LocationType,*user,*Q_id;
@property(nonatomic,retain )   NSMutableArray *Tags,*events;
@property(nonatomic,retain)NSArray *finalResult;

-(void)addEventsFromCalendar:(NSArray*) CalendarEvents;


-(id)initwithdata:(NSArray*) data;
//-(id)init:(double)x1:(double)y1:(double)x2:(double)y2:(double)x3:(double)y3:(double)x4:(double)y4;
-(void)calculateAngle:(CLLocation*)start;
-(void)MaximumAngle:(CLLocation*)currentLocation;
-(void)displayAngle:(double)heading;
@end

