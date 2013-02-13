//
//  angleAnalyzer.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/23/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface angleAnalyzer : NSObject
{
    float range,angle1,angle2;int state;
}
-(id)Analyze:(float)Range :(float)Angle1 :(float)Angle2;
-(int)State;
-(float)Angle;
@end
