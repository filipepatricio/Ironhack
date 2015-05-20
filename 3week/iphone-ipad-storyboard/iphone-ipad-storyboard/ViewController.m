//
//  ViewController.m
//  iphone-ipad-storyboard
//
//  Created by Marin Todorov on 5/19/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel* myLabel;

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


-(IBAction)actionButtonPushed:(id)sender
{
    self.myLabel.text = @"You pushed me!";
}

-(IBAction)actionExtraButtonPushed:(id)sender
{
    self.myLabel.text = @"Ah! Having an iPad, eh?";
}

@end
