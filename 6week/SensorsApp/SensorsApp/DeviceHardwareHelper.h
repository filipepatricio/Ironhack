//
//  DeviceHardwareHelper.h
//  SensorsApp
//
//  Created by Filipe Patrício on 10/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>

typedef void(^SimpleBlock)();

@interface DeviceHardwareHelper : NSObject
@property (strong, nonatomic) CMMotionManager *motionManager;
-(instancetype)init;
+(NSString*)batteryLevel;
-(void)onProximityEventApproachDoThis:(SimpleBlock)action;
-(void)onProximityEventLeavingDoThis:(SimpleBlock)action;
@end
