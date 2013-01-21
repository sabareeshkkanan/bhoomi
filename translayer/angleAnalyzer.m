//
//  angleAnalyzer.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/23/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "angleAnalyzer.h"

@implementation angleAnalyzer
-(id)Analyze:(float)Range :(float)Angle1 :(float)Angle2{
    range=Range;angle1=Angle1;angle2=Angle2;state=0;
    [self analyzer];
    return self;
}
-(int)State
{
    return state;
}
-(float)Angle
{
    return angle1;
}
-(void)analyzer
{
    if(range!=0)
    {
        [self bothnegative];
        
    }

        
}
-(void)bothnegative
{
    if(angle2<=0 && angle1<=0)
    {
        if(angle1>=-22.5 || angle2>=-22.5){
            state=1;
            if(angle1<angle2)
                angle1=angle2;
            
        }
        return;
    }
[self bothpositive];
}
-(void)bothpositive
{
    if(angle2>0 && angle1>0)
    {
        if(angle1<=22.5 || angle2<=22.5){
            state=2;
            if(angle2<angle1)
                angle1=angle2;
           
        }
         return;
    }
    [self different];
}
-(void)different{
    if(angle2<0)
    {
        if(angle2<0 && angle1>0 && (angle1+(-1*angle2))<=range+0.1)
        {
            state=3;
            if((angle2*-1)<angle1)
                angle1=angle2;
           
        }
            
    }
    else
    {
        if(angle1<0 && angle2>0 && (angle2+(-1*angle1))<=range+0.1)
        {
            state=4;
            if(angle2<(-1*angle1))
                angle1=angle2;
           
        }
        
    }
   
}

@end
