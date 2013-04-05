//
//  ARQuadAnalyze.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/24/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "LandmarkController.h"

@implementation LandmarkController
@synthesize _oracle,data;
@synthesize wrapperView,glView,controller;
@synthesize tableViewController,navigationController;
-(id)init:(CGRect)dimension
{
    if(self)
    {
        bound=dimension;
        tableViewController=[[EventsViewController alloc] init];
        navigationController=[[UINavigationController alloc] initWithRootViewController:tableViewController];
        
        data=[[SensorData alloc] init];
        _oracle=[[Oracle alloc] init];
        
        wrapperView=[[UIView alloc] initWithFrame:bound];
        buttonsView=[[UIView alloc] initWithFrame:bound];
        
        [_oracle setDelegate:self];
     
     
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
    landmarks=[places objectAtIndex:0];
    for(Landmark* quad in landmarks)
    {    [quad setDelegate:self];
        [buttonsView addSubview:[quad button]];
    }
    if([places count]==2)
    threeD=[[places objectAtIndex:1] valueForKey:@"obj"];
    for(NSArray* obj in threeD)
        [self performSelectorInBackground:@selector(new3d:) withObject:obj];
}
-(void)analyzer
{
   
    if([landmarks count]>0)
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
    landmarks = [landmarks sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    int hcount=70;
  for(Landmark* _landmark in landmarks)
  {
   if([_landmark.state intValue]>0)
   {
       [_landmark buttonPriority:hcount];
      hcount+=120;
   }
      else
          [_landmark buttonPriority:1000];
  }
}
-(void)analyzeQuad{
    for(Landmark* _landmark in landmarks)
    {
        [_landmark analyzeWithSensorData:[data gps] :[data heading]];
    }
    
}
-(void)getSensorData
{
    data=[[_oracle sensors] update];
    
    
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

-(void)buttonTouch:(id)_landmark
{
   
    [tableViewController loadnewQuad:_landmark];
    [wrapperView addSubview:navigationController.view];
   
       
}
@end
