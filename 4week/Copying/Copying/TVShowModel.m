//
//  TVShowModel.m
//  Copying
//
//  Created by Filipe Patrício on 25/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "TVShowModel.h"


@implementation TVShowModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"title" : @"title",
             @"numberOfSeasons" : @"numberOfSeasons",
             };
}

@end
