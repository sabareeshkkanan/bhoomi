//
//  DetailViewController.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARCloud.h"
#import "AREvents.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DetailViewController : UIViewController<CloudResponse>
{
    
   
    UIScrollView *scroll;
   // MPMoviePlayerController *movie;
    NSMutableArray *imageviews;
   
    int yOrigin;
    CGSize size;
   
  
}
//@property(nonatomic,strong)MPMoviePlayerController *movie;
@property(nonatomic,retain)AREvents *event;
@property(nonatomic,retain) MPMoviePlayerController *movie;
-(void)loadNewEvent;
@end
