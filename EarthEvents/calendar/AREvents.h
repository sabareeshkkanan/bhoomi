//
//  AREvents.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "ARMedia.h"
#import <EventKit/EventKit.h>

@interface AREvents : NSObject

@property(strong) NSString *name,*alt,*user,*notes,*eventType;
@property(nonatomic,retain) NSDate *_startDate,*_endDate;
@property(strong) NSMutableArray *media;
@property(strong)NSNumber *sortDate;
@property(strong) NSString *location,*_description,*dates;
-(id)initwithArray:(NSArray*)data;
-(id)initwithEKEvent:(EKEvent*)obj;
@end
