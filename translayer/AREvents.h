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

@property(strong) NSString *name,*alt,*info,*user,*startDate,*endDate,*notes,*eventType;
@property(strong) NSMutableArray *media;
-(id)initwithArray:(NSArray*)data;
-(id)initwithEKEvent:(EKEvent*)obj;
@end
