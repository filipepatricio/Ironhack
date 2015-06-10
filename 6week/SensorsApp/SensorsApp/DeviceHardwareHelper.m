//
//  DeviceHardwareHelper.m
//  SensorsApp
//
//  Created by Filipe Patrício on 10/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "DeviceHardwareHelper.h"



@interface DeviceHardwareHelper ()
@property (strong, nonatomic) SimpleBlock approachingBlock;
@property (strong, nonatomic) SimpleBlock leavingBlock;
@end

@implementation DeviceHardwareHelper

-(instancetype)init
{
    if(self = [super init])
    {
        [self setupGyroAccelerometer];
        
        [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateChanged) name:UIDeviceProximityStateDidChangeNotification object:nil];
    }
    return self;
}

-(void)setupGyroAccelerometer
{
    self.motionManager = [[CMMotionManager alloc] init];
    
    if(self.motionManager.accelerometerAvailable)
    {
        self.motionManager.accelerometerUpdateInterval = 1.0;
        [self.motionManager
         startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
         withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                 NSLog(@"Accelerometer X:%.0f Y:%.0f Z:%.0f", accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
             }];
    }
    
    if(self.motionManager.gyroAvailable)
    {
        self.motionManager.gyroUpdateInterval = 1.0;
        [self.motionManager
         startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
         withHandler:^(CMGyroData *gyroData, NSError *error) {
//                NSLog(@"Gyroscope rotation X:%.0f Y:%.0f Z:%.0f ", gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z);
            }];
    }
}

+(NSString*)batteryLevel
{
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    
    float batteryLevel = device.batteryLevel;
    
    if(batteryLevel < 0)
        NSLog(@"unknown battery level");
    else
    {
        static NSNumberFormatter *numberFormatter = nil;
        if(!numberFormatter)
        {
            numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
            [numberFormatter setMaximumFractionDigits:1];
        }
        
        NSNumber *levelNumber = [NSNumber numberWithFloat:batteryLevel];
        
        return [numberFormatter stringFromNumber:levelNumber];
    }
    
    device.batteryMonitoringEnabled = NO;
    
    return @"Unknown";
}


-(void)onProximityEventApproachDoThis:(SimpleBlock)action
{
    self.approachingBlock = action;
}

-(void)onProximityEventLeavingDoThis:(SimpleBlock)action
{
    self.leavingBlock = action;
}

-(void)proximityStateChanged
{
    if([[UIDevice currentDevice] proximityState] == YES)
    {
        self.approachingBlock();
    }else
    {
        self.leavingBlock();
    }
}



@end
