//
//  DeviceHardwareHelper.m
//  CameraApp
//
//  Created by Filipe Patrício on 10/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "DeviceHardwareHelper.h"
#import <AudioToolbox/AudioToolbox.h>

@import AVFoundation;


@implementation DeviceHardwareHelper

+(void)vibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+(void)torch:(BOOL)onOff
{
    AVCaptureDevice *device = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] firstObject];
    [device lockForConfiguration:nil];
    [device setTorchMode: onOff ? AVCaptureTorchModeOn : AVCaptureTorchModeOff];
    [device unlockForConfiguration];
}

@end
