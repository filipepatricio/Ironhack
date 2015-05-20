//
//  EditCharacterViewController.h
//  ComplicatedModel
//
//  Created by Filipe Patrício on 20/05/15.
//  Copyright (c) 2015 Georgios Pessios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterModel.h"

@protocol EditCharacterDelegate <NSObject>
@required
-(void)viewController:(UIViewController*)viewController editedCharacter:(CharacterModel*)character indexPath:(NSIndexPath*)indexPath;

-(void)viewController:(UIViewController*)viewController deletedCharacter:(CharacterModel*)character indexPath:(NSIndexPath*)indexPath;

@end

@interface EditCharacterViewController : UIViewController
@property (weak, nonatomic)UIViewController<EditCharacterDelegate> *delegate;
@property (weak, nonatomic)CharacterModel *character;
@property (weak, nonatomic)NSIndexPath *indexPath;
@end
