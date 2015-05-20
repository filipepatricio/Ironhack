//
//  ShowModel.h
//  ComplicatedModel
//
//  Created by Georgios Pessios on 5/14/15.
//  Copyright (c) 2015 Georgios Pessios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowModel : NSObject

@property(nonatomic, strong)NSString *showName;
@property(nonatomic, strong)NSString *showImage;
@property(nonatomic, strong)NSArray *showCharacters;
//@property(nonatomic, strong)NSString *name;
//@property(nonatomic, strong)NSString *image;


-(instancetype)initWithShowName:(NSString *)showName andWithShowImage:(NSString *)showImage andWithShowCharacters:(NSArray *)showCharacters;

+(NSArray *)arrayOfShows;

@end
