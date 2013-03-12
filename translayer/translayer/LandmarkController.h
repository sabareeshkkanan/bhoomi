//
//  ARQuadAnalyze.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/24/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "Oracle.h"
#import "TableViewController.h"
#import "GLViewController.h"
#import "GLView.h"

@class LandmarkController;

@interface LandmarkController : NSObject<CloudUpdate,buttonEvent>
{
    Oracle *_oracle;
    

    
    NSArray *landmarks;
    NSArray *threeD;
    

  
    GLViewController *controller;
  
    GLView *glView ;
    UIView *wrapperView;
    UIView *buttonsView;
    
    
    CGRect bound;
    Landmark *lastSelectedLandmark;
  
}
@property UIView *wrapperView;
@property(nonatomic,retain)Oracle *_oracle;
@property(nonatomic,retain)SensorData *data;

@property(nonatomic,retain) UINavigationController *navigationController;
@property(nonatomic,retain) TableViewController *tableViewController;

@property (nonatomic, retain) GLViewController *controller;
@property (nonatomic, retain) GLView *glView ;

-(id)init:(CGRect)dimension;
@end
