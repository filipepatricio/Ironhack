//
//  CharacterModel.h
//  CharactersTables
//
//  Created by Filipe Patrício on 14/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterModel : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageName;

-(instancetype)initWithName:(NSString*)name
               AndImageName:(NSString*)imageName;
@end
