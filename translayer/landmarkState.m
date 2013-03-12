//
//  angleAnalyzer.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/23/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "landmarkState.h"

@implementation landmarkState

@synthesize State;
-(id)Analyze:(float)Range :(float)Angle1 :(float)Angle2{
    range=Range;angle1=Angle1;angle2=Angle2;State=0;
    [self analyzer];
    return self;
}


-(void)analyzer
{
        [self bothnegative];
}
-(void)bothnegative
{
    if(angle2<=0 && angle1<=0)
    {
        if(angle1>=-22.5 || angle2>=-22.5)
            State=1;
        return;
    }
[self bothpositive];
}
-(void)bothpositive
{
    if(angle2>0 && angle1>0)
    {
        if(angle1<=22.5 || angle2<=22.5)
            State=2;
         return;
    }
    [self different];
}
-(void)different{
    if(angle2<0)
    {
        if( angle1>0 && (angle1+(-1*angle2))<=range+0.1)
            State=3;
            
    }
    else
    {
        if(angle1<0 && (angle2+(-1*angle1))<=range+0.1)
            State=4;
        
    }
   
}

@end
