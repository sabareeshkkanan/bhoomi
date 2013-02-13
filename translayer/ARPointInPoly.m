//
//  ARPointInPoly.m
//  translayer
//  Algorithm from http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html 
//  Created by sabareesh kkanan subramani on 1/22/13.
//  Copyright (c) 2013 DreamPowers. All rights reserved.
//

#import "ARPointInPoly.h"

@implementation ARPointInPoly

  
-(double)vertx:(int)i
{
    return [[[quad objectAtIndex:i] point] coordinate].latitude;
}
-(double)verty:(int)i
{
    return [[[quad objectAtIndex:i] point] coordinate].longitude;
}
-(double)testx
{
    return [pt coordinate].latitude;
}
-(double)testy
{
    return [pt coordinate].longitude;
}


-(BOOL)pnpoly:(NSArray*)quadI :(CLLocation*)ptI
{
    quad=quadI;pt=ptI;
    int i,j,c=0,nvert=[quad count];
    for(i=0,j=nvert-1;i<nvert;j=i++){
        if ( (([self verty:i]>[self testy]) != ([self verty:j]>[self testy])) &&
            ([self testx] < ([self vertx:j]-[self vertx:i]) * ([self testy]-[self verty:i]) / ([self verty:j]-[self verty:i]) + [self vertx:i]) )
            c = !c;
    }
       
    return c;
}


@end
