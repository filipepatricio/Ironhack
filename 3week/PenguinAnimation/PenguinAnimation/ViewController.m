//
//  ViewController.m
//  PenguinAnimation
//
//  Created by Filipe Patrício on 21/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *penguinImageView;
@property (strong, nonatomic) NSMutableArray *frames; //Of UIImage
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.frames = [[NSMutableArray alloc]init];
    
    for( int i = 1; i < 5; i++)
        [self.frames addObject:[UIImage imageNamed:[NSString stringWithFormat:@"penguin_walk0%d", i]]];
    
    self.penguinImageView.animationDuration = 0.2;
    self.penguinImageView.animationRepeatCount = 2;
    self.penguinImageView.userInteractionEnabled = YES;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didSwipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didSwipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    
    [self.view addGestureRecognizer:swipeRight];
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didSwipeLeft:(UISwipeGestureRecognizer*)recognizer
{
    self.penguinImageView.animationImages = [self.frames copy];
    [self.penguinImageView startAnimating];
    self.penguinImageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    [UIView animateWithDuration:0.5 animations:^{
        self.penguinImageView.center = CGPointMake(self.penguinImageView.center.x - 100, self.penguinImageView.center.y);
    }completion:^(BOOL completion)
     {
         if(self.penguinImageView.center.x < 0)
         {
             self.penguinImageView.center = CGPointMake(self.view.frame.size.width, self.penguinImageView.center.y);
         }
     }];
}
- (void)didSwipeRight:(UISwipeGestureRecognizer*)recognizer
{
    self.penguinImageView.animationImages = [self.frames copy];
    [self.penguinImageView startAnimating];
    self.penguinImageView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.5 animations:^{
        self.penguinImageView.center = CGPointMake(self.penguinImageView.center.x + 100, self.penguinImageView.center.y);
    }completion:^(BOOL completion)
     {
         if(self.penguinImageView.center.x >= self.view.frame.size.width)
         {
             self.penguinImageView.center = CGPointMake(0, self.penguinImageView.center.y);
         }
     }];
}

-(void)didTap:(UITapGestureRecognizer*)recognizer
{
//    NSArray *jumpFrames = @[[UIImage imageNamed:@"penguin_walk02"]];
//    self.penguinImageView.animationImages = jumpFrames;
//    [self.penguinImageView startAnimating];
    
    [UIView animateWithDuration:0.4 delay:0.0 options:0 animations:^{
        self.penguinImageView.center = CGPointMake(self.penguinImageView.center.x, self.penguinImageView.center.y - 100);
    }completion:^(BOOL completion)
     {
         [UIView animateWithDuration:0.4 delay:0.0 options:0 animations:^{
                 self.penguinImageView.center = CGPointMake(self.penguinImageView.center.x, self.penguinImageView.center.y + 100);
         }completion:nil];
     }];
}

@end
