//
//  SecondViewController.m
//  CatDog
//
//  Created by Filipe Patrício on 12/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "SecondViewController.h"
#import "XibViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)presentXibVC:(id)sender
{
    XibViewController *xibVC = [[XibViewController alloc] initWithNibName:@"XibViewController" bundle:nil];
    
    [self presentViewController:xibVC animated:YES completion:nil];
}

@end
