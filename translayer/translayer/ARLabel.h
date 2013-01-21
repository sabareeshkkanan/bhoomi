//
//  ARLabel.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/10/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ARLabel : NSObject{
   UILabel *label;
}
-(UIImage *)returnImage ;
-(void)CreateImage:(NSString*)text;
-(id)init:(NSString*)text;
@property UILabel *label;
@end
