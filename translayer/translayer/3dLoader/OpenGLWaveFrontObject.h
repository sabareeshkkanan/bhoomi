//
//  OpenGLWaveFrontObject.h
//  Wavefront OBJ Loader
//
//  Created by Jeff LaMarche on 12/14/08.
//  Copyright 2008 Jeff LaMarche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "OpengLWaveFrontCommon.h"
#import "OpenGLWaveFrontMaterial.h"
#import "ConstantsAndMacros.h"
#import "OpenGLWaveFrontGroup.h"
#import "OpenGLWaveFrontMaterial.h"
#import "OpenGLTexture3D.h"
#import "Location.h"

// This line should be uncommented to use the famous Quake / invsqrt optimization
// If this line is commented out, normalization will happen using standard sqrtf()
#define USE_FAST_NORMALIZE 

@interface OpenGLWaveFrontObject : NSObject {
	NSURL			*sourceObjFilePath;
	NSURL			*sourceMtlFilePath;
    NSString *_id;
    NSString *name;
	
	GLuint				numberOfVertices;
	Vertex3D			*vertices;	
	GLuint				numberOfFaces;			// Total faces in all groups
	
	Vector3D			*surfaceNormals;		// length = numberOfFaces
	Vector3D			*vertexNormals;			// length = numberOfFaces (*3 vertices per triangle);
	
	GLfloat				*textureCoords;
	GLubyte				valuesPerCoord;			// 1, 2, or 3, representing U, UV, or UVW mapping, could be 4 but OBJ doesn't support 4
	
	NSDictionary		*materials;
	NSMutableArray		*groups;
	 
	Vertex3D			currentPosition;
	Rotation3D			currentRotation;
    
    
    
    Location *GPSposition;
    
}
@property (nonatomic,readonly) NSString *_id;
@property (nonatomic, retain) NSURL *sourceObjFilePath;
@property (nonatomic, retain) NSURL *sourceMtlFilePath;
@property (nonatomic, retain)Location *GPSposition;
@property (nonatomic,readonly) NSString *name;

@property (nonatomic, retain) NSDictionary *materials;
@property (nonatomic, retain) NSMutableArray *groups;
@property Vertex3D currentPosition;
@property Rotation3D currentRotation;
@property BOOL display;
- (id)initWithObject:(NSArray *)object;
- (void)drawSelf;
-(BOOL)exist:(NSString*)CompareId;
@end
