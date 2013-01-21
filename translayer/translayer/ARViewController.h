//
//  ARViewController.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 10/7/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Camera.h"

#import "TableViewController.h"

#import "ARQuadAnalyze.h"

@interface ARViewController : UIViewController<resultchange>
{
      
    Camera *captureManager;
    UINavigationController *navController;
  
    Quad *h1;
    SensorData *data;
    NSString *locationId;
   
    
}
@property(nonatomic,retain) UINavigationController *navController;
@property(nonatomic,retain) TableViewController *tableController;
@property (retain) Camera *captureManager;
@property(nonatomic,retain)ARQuadAnalyze *analyze;



@end
