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
@synthesize captureManager,navController,tableController,analyze;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blueColor]];
    
   tableController=[[TableViewController alloc] init];
    navController=[[UINavigationController alloc] initWithRootViewController:tableController];
    CGRect layerRect = [[[self view] layer] bounds];
    analyze=[[ARQuadAnalyze alloc] init:layerRect];
    [analyze setDelegate:self];
    locationId=@"start";
   [self setcamera];
          // buttons=[[UIView alloc] initWithFrame:layerRect];

    [self.view addSubview:[analyze wrapperView]];

    
    [self.view addSubview:[navController view]];
   
    
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


-(void)results:(NSArray *)result{
    if([result count]==3)
    if([[result objectAtIndex:1] floatValue]<10000)
        if(![locationId isEqualToString:[[result objectAtIndex:0] Q_id]])
        {
             [tableController loadnewQuad:result];
            locationId=[[result objectAtIndex:0] Q_id];
        }
    
   
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
   // [[analyze glView] startAnimation];
    
}

@end
