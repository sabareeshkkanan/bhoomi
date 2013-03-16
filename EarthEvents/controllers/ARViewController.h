//
//  ARViewController.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 10/7/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Camera.h"
#import "LandmarkController.h"

@interface ARViewController : UIViewController
{
      
    Camera *captureManager;
    UINavigationController *navController;
  
    Landmark *h1;
    SensorData *data;
    NSString *locationId;
   
    
}

@property (retain) Camera *captureManager;
@property(nonatomic,retain)LandmarkController *_landmarkController;


-(void)freshload;
@end
