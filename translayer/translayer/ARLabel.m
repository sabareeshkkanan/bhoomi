//
//  ARLabel.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/10/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "ARLabel.h"

@implementation ARLabel
@synthesize label;
-(id)init:(NSString*)text
{
    [self CreateImage:text];
           return self;
}
-(void)CreateImage:(NSString*)text{
    CGSize textSize = [text
                       sizeWithFont:[UIFont boldSystemFontOfSize:14]
                       constrainedToSize:CGSizeMake(600, 2000)
                       lineBreakMode: NSLineBreakByWordWrapping];
    label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
    label.text=text;
    [label setBackgroundColor:[UIColor clearColor]];
    label.font=[label.font fontWithSize:14];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    label.numberOfLines=0;

}
-(UIImage *)returnImage {
    
    UIGraphicsBeginImageContext(label.bounds.size);
    [label.layer  renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // returning the UIImage
    return viewImage;
   }
@end
