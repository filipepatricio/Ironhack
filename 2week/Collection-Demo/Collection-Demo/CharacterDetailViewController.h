//
//  CharacterDetailViewController.h
//  Collection-Demo
//
//  Created by Filipe Patrício on 15/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterModel.h"

@interface CharacterDetailViewController : UIViewController
@property(strong, nonatomic)CharacterModel* character;
@end
