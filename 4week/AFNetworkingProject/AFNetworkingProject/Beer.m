//
//  Beer.m
//  AFNetworkingProject
//
//  Created by Filipe Patrício on 27/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Beer.h"

@implementation Beer

//Tell Mantle how we want to map our properties with json reponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"name" : @"name",
             @"info" : @"description",
             @"labelImageURL" : @"labels.large",
             @"labelThumbnailURL" : @"labels.icon",
             };
}
@end
