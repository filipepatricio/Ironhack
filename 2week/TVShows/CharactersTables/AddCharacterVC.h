//
//  AddCharacterVC.h
//  CharactersTables
//
//  Created by Filipe Patrício on 14/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterModel.h"

@class AddCharacterVC;

@protocol AddCharacterViewControllerDelegate <NSObject>
@required
//-(void)didCreateCharacter:(CharacterModel*)character;
-(void)formViewController:(AddCharacterVC*)addCharacterVC
       didCreateCharacter:(CharacterModel*)character;
@end

@interface AddCharacterVC : UIViewController
@property (weak, nonatomic) id<AddCharacterViewControllerDelegate> delegate;
@end
