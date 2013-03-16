//
//  ARVideo.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/8/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "ARVideo.h"

@implementation ARVideo

-(id)init
{
    
    return self;
}

-(void)img
{
   
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample_iPod" ofType:@"m4v"]];
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
   asset = [AVURLAsset URLAssetWithURL:url options:options];
  asset_reader = [[AVAssetReader alloc] initWithAsset:asset error:nil];
    NSArray* video_tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
   video_track = [video_tracks objectAtIndex:0];
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
     asset_reader_output = [[AVAssetReaderTrackOutput alloc] initWithTrack:video_track outputSettings:dictionary];
    [asset_reader addOutput:asset_reader_output];
    [asset_reader startReading];
    
}
-(CGImageRef)get{
    CGImageRelease(newImage);

    CMSampleBufferRef buffer;    buffer=[asset_reader_output copyNextSampleBuffer];
    if(buffer){
    CVImageBufferRef imageBuffer=CMSampleBufferGetImageBuffer(buffer);
    /*Lock the image buffer*/
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    /*Get information about the image*/
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    /*Create a CGImageRef from the CVImageBufferRef*/
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
     newImage = CGBitmapContextCreateImage(newContext);
    
    /*We release some components*/
    CGContextRelease(newContext);
    CGColorSpaceRelease(colorSpace);
    
    /*We display the result on the custom layer. All the display stuff must be done in the main thread because
     UIKit is no thread safe, and as we are not in the main thread (remember we didn't use the main_queue)
     we use performSelectorOnMainThread to call our CALayer and tell it to display the CGImage.*/
    
    
      
    /*We unlock the  image buffer*/
        CVPixelBufferUnlockBaseAddress(imageBuffer,0);}
    else
    {
        NSLog(@"%s","x");
    }
    return newImage;

   }

@end
