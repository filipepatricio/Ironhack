//
//  CoolBar.m
//  CoreLocationAndMapKit
//
//  Created by Filipe Patrício on 11/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "CoolBar.h"

@implementation CoolBar

-(NSString *)title
{
    return self.name;
}

-(NSString *)subtitle
{
    return [NSString stringWithFormat:@"%d", self.type];
}



@end
