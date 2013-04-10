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
        webView=[[UIWebView alloc] initWithFrame:bound];
        
        [_oracle setDelegate:self];
     
     
        [self setGl];
        [NSTimer scheduledTimerWithTimeInterval:0.04
                                         target:self
                                       selector:@selector(analyzer)
                                       userInfo:nil
                                        repeats:YES]; //simulates 1/25
        
        [wrapperView addSubview:buttonsView];
        
        
        //simulation of location and current location data
        map=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [map addTarget:self action:@selector(maps) forControlEvents:UIControlEventTouchDown];
        [map setTitle:@"Set Location" forState:UIControlStateNormal];
        map.frame = CGRectMake(40.0, 950.0, 160.0, 70.0);
        [wrapperView addSubview:map];
        
        headingBu=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [headingBu setTitle:@"Compass" forState:UIControlStateNormal];
        headingBu.frame = CGRectMake(210.0, 950.0, 160.0, 70.0);
        [wrapperView addSubview:headingBu];
        
        [self setWeber];
        // end

    }
    return self;
}

//delegate method called from the Oracle class.
-(void)QuadChanged:(NSArray *)places
{
    [[buttonsView subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
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
     [self getSensorData];
    [headingBu setTitle:[NSString stringWithFormat:@"%0.2f - %f",[data heading],[data headAccu]] forState:UIControlStateNormal];
    [map setTitle:[NSString stringWithFormat:@"Set Location %0.2f",[data gpsaccu]] forState:UIControlStateNormal];
   
    if([landmarks count]>0)
    {
       
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
-(void)maps{
  
    [wrapperView addSubview:webView];
  
}
//google maps
-(void)setWeber
{
    NSString *urlAddress = @"https://ar.seedspirit.com/ui/index2.php";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    UIButton *simulate=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [simulate addTarget:self action:@selector(simulate) forControlEvents:UIControlEventTouchDown];
    [simulate setTitle:@"Simulate" forState:UIControlStateNormal];
    simulate.frame = CGRectMake(600.0, 900.0, 160.0, 100.0);
    UIButton *original=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [original addTarget:self action:@selector(dontSimulate) forControlEvents:UIControlEventTouchDown];
    [original setTitle:@"Current Location" forState:UIControlStateNormal];
    original.frame = CGRectMake(400.0, 900.0, 160.0, 100.0);
    
    [webView addSubview:original];
    [webView addSubview:simulate];
}
-(void)simulate{
      NSString* lat = [webView stringByEvaluatingJavaScriptFromString:@"loc.lat().toString();"];
    NSString* lng=[webView stringByEvaluatingJavaScriptFromString:@"loc.lng().toString();"];
    [[_oracle sensors] simulate:[lat doubleValue] :[lng doubleValue]];
    [self removeMaps];
}
-(void)dontSimulate{
    [[_oracle sensors] dontSimulate];
    [self removeMaps];
}
-(void)removeMaps{
    [_oracle forceUpdate];
    [webView removeFromSuperview];
   
}
@end
