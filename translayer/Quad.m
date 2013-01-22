//
//  Quad.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/16/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "Quad.h"

@implementation Quad
@synthesize AltName,LocationName,LocationType,user,Tags,events,finalResult,Q_id;
@synthesize button,delegate,minimumdistance;

-(void)setvalue:(Location*)p1:(Location*)p2:(Location*)p3:(Location*)p4
{
    
    location=[[NSArray alloc] initWithObjects:p1,p2,p3,p4, nil];
    
    events=[[NSMutableArray alloc]init];
    
    LargeAngle=[[NSNumber alloc] initWithFloat:-360.0];
    buttonX=[[NSNumber alloc] initWithFloat:0];
    Selected1=0;
    Seleceted2=0;
   
}
-(id)initwithdata:(NSArray*) data{
    [self setQ_id:[[data valueForKey:@"_id"] valueForKey:@"$id"]];
   temploc=[data valueForKey:@"Location"];
  
    [self setvalue:[self retrive:0]:[self retrive:1]:[self retrive:2]:[self retrive:3]];
    AltName=[data valueForKey:@"AltName"];
    LocationName=[data valueForKey:@"LocationName"];
    LocationType=[data valueForKey:@"LocationType"];
    Tags=[data valueForKey:@"Tags"];
    user=[data valueForKey:@"user"];
    [self populateEvents:[data valueForKey:@"events"]];
    [self newButton:LocationName];
    
    
    
    
    return self;
}

-(void)populateEvents:(NSArray*)data{
    for(NSArray* obj in data)
    {
        AREvents *eve=[[AREvents alloc] initwithArray:obj];
        [events addObject:eve];
    }
}
-(void)addEventsFromCalendar:(NSArray*) CalendarEvents{
    for(EKEvent* obj in CalendarEvents)
    {
        for(NSString* tag in Tags)
        {
            if([obj valueForKey:@"location"])
            if([tag hasPrefix:[obj valueForKey:@"location"]])
            {
                [events addObject:[[AREvents alloc] initwithEKEvent:obj]];
            }
        
        }
    }
}
-(Location*)retrive:(int)x{
  return [[Location alloc] initwithdata:[[CLLocation alloc]
          initWithLatitude:[[[[temploc valueForKey:@"loc"] objectAtIndex:x]objectAtIndex:1] floatValue]
          longitude:[[[[temploc valueForKey:@"loc"] objectAtIndex:x]objectAtIndex:0] floatValue]]];
  
}
//------------------------------------------------------------------------------------------------

-(BOOL)inside:(CLLocation*)DeviceLocation{
    return [[ARPointInPoly alloc] pnpoly:location:DeviceLocation ];
    
    }

-(void)calculateAngle:(CLLocation*)currentLocation{
   for(Location* pt in location)
        [pt calculateAngle:currentLocation];
}
-(void)ComputeByHeading:(double)heading{
    if(!InsideQuad)
    {
    [self calculateDifference:heading];
    [self analyzeResult];
    [self ButtonLocation];
finalResult=[NSArray arrayWithObjects:state,buttonX,minimumdistance, nil];
    }
    
}
-(void)analyzeResult{
     a1=[[location objectAtIndex:Selected1] Difference_];
     a2=[[location objectAtIndex:Seleceted2] Difference_];
   angleAnalyzer *analyzer=[[angleAnalyzer alloc] Analyze:[LargeAngle floatValue] :a1 :a2];
    state=[NSNumber numberWithInt:[analyzer State]];
    [self calculateMinimumDistance];
   }
-(void)calculateMinimumDistance{
    minimumdistance=[NSNumber numberWithFloat:10000.0];
    for(int i=0;i<4;i++)
        if([[location objectAtIndex:i] Distance_]<[minimumdistance floatValue])
            minimumdistance=[NSNumber numberWithFloat:[[location objectAtIndex:i] Distance_]];
   
}
-(void)calculateDifference:(double)heading{
    for(Location* pt in location)
        [pt calculateDifference:heading];
}
-(void)ComputeByGps:(CLLocation*)currentLocation{
    LargeAngle=[NSNumber numberWithFloat:-360.0];
    [self calculateAngle:currentLocation];

    if(![self inside:currentLocation]){
   
    [self angleA:currentLocation :[[location objectAtIndex:0] point] : [[location objectAtIndex:1] point]:0 :1];
    [self angleA:currentLocation :[[location objectAtIndex:0] point] : [[location objectAtIndex:2] point]:0 :2];
    [self angleA:currentLocation :[[location objectAtIndex:0] point] : [[location objectAtIndex:3] point]:0 :3];
    [self angleA:currentLocation :[[location objectAtIndex:1] point] : [[location objectAtIndex:2] point]:1 :2];
    [self angleA:currentLocation :[[location objectAtIndex:1] point] : [[location objectAtIndex:3] point]:1 :3];
    [self angleA:currentLocation :[[location objectAtIndex:2] point] : [[location objectAtIndex:3] point]:2 :3];
    }
    else
        InsideQuad=TRUE;
  
}
-(void)angleA:(CLLocation*)A:(CLLocation*)B:(CLLocation*)C:(int)bb:(int)cc
{
    double a=[B distanceFromLocation:C];
    if(a==0 && ([LargeAngle floatValue]==0.0||[LargeAngle floatValue]==-360.0))
    {
       LargeAngle=[NSNumber numberWithDouble:0.0];
        Selected1=bb;
        Seleceted2=cc;
        return;
        
    }
    double b=[A distanceFromLocation:C];
    double c=[A distanceFromLocation:B];
    double COSA=(pow(b,2)+pow(c, 2)-pow(a,2))/(2*b*c);
    double rdang=acosf(COSA);
    double ang= [self rtd:rdang];
    if(ang>[LargeAngle floatValue])
    {
        LargeAngle=[NSNumber numberWithDouble:ang];
        Selected1=bb;
        Seleceted2=cc;
    }
}
-(float) rtd:(float) radians
{
    return radians * 180 / M_PI;
}
-(void)newButton:(NSString*)title
{
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(calldelegate:) forControlEvents:UIControlEventTouchDown];
    
    [button setTitle:title forState:UIControlStateNormal];
}
-(void)ButtonLocation
{
    if([state intValue]>0)
    {
       
        float range=([LargeAngle floatValue]/2)+22.5;
        float average=(a1+a2)/2;
        float factor=760/range;
        
       buttonX=[NSNumber numberWithFloat:(average*factor)+380];
       
    }
           else
    {
        buttonX=[NSNumber numberWithFloat:-200];
    }
}
-(void)buttonPriority:(int)y
{
    if(!InsideQuad)
        button.frame=CGRectMake([buttonX floatValue], y, 160, 40);
    else
        button.frame=CGRectMake(540, 50, 160, 40);
}
-(void)calldelegate:(id)sender
{
    [delegate buttonTouch:self];
}

@end