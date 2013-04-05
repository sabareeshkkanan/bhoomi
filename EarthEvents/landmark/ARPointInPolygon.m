//
//  ARPointInPoly.m
//  translayer
//  Algorithm from http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html 
//  Created by sabareesh kkanan subramani on 1/22/13.
//  Copyright (c) 2013 DreamPowers. All rights reserved.
//

#import "ARPointInPolygon.h"

@implementation ARPointInPolygon

  
-(double)vx:(int)i  //returns latitude of the coordinate i in the array
{
    return [[[landmark objectAtIndex:i] point] coordinate].latitude;
}
-(double)vy:(int)i   //returns longitude of the coordinate i in the array
{
    return [[[landmark objectAtIndex:i] point] coordinate].longitude;
}

-(BOOL)pnpoly:(NSArray*)landmarkI :(CLLocation*)userLocation
{
    landmark=landmarkI;
    double x=[userLocation coordinate].latitude;  
    double y=[userLocation coordinate].longitude;
    int i,j,c=0;
    int nvert=[landmark count]; // nvert number of vertices in the polygon
    for(i=0,j=nvert-1;i<nvert;j=i++){
        if ( (([self vy:i]>y) != ([self vy:j]>y)) &&
            (x < ([self vx:j]-[self vx:i]) * (y-[self vy:i]) / ([self vy:j]-[self vy:i]) + [self vx:i]) )
            c = !c;
    }
    return c;
}


@end
