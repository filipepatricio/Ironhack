//
//  Beer.m
//  SuperDuperBeer
//
//  Created by Filipe Patrício on 08/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Beer.h"

@implementation Beer

-(instancetype)initWithName:(NSString*)name
              withCountryID:(NSUInteger)countryID
              withImageName:(NSString*)imageName
         withAlcoholPercent:(NSUInteger)alcoholPercent
{
    self = [super init];
    if(self)
    {
        self.name = name;
        self.countryID = countryID;
        self.imageName = imageName;
        self.alcoholPercent = alcoholPercent;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInteger:self.countryID forKey:@"countryID"];
    [coder encodeObject:self.imageName forKey:@"imageName"];
    [coder encodeInteger:self.alcoholPercent forKey:@"alcoholPercent"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self)
    {
        self.name = [coder decodeObjectForKey:@"name"];
        self.countryID = [coder decodeIntegerForKey:@"countryID"];
        self.imageName = [coder decodeObjectForKey:@"imageName"];
        self.alcoholPercent = [coder decodeIntegerForKey:@"alcoholPercent"];
    }
    return self;
}

@end
