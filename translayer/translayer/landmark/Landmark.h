//
//  Quad.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/16/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "Location.h"
#import "AREvents.h"
#import "landmarkState.h"
#import "ARPointInPolygon.h"
#import <EventKit/EventKit.h>
#import <QuartzCore/QuartzCore.h>
@protocol buttonEvent <NSObject>
-(void)buttonTouch:(id)quad;
@end

@interface Landmark : NSObject
{
    __weak id<buttonEvent> delegate;
  
   
    NSArray *Locations;
    NSNumber *LargestAngle,*state,*minimumdistance;
    int Selected1,Seleceted2;
    float a1,a2;
    UIButton *button;
    NSNumber *buttonX;
    BOOL InsideQuad;
    
}
@property(nonatomic,weak)id<buttonEvent> delegate;
@property(nonatomic,retain)UIButton *button;
@property(nonatomic,retain)   NSString *LocationName,*LocationType,*user,*Q_id;
@property(nonatomic,retain )   NSMutableArray *AltName,*events;
@property(nonatomic,retain)NSArray *finalResult;
@property(nonatomic,retain)NSNumber *minimumdistance,*state;

-(void)addEventsFromCalendar:(NSArray*) CalendarEvents;


-(id)initwithdata:(NSArray*) data;
//-(id)init:(double)x1:(double)y1:(double)x2:(double)y2:(double)x3:(double)y3:(double)x4:(double)y4;
-(void)analyzeWithSensorData:(CLLocation*)currentLocation :(double)compassHeading;

-(void)buttonPriority:(int)y;
-(void)sortEventsbyDate;
-(void)buttonlayer:(CGColorRef)buttoncolor;

@end

