//
//  ViewController.m
//  demo-animations
//
//  Created by Filipe Patrício on 20/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:5.0 animations:^{
        self.imageView.backgroundColor = [UIColor greenColor];
        self.imageView.center = CGPointMake(self.imageView.center.x, self.imageView.center.y + 200);
        
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}



@end
