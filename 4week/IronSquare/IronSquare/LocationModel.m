//
//  LocalizationModel.m
//  IronSquare
//
//  Created by Filipe Patrício on 29/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
                @"id": @"id",
                @"text": @"text",
                @"latitude": @"latitude",
                @"longitude": @"longitude",
                @"user": @"user",
                @"map_image": @"map_image",
                @"url": @"url"
             };
}

-(instancetype)initWithText:(NSString*)text latitude:(double)lat longitude:(double)lng URL:(NSString*)url
{
    self = [self init];
    if(self)
    {
        self.text = text;
        self.latitude = lat;
        self.longitude = lng;
        self.url = url;
        self.user = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    }
    return self;
}

@end
