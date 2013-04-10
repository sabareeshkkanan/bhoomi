//
//  ARQuadAnalyze.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/24/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//// Before working on this class understand delegate in ios


#import "Oracle.h"
#import "EventsViewController.h"
#import "GLViewController.h"
#import "GLView.h"

@class LandmarkController;

@interface LandmarkController : NSObject<CloudUpdate,buttonEvent>
{
    Oracle *_oracle;
    GLViewController *controller;
    GLView *glView ;
    
    NSArray *landmarks;
    NSArray *threeD;
    CGRect bound;
   
    UIView *wrapperView;
    UIView *buttonsView;
    UIWebView *webView;
    UIButton *map;
    UIButton *headingBu;
   
}
@property UIView *wrapperView;
@property(nonatomic,retain)Oracle *_oracle;
@property(nonatomic,retain)SensorData *data;

@property(nonatomic,retain) UINavigationController *navigationController;
@property(nonatomic,retain) EventsViewController *tableViewController;

@property (nonatomic, retain) GLViewController *controller;
@property (nonatomic, retain) GLView *glView ;

-(id)init:(CGRect)dimension;
@end
