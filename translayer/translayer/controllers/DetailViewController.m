//
//  DetailViewController.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize event,movie;

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    
    size=CGSizeMake(500, 500);
    scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(140, 150, 520, 600)];
    [scroll setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9]];
    scroll.layer.cornerRadius = 8;
    scroll.layer.masksToBounds=YES;
    scroll.showsVerticalScrollIndicator=YES;
    imageviews=[[NSMutableArray alloc] init];
    yOrigin=5;
    if([event.eventType isEqualToString:@"personal"])
        [self loadPersonalEvent];
    else
      [self loadNewEvent];
    [self.view addSubview:scroll];
}
-(void)loadPersonalEvent
{
    [self setTitle:[event name]];
     UIColor *labelcolor=[UIColor colorWithRed:0.4 green:0.5 blue:0.9 alpha:0.9];
    [self addLabel:event.dates :labelcolor :NSTextAlignmentCenter];
    [self addtoY:10];
    labelcolor=[UIColor colorWithRed:0.3 green:0.6 blue:0.4 alpha:0.9];
    [self addLabel:event.location :labelcolor :NSTextAlignmentCenter];
    [self addtoY:10];
    if([event.notes length]>0)
    [self mediawithData:event.notes: [ UIFont boldSystemFontOfSize: 14 ]];

[self addtoY:10];
}
-(void)loadNewEvent
{
    [self setTitle:[event name]];

    UIColor *labelcolor=[UIColor colorWithRed:0.4 green:0.5 blue:0.9 alpha:0.9];
    [self addLabel:event.dates:labelcolor:NSTextAlignmentCenter];
[self addtoY:10];
    labelcolor=[UIColor colorWithRed:0.3 green:0.6 blue:0.4 alpha:0.9];
    [self addLabel:event.location :labelcolor :NSTextAlignmentCenter];
    [self addtoY:10];
    
    
    if([event._description length]>0)
        [self addtoY:10];
    [self mediawithData:[event _description]: [ UIFont systemFontOfSize: 14 ]];
    if([event.notes length]>0)
    [self mediawithData:[event notes]:[UIFont boldSystemFontOfSize: 14 ]];
  
    for(ARMedia* media in [event valueForKey:@"media"]){
        if([[media type] isEqualToString:@"Video"])
            [self mediawithVideo:media];
        else if ([[media type]isEqualToString:@"Image"])
            [self mediawithImage:media];
    }
    
    scroll.contentSize=CGSizeMake(500, yOrigin+50);
    
}
-(void)mediawithData:(NSString*)data :(UIFont*)font{
    
     CGSize sizeOfText=[data sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
     UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(10, yOrigin, size.width, sizeOfText.height+30)];
        [textView setText:data];
    [textView setEditable:NO];
    [ textView setFont:font];

    textView.layer.cornerRadius=8;
    [self addtoY: sizeOfText.height+30];
    [textView setDataDetectorTypes:UIDataDetectorTypeLink];
    [textView setScrollEnabled:YES];
    [scroll addSubview:textView];
    [self addtoY:10];
}
-(void)mediawithVideo:(ARMedia*)video{
    UIColor *labelColor=[UIColor colorWithRed:0.9 green:0.5 blue:0.0 alpha:0.9];
    [self addLabel:[video name]:labelColor:NSTextAlignmentCenter];
    NSURL *url=[[NSURL alloc] initWithString:[video url]];
    movie=[[MPMoviePlayerController alloc] initWithContentURL:url];
    [movie.view setFrame:CGRectMake(10, yOrigin, size.width, size.height)];
    [movie prepareToPlay];
    [self addtoY:size.height];
   
    movie.fullscreen=YES;
    movie.shouldAutoplay=NO;
       movie.controlStyle=MPMovieControlStyleEmbedded;

     [scroll addSubview:movie.view];
    [self addtoY:10];
}
-(void)mediawithImage:(ARMedia*)img{
    UIColor *labelColor=[UIColor colorWithRed:0.9 green:0.5 blue:0.0 alpha:0.9];
    [self addLabel:[img name]:labelColor:NSTextAlignmentCenter];
     UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(10, yOrigin, size.width, size.height)];
    [imageviews addObject:imageview];
    [self addtoY:size.height];
   ARCloud* cloud=[[ARCloud alloc] init];
    [cloud setDelegate:self];
 
    [cloud request:[img url]:[imageviews count]];
    [scroll addSubview:imageview];
    [self addtoY:10];
}
-(void)addLabel:(NSString*)txt :(UIColor*)bgcolor :(NSTextAlignment)alignment
{
    CGSize sizeOfText=[txt sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel *Label=[[UILabel alloc] initWithFrame:CGRectMake(10, yOrigin, size.width, sizeOfText.height+30)];
    Label.numberOfLines=0;
    
    [self addtoY:sizeOfText.height+30];
    [Label  setBackgroundColor:bgcolor];
    [Label setText:txt];
    [Label setTextAlignment:alignment];
    [scroll addSubview:Label];
}
-(void)addtoY:(int)y
{
    yOrigin+=y;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)OnDownload:(NSData *)data :(int)ref
{
    UIImage *img=[UIImage imageWithData:data];
    [[imageviews objectAtIndex:(ref-1)] setImage:img] ;
}
@end
