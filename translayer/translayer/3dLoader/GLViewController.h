//
//  GLViewController.h
//  Wavefront OBJ Loader
//
//  Created by Jeff LaMarche on 12/14/08.
//  Copyright Jeff LaMarche 2008. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "OpenGLWaveFrontObject.h"
#import "SensorData.h"

@class GLView;

@interface GLViewController : UIViewController {
    NSMutableArray *objects;
    BOOL temp;
    SensorData *senseData;
}

- (void)drawView:(GLView*)view;
- (void)setupView:(GLView*)view;
-(void)loader:(NSArray*)Object;
@property(nonatomic,retain)SensorData *senseData;
@property(nonatomic,retain)NSMutableArray *objects;
@end
