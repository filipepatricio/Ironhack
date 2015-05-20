//
//  FormViewController.m
//  ComplicatedModel
//
//  Created by Marin Todorov on 5/14/15.
//  Copyright (c) 2015 Georgios Pessios. All rights reserved.
//

#import "FormViewController.h"
#import "CharacterModel.h"

@interface FormViewController ()

@property (weak, nonatomic) IBOutlet UITextField *characterNameField;

@end

@implementation FormViewController

- (IBAction)actionSave:(id)sender {
    
    NSString* name = self.characterNameField.text;
    CharacterModel* newCharacter =
      [[CharacterModel alloc] initWithNameOfCharacter:name
                              andWithImageOfCharacter:@"lisa.png"];
    
    [self.delegate didCreateCharacter:newCharacter];
    
    [self.navigationController
        popViewControllerAnimated:YES];
}

@end