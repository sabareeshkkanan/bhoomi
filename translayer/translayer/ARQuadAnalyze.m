//
//  ARQuadAnalyze.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/24/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "ARQuadAnalyze.h"

@implementation ARQuadAnalyze
@synthesize locations,data;
@synthesize wrapperView,glView,controller;
@synthesize tableController,navController;
-(id)init:(CGRect)dimension
{
    if(self)
    {
        bound=dimension;
        tableController=[[TableViewController alloc] init];
        navController=[[UINavigationController alloc] initWithRootViewController:tableController];
        
        data=[[SensorData alloc] init];
        locations=[[GetLocation alloc] init];
        
        wrapperView=[[UIView alloc] initWithFrame:bound];
        buttonsView=[[UIView alloc] initWithFrame:bound];
        
        [locations setDelegate:self];
     
     
        [self setGl];
        [NSTimer scheduledTimerWithTimeInterval:0.04
                                         target:self
                                       selector:@selector(analyzer)
                                       userInfo:nil
                                        repeats:YES];
        [wrapperView addSubview:buttonsView];
        

    }
    return self;
}

-(void)QuadChanged:(NSArray *)places
{
    quads=[places objectAtIndex:0];
    for(Quad* quad in quads)
    {    [quad setDelegate:self];
        [buttonsView addSubview:[quad button]];
    }
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
        
 
    [self analyzeQuad];
    
    [self closest];
   
    }

}

-(void)closest
{
     NSSortDescriptor * sort = [[NSSortDescriptor alloc] initWithKey:@"minimumdistance" ascending:TRUE] ;
    quads = [quads sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    int hcount=70;
  for(Quad* quad in quads)
  {
   if([quad.state intValue]>0)
   {
       [quad buttonPriority:hcount];
      hcount+=120;
   }
      else
          [quad buttonPriority:1000];
  }
}
-(void)analyzeQuad{
    for(Quad* quad in quads)
    {
        [quad ComputeByGps:[data gps]];
     //   [quad ComputeByGps:[[CLLocation alloc] initWithLatitude:33.13070069755159 longitude:-117.15790137648582]];
        [quad ComputeByHeading:[data heading]];
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

-(void)buttonTouch:(id)quad
{
   
    [tableController loadnewQuad:quad];
    [wrapperView addSubview:navController.view];
    
}
@end
