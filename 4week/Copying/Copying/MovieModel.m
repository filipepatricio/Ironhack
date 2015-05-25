//
//  MovieModel.m
//  Copying
//
//  Created by Filipe Patrício on 25/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "MovieModel.h"

@interface MovieModel () <NSCopying>

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

@end
