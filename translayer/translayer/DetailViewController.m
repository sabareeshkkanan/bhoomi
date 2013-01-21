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
    scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(140, 100, 500, 600)];
    [scroll setBackgroundColor:[UIColor clearColor]];
    scroll.showsVerticalScrollIndicator=YES;
    [scroll setPagingEnabled:YES];
    imageviews=[[NSMutableArray alloc] init];
    yOrigin=0;
    if([event.eventType isEqualToString:@"personal"])
        [self loadPersonalEvent];
    else
      [self loadNewEvent];
    [self.view addSubview:scroll];
  
    
	// Do any additional setup after loading the view.
}
-(void)loadPersonalEvent
{
    [self addLabel:[event name]];
    NSString *content=[NSString stringWithFormat:@"%s%@ \n %s%@ \n%@","Start Date : ",event.startDate,"End Date : ",event.endDate,event.notes];
    
    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(0, yOrigin, size.width, 30)];
    
    
    [textView setText:content];
    float numlines=textView.contentSize.height/textView.font.leading;
    [textView setFrame:CGRectMake(0, yOrigin, size.width, 30*numlines)];
    [self addtoY:30*numlines];
    [textView setScrollEnabled:YES];
    [scroll addSubview:textView];

}
-(void)loadNewEvent
{
    
    [self setTitle:[event name]];
    
    if(event.startDate)
    {
    NSString *content=[NSString stringWithFormat:@"%s%@ \n %s%@ \n","Start Date : ",event.startDate,"End Date : ",event.endDate];
    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(0, yOrigin, size.width, 30)];
    
    
    [textView setText:content];
    float numlines=textView.contentSize.height/textView.font.leading;
    [textView setFrame:CGRectMake(0, yOrigin, size.width, 30*numlines)];
    [self addtoY:30*numlines];
    [textView setScrollEnabled:YES];
    [scroll addSubview:textView];

    }
    
    for(ARMedia* media in [event valueForKey:@"media"]){
        if([[media type] isEqualToString:@"Video"])
            [self mediawithVideo:media];
        else if ([[media type]isEqualToString:@"Image"])
            [self mediawithImage:media];
        else if ([[media type]isEqualToString:@"Data"])
            [self mediawithData:media];
        
    }
    scroll.contentSize=CGSizeMake(500, yOrigin);
    
}
-(void)mediawithData:(ARMedia*)data{
    [self addLabel:[data name]];
     UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(0, yOrigin, size.width, 30)];
        [textView setText:[data url]];
    float numlines=textView.contentSize.height/textView.font.leading;
    [textView setFrame:CGRectMake(0, yOrigin, size.width, 30*numlines)];
    [self addtoY:30*numlines];

    [textView setScrollEnabled:YES];
    [scroll addSubview:textView];
}
-(void)mediawithVideo:(ARMedia*)video{
    [self addLabel:[video name]];
    NSURL *url=[[NSURL alloc] initWithString:[video url]];
    movie=[[MPMoviePlayerController alloc] initWithContentURL:url];
    [movie.view setFrame:CGRectMake(0, yOrigin, size.width, size.height)];
    [movie prepareToPlay];
    [self addtoY:size.height];
   
    movie.fullscreen=YES;
    movie.shouldAutoplay=NO;
    movie.allowsAirPlay=YES;
    movie.controlStyle=MPMovieControlStyleEmbedded;
     [scroll addSubview:movie.view];
}
-(void)mediawithImage:(ARMedia*)img{
    
    [self addLabel:[img name]];
     UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, yOrigin, size.width, size.height)];
    [imageviews addObject:imageview];
    [self addtoY:size.height];
   ARCloud* cloud=[[ARCloud alloc] init];
    [cloud setDelegate:self];

    [cloud request:[img url]:[imageviews count]];
    [scroll addSubview:imageview];
}
-(void)addLabel:(NSString*)txt
{
    UILabel *Label=[[UILabel alloc] initWithFrame:CGRectMake(0, yOrigin, size.width, 30)];
    [self addtoY:30];
    [Label setText:txt];
    [Label setTextAlignment:NSTextAlignmentCenter];
    [scroll addSubview:Label];
}
-(void)addtoY:(int)y
{
    yOrigin+=y+10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)OnDownload:(NSData *)data:(int)ref
{
    UIImage *img=[UIImage imageWithData:data];
    [[imageviews objectAtIndex:(ref-1)] setImage:img] ;
}
@end
