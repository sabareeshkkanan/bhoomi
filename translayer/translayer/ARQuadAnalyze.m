//
//  ARQuadAnalyze.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/24/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "ARQuadAnalyze.h"

@implementation ARQuadAnalyze
@synthesize locations,data,delegate;
@synthesize wrapperView,glView,controller;
-(id)init:(CGRect)dimension
{
    if(self)
    {
        bound=dimension;
        
        mapButtons=[[NSMutableArray alloc] init];
        
        wrapperView=[[UIView alloc] initWithFrame:bound];
        buttonsView=[[UIView alloc] initWithFrame:bound];
        
        locations=[[GetLocation alloc] init];
        [locations setDelegate:self];
        data=[[SensorData alloc] init];
        dualAngle=[[NSMutableArray alloc] init];
         monoAngle=[[NSMutableArray alloc] init];
        [self setGl];
        count=0;
        [NSTimer scheduledTimerWithTimeInterval:0.04
                                         target:self
                                       selector:@selector(analyzer)
                                       userInfo:nil
                                        repeats:YES];
        [wrapperView addSubview:buttonsView];
        [buttonsView addSubview:[self newButton:@"test" :@"bad"]];
        

    }
    return self;
}

-(void)QuadChanged:(NSArray *)places
{
    quads=[places objectAtIndex:0];
    threeD=[[places objectAtIndex:1] valueForKey:@"obj"];
    for(NSArray* obj in threeD)
        [self performSelectorInBackground:@selector(new3d:) withObject:obj];
   
  
}
-(void)analyzer
{
   
    if([quads count]>0)
    {
        [self getSensorData];
        [self.controller setSenseData:data];
        [glView drawView];
        
      if(count>10)
      {
    [self analyzeQuad];
    [self bestAngle];
    [self closest];
          count=0;
      }
        count++;
    }

}
-(void)bestAngle
{
    [dualAngle removeAllObjects];
    [monoAngle removeAllObjects];
    for(Quad* quad in quads)
    {
        NSArray *final=[quad finalResult] ;
        if([[final objectAtIndex:1] intValue]>2)
        [dualAngle addObject:quad];
        else if ([[final objectAtIndex:1] intValue]>0)
            [monoAngle addObject:quad];
        
    }

}
-(void)closest
{
    float dist=10000;
    Quad* quadT;
    if([dualAngle count]>0)
    {
        for(Quad* quad in dualAngle)
        {
            if([[[quad finalResult] objectAtIndex:4] floatValue]<dist)
            {
                quadT=quad; dist=[[[quad finalResult] objectAtIndex:4] floatValue];
            }
        }
        for(Quad* quad in monoAngle)
        {
            if([[[quad finalResult] objectAtIndex:4] floatValue]<dist && [[[quad finalResult] objectAtIndex:2] floatValue]<10 && [[[quad finalResult] objectAtIndex:2] floatValue]>-10)
            {
                quadT=quad; dist=[[[quad finalResult] objectAtIndex:4] floatValue];
            }
        }
    }
    else if ([monoAngle count]>0)
    {
        for(Quad* quad in monoAngle)
        {
            if([[[quad finalResult] objectAtIndex:4] floatValue]<dist)
            {
                quadT=quad; dist=[[[quad finalResult] objectAtIndex:4] floatValue];
            }
        }

        
    }
    result=[[NSArray alloc] initWithObjects:quadT,[NSNumber numberWithFloat:dist] ,data,nil];
    [delegate results:result];
}
-(void)analyzeQuad{
    for(Quad* quad in quads)
    {
       // [quad MaximumAngle:[data gps]];
        [quad MaximumAngle:[[CLLocation alloc] initWithLatitude:33.13043115895641 longitude:-117.15774983167648]];
        [quad displayAngle:[data heading]];
    }
    
}
-(void)getSensorData
{
    data=[[locations sensors] update];
    
    
}
-(void)setGl{
	glView = [[GLView alloc] initWithFrame:bound];
	[wrapperView addSubview:glView];
    
    GLViewController *theController = [[GLViewController alloc] init];
    //[theController loader];
	[self setController:theController];
    glView.controller = self.controller;
   
	
}
-(void)new3d:(NSArray*)Obj{
    [[self controller] loader:Obj];
}

-(UIButton*)newButton:(NSString*)title:(NSString*)_id
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchDown];

    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    button.tag=[mapButtons count];
    [mapButtons addObject:_id];
    return button;
    
}
-(void)aMethod:(UIButton*)sender
{
        NSLog(@"%@",mapButtons[sender.tag]);
}


@end
