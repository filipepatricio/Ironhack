//
//  ViewController.m
//  AutoLayoutProject
//
//  Lesson By:Ferran Maylinch (fmaylinch) - Github: https://github.com/fmaylinch
//
//  Created by Filipe Patrício on 26/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import "AutolayoutHelper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *black;
@property (strong, nonatomic) NSDictionary *views;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.black.hidden = YES;
    
    [self createViews];
    //[self createConstraints];
    [self createConstraintsUsingAutoLayoutHelper];
    
}

- (void)createViews
{
    UILabel* red = [[UILabel alloc] init];
    red.backgroundColor = [UIColor redColor];
    red.text = @"red";
    red.textColor = [UIColor whiteColor];
    red.textAlignment = NSTextAlignmentCenter;
    [red setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UILabel* blue = [[UILabel alloc] init];
    blue.backgroundColor = [UIColor blueColor];
    blue.text = @"blue";
    blue.textColor = [UIColor whiteColor];
    blue.textAlignment = NSTextAlignmentCenter;
    [blue setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UILabel* green = [[UILabel alloc] init];
    green.backgroundColor = [UIColor greenColor];
    green.text = @"green";
    green.textColor = [UIColor whiteColor];
    green.textAlignment = NSTextAlignmentCenter;
    [green setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.black addSubview:red];
    [self.black addSubview:blue];
    [self.black addSubview:green];
    
    id top = self.topLayoutGuide;       //to have vertical margin top (only needed with self.view)
    id bottom = self.bottomLayoutGuide; //to have vertical margin bottom (only needed with self.view)
    
    
//    NSDictionary *views = @{
//                            @"blue":blue,
//                            @"red":red,
//                            @"green":green,
//                            @"top":top,
//                            @"bottom":bottom,
//                            };
    
    //This line does the same thing than above
    self.views = NSDictionaryOfVariableBindings(blue, red, green, top, bottom);

}

-(void)createConstraints
{
    //Visual format create various constraints at the same time
        NSArray* cs1 = [NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-[blue]-[red]-|"
                        options:0
                        metrics:nil
                        views:self.views];
    
        NSArray* cs2 = [NSLayoutConstraint
                        constraintsWithVisualFormat:@"V:[top]-[red]-[green]-[bottom]"
                        options:0
                        metrics:nil
                        views:self.views];
    
        NSArray* cs3 = [NSLayoutConstraint
                        constraintsWithVisualFormat:@"V:[top]-[blue(==green)]-[green]-[bottom]"
                        options:0
                        metrics:nil
                        views:self.views];
    
        NSArray* cs4 = [NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-[green]-|"
                        options:0
                        metrics:nil
                        views:self.views];
    
    
    UIView *red = self.views[@"red"];
    UIView *blue = self.views[@"blue"];
    
    //Constraint Formula:                            FirstItem.FirstAttribue <relatedBy> SecondItem.SecondAttribute * Multiplier + Constant
    //Constraint Formula we are setting bellow:      blue.width = red.width * 0.5 + 0
    
    NSLayoutConstraint *cs5 = [NSLayoutConstraint constraintWithItem:blue
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:red
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:0.5
                                                            constant:0];
    
    [self.view addConstraints:cs1];
    [self.view addConstraints:cs2];
    [self.view addConstraints:cs3];
    [self.view addConstraints:cs4];
    [self.view addConstraint:cs5];
}

-(void)createConstraintsUsingAutoLayoutHelper
{
    
    //Using AutolayoutHelper to do the same as createConstraints!
    [AutolayoutHelper configureView:self.view
                           subViews:self.views
                        constraints:@[
                                      @"H:|-[blue]-[red]-|",                        //cs1
                                      @"V:[top]-[red]-[green]-[bottom]",            //cs2
                                      @"V:[top]-[blue(==green)]-[green]-[bottom]",  //cs3
                                      @"H:|-[green]-|",                             //cs4
                                      @"X:blue.width == red.width * 0.5 + 0",       //cs5 (X: stands for Xpecial)
                                      ]];
}


@end
