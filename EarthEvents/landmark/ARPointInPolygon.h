//
//  ARPointInPoly.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 1/22/13.
//  Copyright (c) 2013 DreamPowers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface ARPointInPolygon : NSObject
{
    NSArray *landmark;
  
}
-(BOOL)pnpoly : (NSArray*)quadI : (CLLocation*)ptI ;
@end
