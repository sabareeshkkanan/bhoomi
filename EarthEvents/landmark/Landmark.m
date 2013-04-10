//
//  Quad.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/16/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "Landmark.h"

@implementation Landmark
@synthesize AltName,LocationName,LocationType,user,events,finalResult,Q_id;
@synthesize button,delegate,minimumdistance,state;
const float boxWidth=160.0;
const float boxHeight=80.0;



-(void)setvalue:(NSArray*)points
{
    NSMutableArray *tempLocations=[[NSMutableArray alloc] init];
    for(int i=0;i<[points count];i++)
        [tempLocations addObject:[self retrive:i :points]];
    
    Locations=[[NSArray alloc] initWithArray:tempLocations];
    
    events=[[NSMutableArray alloc]init];
    
    LargestAngle=[[NSNumber alloc] initWithFloat:0.0];
    buttonX=[[NSNumber alloc] initWithFloat:0];
    Selected1=0;
    Seleceted2=0;
   
}
-(id)initwithdata:(NSArray*) data{
    
    
    
    [self setQ_id:[[data valueForKey:@"_id"] valueForKey:@"$id"]];
    [self setvalue:[data valueForKey:@"Location"]];
    
    AltName=[data valueForKey:@"AltName"];
    LocationName=[data valueForKey:@"LocationName"];
    LocationType=[data valueForKey:@"LocationType"];
    
    user=[data valueForKey:@"user"];
    [self populateEvents:[data valueForKey:@"events"]];
    [self newButton:LocationName];
    
    
    
    
    return self;
}
-(void)sortEventsbyDate
{
    NSSortDescriptor *sort=[[NSSortDescriptor alloc] initWithKey:@"sortDate" ascending:YES];
    [events sortUsingDescriptors:[NSArray arrayWithObject:sort]];
}

-(void)populateEvents:(NSArray*)data{
    for(NSArray* obj in data)
    {
        AREvent *eve=[[AREvent alloc] initwithArray:obj];
        [events addObject:eve];
    }
}
-(void)addEventsFromCalendar:(NSArray*) CalendarEvents{
    for(EKEvent* obj in CalendarEvents)
    {
        for(NSString* tag in AltName)
        {
            if([obj valueForKey:@"location"])
                if([[obj valueForKey:@"location"] rangeOfString:tag].location!=NSNotFound)
                {   [events addObject:[[AREvent alloc] initwithEKEvent:obj]]; break;}
        /*    if([tag hasPrefix:[obj valueForKey:@"location"]])
            {
                [events addObject:[[AREvent alloc] initwithEKEvent:obj]];
            }*/
        
        }
    }
}
-(Location*)retrive:(int)x :(NSArray*)points{
  return [[Location alloc] initwithdata:[[CLLocation alloc]
          initWithLatitude:[[[[points valueForKey:@"loc"] objectAtIndex:x]objectAtIndex:1] floatValue]
          longitude:[[[[points valueForKey:@"loc"] objectAtIndex:x]objectAtIndex:0] floatValue]]];
  
}
//------------------------------------------------------------------------------------------------

-(void)analyzeWithSensorData:(CLLocation *)currentLocation :(double)compassHeading
{
    [self ComputeWithGps:currentLocation];
    [self ComputeWithHeading:compassHeading];
}

-(BOOL)inside:(CLLocation*)DeviceLocation{
    return [[ARPointInPolygon alloc] pnpoly:Locations:DeviceLocation ];
    
    }

-(void)calculateAngle:(CLLocation*)currentLocation{
   for(Location* pt in Locations)
        [pt calculateAngle:currentLocation];
}
-(void)ComputeWithHeading:(double)heading{
    if(!InsideQuad)
    {
    [self calculateDifference:heading];
    [self analyzeResult];
    [self ButtonLocation];
    
            }
    
}
-(void)analyzeResult{

     a1=[[Locations objectAtIndex:Selected1] Difference_];
     a2=[[Locations objectAtIndex:Seleceted2] Difference_];
   landmarkState *analyzer=[[landmarkState alloc] Analyze:[LargestAngle floatValue] :a1 :a2];
    state=[NSNumber numberWithInt:[analyzer State]];
    [self calculateMinimumDistance];
   }

-(void)calculateMinimumDistance{
    minimumdistance=[NSNumber numberWithFloat:10000.0];
    for(int i=0;i<[Locations count];i++)
        if([[Locations objectAtIndex:i] Distance_]<[minimumdistance floatValue])
            minimumdistance=[NSNumber numberWithFloat:[[Locations objectAtIndex:i] Distance_]];
   
}

-(void)calculateDifference:(double)heading{
    for(Location* pt in Locations)
        [pt calculateDifference:heading];
}
-(void)ComputeWithGps:(CLLocation*)currentLocation{
  
    
    InsideQuad=[self inside:currentLocation];
    if(!InsideQuad ){
        [self calculateAngle:currentLocation];
        if( [Locations count]==4)
        {
    [self calculateAngleBAC:currentLocation :[[Locations objectAtIndex:0] point] : [[Locations objectAtIndex:1] point]:0 :1];
    [self calculateAngleBAC:currentLocation :[[Locations objectAtIndex:0] point] : [[Locations objectAtIndex:2] point]:0 :2];
    [self calculateAngleBAC:currentLocation :[[Locations objectAtIndex:0] point] : [[Locations objectAtIndex:3] point]:0 :3];
    [self calculateAngleBAC:currentLocation :[[Locations objectAtIndex:1] point] : [[Locations objectAtIndex:2] point]:1 :2];
    [self calculateAngleBAC:currentLocation :[[Locations objectAtIndex:1] point] : [[Locations objectAtIndex:3] point]:1 :3];
    [self calculateAngleBAC:currentLocation :[[Locations objectAtIndex:2] point] : [[Locations objectAtIndex:3] point]:2 :3];
        }
    }

  
}
-(void)calculateAngleBAC:(CLLocation*)A :(CLLocation*)B :(CLLocation*)C :(int)bb :(int)cc
{
    double a=[B distanceFromLocation:C];
    double b=[A distanceFromLocation:C];
    double c=[A distanceFromLocation:B];
    double COSA=(pow(b,2)+pow(c, 2)-pow(a,2))/(2*b*c);
    double rdang=acosf(COSA);
    double ang= [self rtd:rdang];
    if(ang>[LargestAngle floatValue])
    {
        LargestAngle=[NSNumber numberWithDouble:ang];
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
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(calldelegate:) forControlEvents:UIControlEventTouchDown];
    [self buttonlayer: [[UIColor darkGrayColor] CGColor]];
    [button.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [button setTitle:title forState:UIControlStateNormal];
}
-(void)ButtonLocation
{
    if([state intValue]>0)
    {
        button.hidden=NO;
        float range=[LargestAngle floatValue]+45; // 45 is the viewing angle of camera 
        float average=(a1+a2)/2;
        average+=range/2;
        float factor=([UIScreen mainScreen].bounds.size.width+boxWidth)/range;
        float X=average*factor;
        X-=boxWidth;
       buttonX=[NSNumber numberWithFloat:(X)];
       /* if([LocationName isEqualToString:@"Science Hall 2"])
        {
            NSLog(@",%f,%f,%f,%f,%f,%f,%f,%f,%f",a1,a2,[LargestAngle floatValue],range,average-range/2,average,factor,X+boxWidth,X);
        }*/
       
    }
           else
    {
        button.hidden=YES;
    }
}
-(void)buttonPriority:(int)y
{
    NSString *distance_=[NSString stringWithFormat:@"%.2f",[minimumdistance floatValue]];
    distance_=[distance_ stringByAppendingString:@" meters to"];
    if(!InsideQuad){
        button.frame=CGRectMake([buttonX floatValue], y, boxWidth, boxHeight);
        if(button.layer.borderColor==[[UIColor orangeColor] CGColor])
          [self buttonlayer: [[UIColor darkGrayColor] CGColor]];
    }
    else
    {
        button.hidden=NO;
        button.frame=CGRectMake(540, 50, boxWidth, boxHeight);
        distance_=@"You are inside ";
        [self buttonlayer:[[UIColor orangeColor]CGColor]];
    }
    NSString *content=[NSString stringWithFormat:@"%@\n%@",distance_,LocationName];
    [button setTitle:content forState:UIControlStateNormal];

}
-(void)calldelegate:(id)sender
{
    [self buttonlayer:[[UIColor greenColor] CGColor]];
    [delegate buttonTouch:self];
}
-(void)buttonlayer:(CGColorRef)buttoncolor
{
    CALayer *layer = button.layer;
    layer.backgroundColor = [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3] CGColor];
    layer.borderColor = buttoncolor;
    layer.cornerRadius = 8.0f;
    layer.borderWidth = 1.0f;
}
@end