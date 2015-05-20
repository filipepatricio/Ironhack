//
//  FirstViewController.m
//  CatDog
//
//  Created by Filipe Patrício on 12/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "FirstViewController.h"
#import "ModalViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navController = (UINavigationController*)segue.destinationViewController;
        ModalViewController *modalVC = (ModalViewController*)navController.topViewController;
        
        if([segue.identifier isEqualToString:@"CatSegue"])
        {
            modalVC.image = [UIImage imageNamed:@"cat"];
        }
        else if([segue.identifier isEqualToString:@"DogSegue"])
        {
            modalVC.image = [UIImage imageNamed:@"dog"];
        }
    }
}

@end
