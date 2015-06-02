//
//  NSString+Random.m
//  Models
//
//  Created by Daniel García on 17/05/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)
+ (NSString *)randomString{
    NSString *randomString=@"";
    NSInteger numberOfLetters=arc4random_uniform(10) + 4;
    for (NSInteger i=0; i<numberOfLetters; i++) {
        randomString = [randomString stringByAppendingString:[NSString stringWithFormat:@"%c", arc4random_uniform(26) + 'a']];
    }
    return randomString;
}
@end
