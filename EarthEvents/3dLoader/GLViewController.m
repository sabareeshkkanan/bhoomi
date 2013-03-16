//
//  GLViewController.h
//  Wavefront OBJ Loader
//
//  Created by Jeff LaMarche on 12/14/08.
//  Copyright Jeff LaMarche 2008. All rights reserved.
//

#import "GLViewController.h"
#import "GLView.h"

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)
@implementation GLViewController
@synthesize objects,senseData;
-(id)init{
    if(self)
    {
        objects=[[NSMutableArray alloc] init];

    }
        return self;
}
- (void)drawView:(GLView*)view;
{
	
	
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity(); 
	glColor4f(0.0, 0.5, 1.0, 1.0);
    
    [self DrawAfterComputing];

	
}

-(void)setupView:(GLView*)view
{
	const GLfloat			lightAmbient[] = {0.2, 0.2, 0.2, 1.0};
	const GLfloat			lightDiffuse[] = {1.0, 1.0, 1.0, 1.0};
	
	const GLfloat			lightPosition[] = {5.0, 5.0, 15.0, 0.0};
	const GLfloat			light2Position[] = {-5.0, -5.0, 15.0, 0.0};
	const GLfloat			lightShininess = 0.0;
	const GLfloat			zNear = 0.01, zFar = 1000.0, fieldOfView = 30.0;
	GLfloat size; 
	glEnable(GL_DEPTH_TEST);
	glMatrixMode(GL_PROJECTION);
	glEnable(GL_BLEND);
	size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0); 
	CGRect rect = view.bounds; 
	glFrustumf(-size, size, -size / (rect.size.width / rect.size.height), size / 
			   (rect.size.width / rect.size.height), zNear, zFar); 
	glViewport(0, 0, rect.size.width, rect.size.height);  
	glMatrixMode(GL_MODELVIEW);
	glShadeModel(GL_SMOOTH); 
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, lightDiffuse);
	glLightfv(GL_LIGHT0, GL_POSITION, lightPosition); 
	glLightfv(GL_LIGHT0, GL_SHININESS, &lightShininess);
	
	glEnable(GL_LIGHT1);
	glLightfv(GL_LIGHT1, GL_AMBIENT, lightAmbient);
	glLightfv(GL_LIGHT2, GL_DIFFUSE, lightDiffuse);
	glLightfv(GL_LIGHT2, GL_POSITION, light2Position); 
	glLightfv(GL_LIGHT2, GL_SHININESS, &lightShininess);
	
	glLoadIdentity(); 
	glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
	
	glGetError(); // Clear error codes
}
-(void)loader:(NSArray*)Object
{
    NSString *_id=[[Object valueForKey:@"_id"] valueForKey:@"$id"];
   if(![self isAlreadyExist:_id])
    {
        OpenGLWaveFrontObject *theObject = [[OpenGLWaveFrontObject alloc] initWithObject:Object];
        Vertex3D position = Vertex3DMake(0, 0, -25.0);
        theObject.currentPosition = position;
        theObject.display=TRUE;
        [objects addObject:theObject];
        NSLog(@"End Load of Plane");
    }
}
-(BOOL)isAlreadyExist:(NSString*)_id
{
    for(OpenGLWaveFrontObject* object in objects)
        if([object exist:_id])
            return TRUE;
    return FALSE;
}
- (void)didReceiveMemoryWarning 
{
	
    [super didReceiveMemoryWarning]; 
}

-(void)DrawAfterComputing
{
   // NSLog(@"%f,%f",[self rtd:[senseData yaw]],[self rtd:[senseData roll]]);
    for (OpenGLWaveFrontObject *theObject in objects) {
        [self CalculateRotation:theObject];
        [self CalculateTranslation:theObject];
        if(theObject.display)
        [theObject drawSelf];
    }

}
-(void)CalculateRotation:(OpenGLWaveFrontObject*) object{
    [object.GPSposition calculateAngle:[senseData gps]];
    Rotation3D rotation;
    rotation.x=10;
    rotation.y=[object.GPSposition angle];
    object.currentRotation=rotation;
 
}
-(void)CalculateTranslation:(OpenGLWaveFrontObject*) object{
    float scale;
    float horizontal;
    float hDifference;
    float vertical;

    
    if([object.GPSposition Distance_]>50)
        object.display=FALSE;
    else
        object.display=TRUE;
    
    scale =-[object.GPSposition Distance_]/2;
    if(scale>-5)
        scale=-5;
  //  scale=-25;
    //fusion
    float convert=[self rtd:([senseData.attitude roll]*-1)];
    if(convert<0)
        convert=360+convert;
    
    //
    
    [object.GPSposition calculateDifference:convert];
    hDifference=[object.GPSposition Difference_];
    
    
    horizontal=scale/3.7584;
    horizontal=horizontal*(hDifference/22.5)*-1;
    
    vertical=scale/2.77777;
    float z=[self rtd:[senseData.RealAttitude pitch]];
    z=z*1.12;
    z=(z-100)/100;
    z=z*2.77;
    if(senseData.Acceleration.acceleration.z>0)
        z=z*-1;
    
    vertical=vertical*z;
           Vertex3D position=Vertex3DMake(horizontal,vertical, scale);
    object.currentPosition=position;
        
    
   
}
-(float) rtd:(float) radians
{
    return radians * 180 / M_PI;
}

@end
/*
 static GLfloat rotation = 0.0;
 static NSTimeInterval lastDrawTime;
 if (lastDrawTime)
 {
 NSTimeInterval timeSinceLastDraw = [NSDate timeIntervalSinceReferenceDate] - lastDrawTime;
 if(rotation>180)
 temp=true;
 if(rotation<-180)
 temp=FALSE;
 if(!temp)
 rotation+=50 * timeSinceLastDraw;
 else
 rotation-=50 * timeSinceLastDraw;
 
 Rotation3D rot;
 
 rot.y = rotation;
 //rot.z = 50.0;
 object.currentRotation = rot;
 
 }
 lastDrawTime = [NSDate timeIntervalSinceReferenceDate];

 */