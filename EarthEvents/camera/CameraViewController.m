#import "CameraViewController.h"


@implementation CameraViewController

@synthesize captureSession;
@synthesize previewLayer;

#pragma mark Capture Session Configuration


- (id)init {
	if ((self = [super init])) {
		[self setCaptureSession:[[AVCaptureSession alloc] init]];
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
	}
	return self;
}

- (void)addVideoPreviewLayer {
	[self setPreviewLayer:[[AVCaptureVideoPreviewLayer alloc] initWithSession:[self captureSession]] ];
    
	[[self previewLayer] setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
}

- (void)addVideoInput {
	AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if (videoDevice) {
		NSError *error;
		AVCaptureDeviceInput *videoIn = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
		if (!error) {
			if ([[self captureSession] canAddInput:videoIn])
				[[self captureSession] addInput:videoIn];
			else
				NSLog(@"Couldn't add video input");
		}
		else
			NSLog(@"Couldn't create video input");
	}
	else
		NSLog(@"Couldn't create video capture device");
}
-(void) addVideoOutput{
     videoOutput = [[AVCaptureVideoDataOutput alloc] init];
	[videoOutput setAlwaysDiscardsLateVideoFrames:YES];
	[videoOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
	[videoOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
	if ([captureSession canAddOutput:videoOutput])
		[captureSession addOutput:videoOutput];
	else
	{
		NSLog(@"Couldn't add video output");
	}
	[captureSession setSessionPreset:AVCaptureSessionPreset640x480];
}


#pragma mark -
#pragma mark AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
	CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
	[self.delegate processNewCameraFrame:pixelBuffer];
}

#pragma mark -
#pragma mark Accessors

@synthesize delegate;


-(void)preview
{
    [self addVideoInput];
    [self addVideoPreviewLayer];
    [[self captureSession] startRunning];
}

- (void)dealloc {
    
	[[self captureSession] stopRunning];
    
	
}

@end
