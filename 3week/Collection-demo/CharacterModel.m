//
//  CharactersModel.m
//  ComplicatedModel
//
//  Created by Georgios Pessios on 5/14/15.
//  Copyright (c) 2015 Georgios Pessios. All rights reserved.
//

#import "CharacterModel.h"


@implementation CharacterModel


-(instancetype)initWithNameOfCharacter:(NSString *)name andWithImageOfCharacter:(NSString *)image{

    self = [self init];
    
    if(self){
    
        self.name = name;
        self.image = image;
    
    }

    return self;

}



@end
