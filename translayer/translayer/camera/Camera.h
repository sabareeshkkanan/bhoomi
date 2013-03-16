#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>

@protocol frameDelegate;
@interface Camera : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate> {
    AVCaptureVideoDataOutput *videoOutput;
}

@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;
@property(nonatomic, assign) id<frameDelegate> delegate;


- (void)addVideoPreviewLayer;
- (void)addVideoInput;
-(void) preview;
-(void) addVideoOutput;


@end
@protocol frameDelegate

- (void)processNewCameraFrame:(CVImageBufferRef)cameraFrame;
@end