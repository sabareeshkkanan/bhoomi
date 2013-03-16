//
//  ARMedia.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARMedia : NSObject

@property(strong) NSString *_id,*alt,*name,*type,*url,*user;

-(id)initwitharray:(NSArray*)data;
@end
