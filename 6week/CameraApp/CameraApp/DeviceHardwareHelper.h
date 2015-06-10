//
//  DeviceHardwareHelper.h
//  CameraApp
//
//  Created by Filipe Patrício on 10/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceHardwareHelper : NSObject

+(void)vibrate;
+(void)torch:(BOOL)onOff;

@end
