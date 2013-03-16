//
//  ARVideo.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/8/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//comment


#import <AVFoundation/AVFoundation.h>
@interface ARVideo : NSObject
{
    AVURLAsset *asset;
    AVAssetReader *asset_reader;
    AVAssetTrack* video_track ;
    AVAssetReaderTrackOutput* asset_reader_output;
    CGImageRef newImage ;
}
-(CGImageRef)get;

-(void)img;


@end
