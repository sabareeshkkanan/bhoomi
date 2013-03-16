//
//  calendar.m
//  sensors
//
//  Created by sabareesh kkanan subramani on 10/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "calendar.h"

@implementation calendar
@synthesize delegate;

-(id)init
{
    store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        // handle access here
        [self try];
    }];
    
    return self;
}
-(void) try
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
        
    // Create the start date components
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    oneDayAgoComponents.day = -1;
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:[NSDate date]
                                                 options:0];
    
    // Create the end date components
    NSDateComponents *oneWeek=[[NSDateComponents alloc] init];
    oneWeek.week=1;
    NSDate *oneWeekFromNow=[calendar dateByAddingComponents:oneWeek toDate:[NSDate date] options:0];
 [calendar setTimeZone:[NSTimeZone systemTimeZone]];

    
    // Create the predicate from the event store's instance method
    NSPredicate *predicate = [store predicateForEventsWithStartDate:oneDayAgo
                                                            endDate:oneWeekFromNow
                                                          calendars:nil];
    
    // Fetch all events that match the predicate
    events = [store eventsMatchingPredicate:predicate];
    [delegate onCalendarRetrive:events];
   // NSLog(@"%@",events);

}

@end
