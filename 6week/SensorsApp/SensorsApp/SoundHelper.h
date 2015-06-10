//
//  SoundHelper.h
//  CameraApp
//
//  Created by Filipe Patrício on 10/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SoundHelper;

@protocol SoundEffectDelegate <NSObject>
@optional
-(void)soundEffectDidFinishPlaying:(SoundHelper*)soundHelper;
@end


@interface SoundHelper : NSObject

@property (weak, nonatomic) id<SoundEffectDelegate> delegate;
-(void)play:(NSString *)soundFileName;
-(void)stop;

@end
