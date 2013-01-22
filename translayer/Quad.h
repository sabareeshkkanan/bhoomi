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
#import "ARPointInPoly.h"
#import <EventKit/EventKit.h>
@protocol buttonEvent <NSObject>
-(void)buttonTouch:(id)quad;
@end

@interface Quad : NSObject
{
    __weak id<buttonEvent> delegate;
  
    NSArray *temploc;
    NSArray *location;
    NSNumber *LargeAngle,*state,*minimumdistance;
    int Selected1,Seleceted2;
    float a1,a2;
    UIButton *button;
    NSNumber *buttonX;
    BOOL InsideQuad;
    
}
@property(nonatomic,weak)id<buttonEvent> delegate;
@property(nonatomic,retain)UIButton *button;
@property(nonatomic,retain)   NSString *AltName,*LocationName,*LocationType,*user,*Q_id;
@property(nonatomic,retain )   NSMutableArray *Tags,*events;
@property(nonatomic,retain)NSArray *finalResult;
@property(nonatomic,retain)NSNumber *minimumdistance;

-(void)addEventsFromCalendar:(NSArray*) CalendarEvents;


-(id)initwithdata:(NSArray*) data;
//-(id)init:(double)x1:(double)y1:(double)x2:(double)y2:(double)x3:(double)y3:(double)x4:(double)y4;
-(void)calculateAngle:(CLLocation*)start;
-(void)ComputeByGps:(CLLocation*)currentLocation;
-(void)ComputeByHeading:(double)heading;
-(void)buttonPriority:(int)y;

@end

