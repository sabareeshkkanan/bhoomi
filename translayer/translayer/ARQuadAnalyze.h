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
@protocol resultchange <NSObject>
-(void)results:(NSArray*)result;
@end

@interface ARQuadAnalyze : NSObject<CloudUpdate>
{
    GetLocation *locations;
    
    NSMutableArray *mapButtons;
    
    NSArray *quads;
    NSArray *threeD;
    
    NSMutableArray *dualAngle;
     NSMutableArray *monoAngle;
    NSArray *result;
    __weak id<resultchange> delegate;
    GLViewController *controller;
  
    GLView *glView ;
    UIView *wrapperView;
    UIView *buttonsView;
    
    
    CGRect bound;
    
    int count;
}
@property(nonatomic,weak)id<resultchange> delegate;
@property UIView *wrapperView;
@property(nonatomic,retain)GetLocation *locations;
@property(nonatomic,retain)SensorData *data;


@property (nonatomic, retain) GLViewController *controller;
@property (nonatomic, retain) GLView *glView ;

-(id)init:(CGRect)dimension;
@end
