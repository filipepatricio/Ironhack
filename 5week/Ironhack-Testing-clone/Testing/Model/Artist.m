//
//  Artist.m
//  SCTestClient
//
//  Created by Joan Romano on 3/17/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "Artist.h"

@interface Artist ()

@property (nonatomic, copy) NSString *name;

@end

@implementation Artist

- (instancetype)initWithName:(NSString *)name
{
    if (self = [super init])
    {
        _name = [name copy];
    }
    
    return self;
}

@end
