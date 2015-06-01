//
//  NSString+Random.m
//  Artists
//
//  Created by Filipe Patrício on 01/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)

+ (NSString *)randomNameGeneratorWithLength:(NSInteger)characterLength
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:characterLength];
    
    for (int i = 0; i < characterLength; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

@end
