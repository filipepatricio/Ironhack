//
//  ViewController.m
//  Animals
//
//  Created by Filipe Patrício on 12/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import "AnimalViewController.h"
#import "Counter.h"

@interface ViewController ()
@property (strong, nonatomic) Counter *counterSharedInstance;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[AnimalViewController class]])
    {
        AnimalViewController *animalVC = segue.destinationViewController;
    
        if([segue.identifier isEqualToString:@"CatSegue"])
        {
            //Pass Cat Image
            animalVC.animalImage = [UIImage imageNamed:@"cat"];
            animalVC.title = @"Cat";
        }
        else if ([segue.identifier isEqualToString:@"DogSegue"])
        {
            //Pass Dog Image
            animalVC.animalImage = [UIImage imageNamed:@"dog"];
            animalVC.title = @"Dog";
        }
        
        [[Counter sharedInstance] incrementCounter];
        
    }
}

@end
