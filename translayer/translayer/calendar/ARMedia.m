//
//  ARMedia.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "ARMedia.h"

@implementation ARMedia
@synthesize _id,alt,name,type,url,user;
-(id)initwitharray:(NSArray*)data;
{
    alt=[data valueForKey:@"alt"];
    name=[data valueForKey:@"name"];
    type=[data valueForKey:@"type"];
    url=[data valueForKey:@"url"];
    user=[data valueForKey:@"user"];
   
   
    return self;
}


@end
