//
//  Counter.m
//  Animals
//
//  Created by Filipe Patrício on 12/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Counter.h"

@interface Counter ()
@property (assign, nonatomic, readwrite) long counter;
@end

@implementation Counter

+(instancetype)sharedInstance
{
    static Counter *sharedInstance = nil; // Executed ONLY the first time
    if(!sharedInstance)
    {
        sharedInstance = [[Counter alloc]init];
        
        NSObject *numberSaved = [[NSUserDefaults standardUserDefaults] objectForKey:kKeyCounter];
        if (numberSaved != nil && [numberSaved isKindOfClass:[NSNumber class]])
            sharedInstance.counter = [(NSNumber *)numberSaved integerValue];
        else
            sharedInstance.counter = 0;
    }
    return sharedInstance;
}

-(void)incrementCounter
{
    self.counter++;
}

@end
