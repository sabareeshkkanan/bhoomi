//
//  ARQuadAnalyze.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/24/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "GetLocation.h"
#import "TableViewController.h"
#import "GLViewController.h"
#import "GLView.h"

@class ARQuadAnalyze;

@interface ARQuadAnalyze : NSObject<CloudUpdate,buttonEvent>
{
    GetLocation *locations;
    

    
    NSArray *quads;
    NSArray *threeD;
    

    NSArray *result;
    GLViewController *controller;
  
    GLView *glView ;
    UIView *wrapperView;
    UIView *buttonsView;
    
    
    CGRect bound;
    
  
}
@property UIView *wrapperView;
@property(nonatomic,retain)GetLocation *locations;
@property(nonatomic,retain)SensorData *data;

@property(nonatomic,retain) UINavigationController *navController;
@property(nonatomic,retain) TableViewController *tableController;

@property (nonatomic, retain) GLViewController *controller;
@property (nonatomic, retain) GLView *glView ;

-(id)init:(CGRect)dimension;
@end
