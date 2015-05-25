//
//  Beer.m
//  Copying
//
//  Created by Filipe Patrício on 25/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Beer.h"

@interface Beer () <NSCoding>

@end

@implementation Beer
-(id)copyWithZone:(NSZone*)zone
{
    Beer *copyBeer = [Beer allocWithZone:zone];
    if(copyBeer)
        copyBeer.brand = self.brand;
        
    return copyBeer;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.brand forKey:@"Brand"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.brand = [aDecoder decodeObjectForKey:@"Brand"];
    }
    return nil;
}

@end
