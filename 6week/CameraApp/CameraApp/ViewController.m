//
//  ViewController.m
//  CameraApp
//
//  Created by Filipe Patrício on 10/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "DeviceHardwareHelper.h"
#import "SoundHelper.h"
@import ImageIO;

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, SoundEffectDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL timerOn;
@property (strong, nonatomic) SoundHelper *sound;
@end

@implementation ViewController

-(NSTimer *)timer
{
    if(!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerActivities) userInfo:nil repeats:YES];
    }
    return _timer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.sound = [[SoundHelper alloc] init];
    self.sound.delegate = self;
}
- (IBAction)actionCamera:(id)sender
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        picker.showsCameraControls = YES;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void)timerActivities
{
    [DeviceHardwareHelper torch:YES];
    [DeviceHardwareHelper vibrate];
    [DeviceHardwareHelper torch:NO];
    [self.sound play:@"Affirmative"];
}

- (IBAction)actionTimer:(id)sender
{
    if(!self.timerOn)
        [self.timer fire];
    else
    {
        [self.timer invalidate];
        self.timer = nil;
    }

    
    self.timerOn = !self.timerOn;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        self.photoImageView.image = info[UIImagePickerControllerOriginalImage];
//        [self zoomToFace];
        
        //SaveToCameraRoll
        //UIImageWriteToSavedPhotosAlbum(self.photoImageView.image, self, nil, nil);
    }
    else if([mediaType isEqualToString:(NSString *)kUTTypeVideo])
    {
        //Do some stuff for video
    }
}

- (IBAction)actionLibrary:(id)sender
{
    
}

#pragma mark SoundHelperDelegate

-(void)soundEffectDidFinishPlaying:(SoundHelper *)soundHelper
{
    NSLog(@"finished playing!");
    
}

#pragma mark Shake

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(motion == UIEventSubtypeMotionShake)
    {
        [self actionTimer:nil];
    }
}

-(void)zoomToFace
{
    NSArray *features = [self featuresInImage:self.photoImageView.image];
    
    CIFeature *face = [features lastObject];
    CGRect faceBounds = face.bounds;
    
    CIImage *image = [CIImage imageWithCGImage:self.photoImageView.image.CGImage];
    CIImage *crop = [image imageByCroppingToRect:faceBounds];
    
    UIImage *newImage = [UIImage imageWithCIImage:crop];
    
    self.photoImageView.image = newImage;
}

-(NSArray *)featuresInImage:(UIImage *)image
{
    CIContext *ctxt = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:ctxt
                                              options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    CIImage *imgFromData = [CIImage imageWithData:imgData];
    NSDictionary *opts = @{CIDetectorImageOrientation:[imgFromData properties][(NSString*)kCGImagePropertyOrientation]};
    
    return [detector featuresInImage:imgFromData options:opts];
}

@end
