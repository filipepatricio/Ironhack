//
//  ShowModel.m
//  CharactersTables
//
//  Created by Filipe Patrício on 14/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ShowModel.h"
#import "CharacterModel.h"

@implementation ShowModel
-(instancetype)initWithName:(NSString*)name
              WithImageName:(NSString*)imageName
    WithArrayOfCharacters:(NSArray*)characters
{
    self = [self init];
    if(self)
    {
        self.name = name;
        self.imageName = imageName;
        self.characters = characters;
    }
    return self;
}


@end
