//
//  EditCharacterViewController.m
//  ComplicatedModel
//
//  Created by Filipe Patrício on 20/05/15.
//  Copyright (c) 2015 Georgios Pessios. All rights reserved.
//

#import "EditCharacterViewController.h"

@interface EditCharacterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation EditCharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.image = [UIImage imageNamed:self.character.image];
    self.textField.text = self.character.name;
}

- (IBAction)actionDone:(id)sender
{
    self.character.name = self.textField.text;
    [self.delegate viewController:self editedCharacter:self.character indexPath:self.indexPath];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionDelete:(id)sender
{
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.imageView.alpha = 0.0;
        self.textField.alpha = 0.0;
        self.nameLabel.alpha = 0.0;
        
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 animations:^{
                self.view.backgroundColor = ((UIButton*)sender).backgroundColor;
        }completion:^(BOOL finished) {
            [self.delegate viewController:self deletedCharacter:self.character indexPath:self.indexPath];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
