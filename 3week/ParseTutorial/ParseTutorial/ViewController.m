//
//  ViewController.m
//  ParseTutorial
//
//  Created by Filipe Patrício on 22/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)actionLogin:(id)sender
{
    [PFUser logInWithUsernameInBackground:self.usernameField.text
                                 password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            self.view.backgroundColor = [UIColor greenColor];
                                            [self performSegueWithIdentifier:@"LogSegue" sender:self];
                                        } else {
                                            self.view.backgroundColor = [UIColor redColor];
                                            NSString *errorString = [error userInfo][@"error"];
                                            NSLog(@"error: %@", errorString);
                                        }
                                    }];
    
}

- (IBAction)actionRegister:(id)sender
{
    PFUser *user = [PFUser user];
    user.username = self.usernameField.text ;
    user.password = self.passwordField.text;
    
//    other fields can be set if you want to save more information
//    user[@"phone"] = @"650-555-0000";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            self.view.backgroundColor = [UIColor greenColor];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"error: %@", errorString);
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
