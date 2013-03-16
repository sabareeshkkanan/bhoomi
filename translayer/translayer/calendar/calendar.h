//
//  calendar.h
//  sensors
//
//  Created by sabareesh kkanan subramani on 10/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import <EventKit/EventKit.h>
@class calendar;
@protocol retriveCalendar <NSObject>
-(void)onCalendarRetrive:(NSArray*)calendarEvents;
@end

@interface calendar : NSObject
{
     EKEventStore *store;
    NSArray *events;
    __weak id<retriveCalendar> delegate;

}

@property(nonatomic,weak)id<retriveCalendar> delegate;
@end
