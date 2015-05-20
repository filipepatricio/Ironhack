//
//  ViewController.m
//  data-play
//
//  Created by Filipe Patrício on 18/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *touchesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (assign, nonatomic) NSUInteger touchesCounter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    [self startTimer];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.button.layer.cornerRadius = self.button.frame.size.width/2;
    self.button.center = CGPointMake(self.button.frame.size.width/2, self.button.frame.size.height/2);
    [self animateButton:self.button];
}
- (void)animateButton:(UIButton *)sender
{
    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:0.3
          initialSpringVelocity:0.3
                        options:0
                     animations:^{
                         
                         
                         float scaleRandom = [self randomNumberBetween:0.8 maxNumber:1.0];
                         float translateXRandom = [self randomNumberBetween:0.0 maxNumber:self.view.frame.size.width - sender.frame.size.width];
                         float translateYRandom = [self randomNumberBetween:0.0 maxNumber:self.view.frame.size.height - sender.frame.size.height];
                         
                         NSLog(@"view width: %f", self.view.frame.size.width);
                         NSLog(@"view height: %f", self.view.frame.size.height);
                         NSLog(@"random x: %f", translateXRandom);
                         NSLog(@"random y: %f", translateYRandom);
                         
                         CGAffineTransform transformTranslation = CGAffineTransformMakeTranslation(translateXRandom, translateYRandom);
                         sender.transform = CGAffineTransformScale(transformTranslation, scaleRandom, scaleRandom);
                         
                         float red = [self randomNumberBetween:0.0 maxNumber:1.0];
                         float green = [self randomNumberBetween:0.0 maxNumber:1.0];
                         float blue = [self randomNumberBetween:0.0 maxNumber:1.0];
                         sender.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
                         
                         
                     }completion:nil];
}

- (IBAction)actionTapButton:(UIButton*)sender
{
    [self animateButton:sender];
    self.touchesCounter++;
    self.touchesLabel.text = [NSString stringWithFormat:@"%lu", self.touchesCounter ];
}

- (float)randomNumberBetween:(float)min maxNumber:(float)max
{
    return  (((float)arc4random()/0x100000000)*(max-min)+min);
}

-(void)startTimer
{
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(updateUI)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)updateUI
{
//    self.touchesLabel.text = [NSString stringWithFormat:@"%lu", self.touchesCounter ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
