//
//  ARViewController.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 10/7/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
// Program starts executing from here

#import <UIKit/UIKit.h>
#import "CameraViewController.h"
#import "LandmarkController.h"

@interface ARViewController : UIViewController
{
      
    CameraViewController *captureManager;
    UINavigationController *navController;
  
    Landmark *h1;
    SensorData *data;
    NSString *locationId;
   
    
}

@property (retain) CameraViewController *captureManager;
@property(nonatomic,retain)LandmarkController *_landmarkController;


-(void)freshload;
@end
