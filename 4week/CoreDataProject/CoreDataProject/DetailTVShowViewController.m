//
//  DetailTVShowViewController.m
//  CoreDataProject
//
//  Created by Filipe Patrício on 27/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "DetailTVShowViewController.h"

@interface DetailTVShowViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberOfSeasonsTextField;

@end

@implementation DetailTVShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleTextField.text = self.selectedTVShow.title;
    self.numberOfSeasonsTextField.text = [self.selectedTVShow.numberOfSeasons stringValue];
    
}

- (IBAction)actionSave:(id)sender
{
    self.selectedTVShow.title = self.titleTextField.text;
    self.selectedTVShow.numberOfSeasons = [NSNumber numberWithLong: [self.numberOfSeasonsTextField.text integerValue]];
    [TVShow save];
    
    [self.titleTextField resignFirstResponder];
    [self.numberOfSeasonsTextField resignFirstResponder];
}

- (IBAction)actionDelete:(id)sender
{
    //Needs Delegate to work
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Delete Show"
                          message:@"Are you sure that you want to delete this show?"
                          delegate:self
                          cancelButtonTitle:@"No"
                          otherButtonTitles:@"Yes", nil];
    
    //    [alert show];
    
    
    //Works without Delegate
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Delete show"
                                          message:@"Are you sure that you want to delete this show?"
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self deleteShowFromCoreDataAndPopViewController];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:delete];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];

}


#pragma mark UIAlertView 

- (void)deleteShowFromCoreDataAndPopViewController
{
    [TVShow deleteTVShow:self.selectedTVShow];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) // Pressed "Yes"
    {
        [self deleteShowFromCoreDataAndPopViewController];
    }
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
