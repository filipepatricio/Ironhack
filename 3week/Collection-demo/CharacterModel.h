//
//  CharactersModel.h
//  ComplicatedModel
//
//  Created by Georgios Pessios on 5/14/15.
//  Copyright (c) 2015 Georgios Pessios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterModel : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *image;


-(instancetype)initWithNameOfCharacter:(NSString *)name andWithImageOfCharacter:(NSString *)image;


@end
