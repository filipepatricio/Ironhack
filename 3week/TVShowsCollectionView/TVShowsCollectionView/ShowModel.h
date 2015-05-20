//
//  ShowModel.h
//  CharactersTables
//
//  Created by Filipe Patrício on 14/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowModel : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSArray *characters;  //Of CharacterModel

-(instancetype)initWithName:(NSString*)name
              WithImageName:(NSString*)imageName
      WithArrayOfCharacters:(NSArray*)characters; //Of NSDictionary

-(NSDictionary*)toDictionary;
@end
