//
//  Country.h
//  SuperDuperBeer
//
//  Created by Filipe Patrício on 08/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic) NSUInteger countryID;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *flagIcon;
-(instancetype)initWithCountryID:(NSUInteger)countryID
                        withName:(NSString*)name
                    withFlagIcon:(NSString*)flagIcon;

@end
