//
//  FormViewController.h
//  ComplicatedModel
//
//  Created by Marin Todorov on 5/14/15.
//  Copyright (c) 2015 Georgios Pessios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterModel.h"

@protocol FormViewControllerDelegate <NSObject>

@required
-(void)didCreateCharacter:(CharacterModel*)model;

@end


@interface FormViewController : UIViewController

@property (weak, nonatomic)
    id<FormViewControllerDelegate> delegate;

@end
