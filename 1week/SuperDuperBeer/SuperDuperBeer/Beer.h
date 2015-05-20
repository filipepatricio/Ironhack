//
//  Beer.h
//  SuperDuperBeer
//
//  Created by Filipe Patrício on 08/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beer : NSObject <NSCoding>
@property (nonatomic) NSString *name;
@property (nonatomic) NSUInteger countryID;
@property (nonatomic) NSString *imageName;
@property (nonatomic) NSUInteger alcoholPercent;
-(instancetype)initWithName:(NSString*)name
              withCountryID:(NSUInteger)countryID
              withImageName:(NSString*)imageName
         withAlcoholPercent:(NSUInteger)alcoholPercent;

@end
