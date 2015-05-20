//
//  CharactersModel.m
//  ComplicatedModel
//
//  Created by Georgios Pessios on 5/14/15.
//  Copyright (c) 2015 Georgios Pessios. All rights reserved.
//

#import "CharacterModel.h"


@implementation CharacterModel

-(instancetype)initWithNameOfCharacter:(NSString *)name andWithImageOfCharacter:(NSString *)image
{
    self = [self init];
    
    if (self){
        self.name = name;
        self.image = image;
    }

    return self;
}

+(NSArray *)allCharacters
{
    NSFileManager* fileManager =
    [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
       NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = paths.firstObject;
    // documentsDirectory is smth like "/user/Marin/documents"
    
    NSString *sourcePath = [[NSBundle mainBundle]
                            pathForResource:@"data"
                            ofType:@"plist"];
    
    NSString *destinationPath = [documentsDirectory
                                 stringByAppendingPathComponent:
                                 @"data.plist"];
    //destinationPath is "/user/Marin/documents/data.plist"
    
    if ([fileManager fileExistsAtPath:destinationPath]==NO) {
        //NO FILE IN DOCUMENTS -> copy it from the bundle
        [fileManager copyItemAtPath:sourcePath
                             toPath:destinationPath
                              error:nil];
    }
    
    NSArray *arrayFromPlist = [NSArray
                               arrayWithContentsOfFile: destinationPath];
    
    NSMutableArray *shows =
    [[NSMutableArray alloc]init];
    
    
    for (NSDictionary *eachCharacterFromPlist in arrayFromPlist) {
        CharacterModel* character = [[CharacterModel alloc] initWithNameOfCharacter:eachCharacterFromPlist[@"name"]
                                                            andWithImageOfCharacter:eachCharacterFromPlist[@"image"]];
        [shows addObject: character];
    }
    
    return shows;
    
}

-(NSDictionary*)toDictionary
{
    return @{
             @"name":self.name,
             @"image":self.image
             };
}

@end
