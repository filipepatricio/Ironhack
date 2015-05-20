//
//  PlistToModelConverter.m
//  CharactersTables
//
//  Created by Filipe Patrício on 14/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "PlistToModelConverter.h"
#import "ShowModel.h"
#import "CharacterModel.h"

#define kKeyShowName        @"showName"
#define kKeyShowImageName   @"showImageName"
#define kKeyShowCharacters  @"showCharacters"
#define kKeyCharName        @"charName"
#define kKeyCharImageName   @"charImageName"

@implementation PlistToModelConverter
+(NSArray*)convertShowsPlistToShowsArray
{
    NSArray *showsArrayFromFile = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Shows" ofType:@"plist"]];
    
    NSMutableArray *showsArray = [[NSMutableArray alloc]init];
    
    for(NSDictionary *showDict in showsArrayFromFile)
    {
        NSString *showName = showDict[kKeyShowName];
        NSString *showImageName = showDict[kKeyShowImageName];
        NSArray *showCharactersDictionaries = showDict[kKeyShowCharacters];
        
        NSMutableArray *charactersArray = [[NSMutableArray alloc]init];
        for(NSDictionary *characterDict in showCharactersDictionaries)
        {
            CharacterModel *character = [[CharacterModel alloc]
                                         initWithName:characterDict[kKeyCharName]
                                         AndImageName:characterDict[kKeyCharImageName]];
            
            [charactersArray addObject:character];
        }
        ShowModel *show = [[ShowModel alloc] initWithName:showName
                                            WithImageName:showImageName
                                    WithArrayOfCharacters:charactersArray];
        [showsArray addObject:show];
        
    }
    return showsArray;
}














@end
