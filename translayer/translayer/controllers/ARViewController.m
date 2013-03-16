//
//  ARViewController.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 10/7/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "ARViewController.h"
@interface ARViewController ()

@end

@implementation ARViewController
//@synthesize captureManager;
@synthesize captureManager,_landmarkController;

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self setcamera];
    [self freshload];
    

    
}
-(void)freshload{
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    CGRect layerRect = [[[self view] layer] bounds];
    _landmarkController=[[LandmarkController alloc] init:layerRect];
    locationId=@"start";
   
    
    [self.view addSubview:[_landmarkController wrapperView]];

}

-(void)setcamera
{
    [self setCaptureManager:[[Camera alloc] init]];
    [[self captureManager] preview];
    CGRect layerRect = [[[self view] layer] bounds];
    [[[self captureManager] previewLayer] setBounds:layerRect];
    [[[self captureManager] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                  CGRectGetMidY(layerRect))];
    [[[self view] layer] addSublayer:[[self captureManager] previewLayer]];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
