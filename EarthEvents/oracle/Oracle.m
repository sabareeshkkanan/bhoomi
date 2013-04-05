//
//  GetLocation.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/19/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "Oracle.h"

@implementation Oracle
@synthesize sensordata,places,sensors;
@synthesize delegate;
-(id)init
{
    cloud=[[ARCloud alloc] init];
    [cloud setDelegate:self];
    sensors=[[Sensors alloc] init];
   
    sensordata=[[SensorData alloc]init];
    PreviousData=[[SensorData alloc]init];
    places=[[NSMutableArray alloc] init];
    data=[[NSMutableDictionary alloc] init];
    [sensors start];
    [self poll];
  
    
    url=@"https://ar.seedspirit.com/query/query.php";
    
    
    return self;
}

-(void)check{
    sensordata=[sensors update];
    if([self IsUpdateRequired]){
        [self poll];
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:10.0
                                         target:self
                                       selector:@selector(check)
                                       userInfo:nil
                                        repeats:NO];

    }
 
}

-(void)poll{
    sensordata=[sensors update];
    NSMutableDictionary *json=[[NSMutableDictionary alloc] init];
   if([sensordata lat]==0.0)
   {
       [NSTimer scheduledTimerWithTimeInterval:1.0
                                        target:self
                                      selector:@selector(poll)
                                      userInfo:nil
                                       repeats:NO];

   }else{
    
    [json setObject:[NSArray arrayWithObjects:[self DtoNum:[sensordata lng]],[self DtoNum:[sensordata lat]], nil] forKey:@"Location"];
       [json setObject:@"1000" forKey:@"range"];
        [cloud requestwithArray:json:url];
       PreviousData=[sensors update];
       [self check];
       
   }
  
}
-(void)OnDownload:(NSData *)thedata :(int)url
{
   NSLog(@"%@",[[NSString alloc] initWithData:thedata encoding:NSUTF8StringEncoding]);
    data=[NSJSONSerialization JSONObjectWithData:thedata options:0 error:nil];
  
    [self createQuad:data];
}
-(BOOL)IsUpdateRequired{
   
    if([[sensordata gps] distanceFromLocation:[PreviousData gps]]>100)
        return true;
    return false;
}
-(NSNumber*)DtoNum:(double)val
{
    return [NSNumber numberWithDouble:val];
}
-(void)createQuad:(NSDictionary*)results
{
    NSDictionary *quad=results[@"results"];
    NSDictionary *threeD=results[@"threeD"];
 //   NSLog(@"%@",results);
    
    [places removeAllObjects];
    calendar *calEvents=[[calendar alloc] init];
    [calEvents setDelegate:self];
       NSArray *objects=[quad valueForKey:@"obj"];
      
   
    for (NSArray *key in objects) {
              Landmark *newloc=[[Landmark alloc] initwithdata:key];
       
        [places addObject:newloc];
    }
 [delegate QuadChanged:[NSArray arrayWithObjects:places,[threeD valueForKey:@"results"], nil]];

   
}
-(void)onCalendarRetrive:(NSMutableArray *)calendarEvents
{
    for(Landmark* obj in [places copy])
    {
        [obj addEventsFromCalendar:calendarEvents];
        
    }
    
}


@end
