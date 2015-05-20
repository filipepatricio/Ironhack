//
//  AddCharacterVC.m
//  CharactersTables
//
//  Created by Filipe Patrício on 14/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "AddCharacterVC.h"


@interface AddCharacterVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageTextField;
@end

@implementation AddCharacterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)actionDone:(id)sender
{
    if(self.nameTextField.text != nil)
    {
    CharacterModel *newCharacter = [[CharacterModel alloc]
                                    initWithName:self.nameTextField.text
                                    AndImageName:self.imageTextField.text];
    
    [self.delegate formViewController:self didCreateCharacter:newCharacter];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"UNWIND");
}
*/

@end
