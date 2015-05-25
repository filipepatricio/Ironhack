//
//  MovieModel.m
//  Copying
//
//  Created by Filipe Patrício on 25/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "MovieModel.h"

@interface MovieModel () <NSCopying, NSCoding>

@end

@implementation MovieModel

-(id)copyWithZone:(NSZone *)zone
{
    MovieModel *copyMovie = [[MovieModel alloc]init];
    if(copyMovie)
    {
        copyMovie.name = self.name;
        copyMovie.director = self.director;
    }
    
    return copyMovie;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.director forKey:@"director"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if(self)
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.director = [aDecoder decodeObjectForKey:@"director"];
    }
    return self;
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else if(![other isKindOfClass:[MovieModel class]]){
        return NO;
    }
    return [self isEqualToMovie:other];
}

- (BOOL)isEqualToMovie:(MovieModel*)otherMovie
{
    if ([self.name isEqualToString:otherMovie.name])
    {
        return YES;
    }
    else if ([self.director isEqualToString:otherMovie.director])
    {
        return YES;
    }
    else
        return NO;
}

- (NSUInteger)hash
{
    NSUInteger hash = self.name.hash ^ self.director.hash;
    return hash;
}

@end
