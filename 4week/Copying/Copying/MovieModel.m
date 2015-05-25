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

@end
