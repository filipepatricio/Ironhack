//
//  Country.m
//  SuperDuperBeer
//
//  Created by Filipe Patrício on 08/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Country.h"

@implementation Country
-(instancetype)initWithCountryID:(NSUInteger)countryID
                        withName:(NSString*)name
                    withFlagIcon:(NSString*)flagIcon
{
    self = [super init];
    if(self)
    {
        self.countryID = countryID;
        self.name = name;
        self.flagIcon = flagIcon;
    }
    return self;
}
@end
