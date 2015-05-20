//
//  ShowModel.m
//  ComplicatedModel
//
//  Created by Georgios Pessios on 5/14/15.
//  Copyright (c) 2015 Georgios Pessios. All rights reserved.
//

#import "ShowModel.h"
#import "CharacterModel.h"

@implementation ShowModel

-(instancetype)initWithShowName:(NSString *)showName andWithShowImage:(NSString *)showImage andWithShowCharacters:(NSArray *)showCharacters{

    self = [self init];
    
    if(self){
    
        self.showName = showName;
        self.showImage = showImage;
        
        NSMutableArray *characters = [[NSMutableArray alloc] init];
        
        for (NSDictionary *eachCharacter in showCharacters) {
           
            CharacterModel *oneCharacter = [[CharacterModel alloc]initWithNameOfCharacter:eachCharacter[@"name"] andWithImageOfCharacter:eachCharacter[@"image"]];
            
            [characters addObject:oneCharacter];
        }
        
        self.showCharacters = characters;
    
    }
    
    return self;

}


//FIRST THIS IS EXECUTED BECAUSE I CALL IT ON MY CONTROLLER SO THE PLIST FILE IS LOADED

+(NSArray *)arrayOfShows{

    NSArray *arrayFromPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    
    NSMutableArray *shows = [[NSMutableArray alloc]init];
    
    for (NSDictionary *eachShowFromPlist in arrayFromPlist) {
        
        ShowModel *eachShow = [[ShowModel alloc] initWithShowName:eachShowFromPlist[@"showName"] andWithShowImage:eachShowFromPlist[@"showImage"] andWithShowCharacters:eachShowFromPlist[@"showCharacters"]];
        
        [shows addObject:eachShow];
        
    }

    return shows;

}

@end
