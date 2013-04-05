//
//  DetailViewController.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARCloud.h"
#import "AREvent.h"
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>

@interface DetailViewController : UIViewController<CloudResponse>
{
    
   
    UIScrollView *scroll;
    NSMutableArray *imageviews;
   
    int yOrigin;
    CGSize size;
   
  
}
@property(nonatomic,retain)AREvent *event;
@property(nonatomic,retain) MPMoviePlayerController *movie;
-(void)loadNewEvent;
@end
