//
//  PlistToModelConverter.h
//  CharactersTables
//
//  Created by Filipe Patrício on 14/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kKeyShowName        @"showName"
#define kKeyShowImageName   @"showImageName"
#define kKeyShowCharacters  @"showCharacters"
#define kKeyCharName        @"charName"
#define kKeyCharImageName   @"charImageName"

@interface PlistToModelConverter : NSObject
+(NSArray*)convertShowsPlistToShowsArray; //Returs NSArray* Of ShowModel
@end
