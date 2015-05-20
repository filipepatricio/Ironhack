//
//  CharacterModel.m
//  CharactersTables
//
//  Created by Filipe Patrício on 14/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "CharacterModel.h"


@implementation CharacterModel

-(instancetype)initWithName:(NSString*)name
               AndImageName:(NSString*)imageName
{
    self = [self init];
    if(self)
    {
        self.name = name;
        self.imageName = imageName;
    }
    return self;
}


@end
