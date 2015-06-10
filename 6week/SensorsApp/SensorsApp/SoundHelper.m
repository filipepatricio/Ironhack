//
//  SoundHelper.m
//  CameraApp
//
//  Created by Filipe Patrício on 10/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "SoundHelper.h"

@import AVFoundation;

@interface SoundHelper()<AVAudioPlayerDelegate>
@property (strong, nonatomic)AVAudioPlayer *player;
@end

@implementation SoundHelper

-(void)play:(NSString *)soundFileName
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:soundFileName ofType:@"wav"];
    NSError *error;
    NSData *soundData = [NSData dataWithContentsOfFile:filepath options:NSDataReadingMapped error:&error];
    
    self.player = [[AVAudioPlayer alloc] initWithData:soundData error:&error];
    
    self.player.numberOfLoops = 0;     // -1 for infinite loop
    [self.player play];
    self.player.delegate = self;
    
}

-(void)stop
{
    [self.player stop];
}
     
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if([self.delegate respondsToSelector:@selector(soundEffectDidFinishPlaying:)])
    {
        [self.delegate soundEffectDidFinishPlaying:self];
    }
}



@end
