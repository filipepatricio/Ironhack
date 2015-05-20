//
//  ViewController.m
//  TrafficLights
//
//  Created by Filipe Patrício on 11/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *trafficLightView;
@property (strong, nonatomic) NSArray *colors; //of UIColor;
@property (assign, nonatomic) int currentIndex;
@end

@implementation ViewController

-(NSArray*)colors
{
    if(!_colors)
    {
        _colors = @[[UIColor redColor],
                    [UIColor yellowColor],
                    [UIColor greenColor]
                    ];
    }
    return _colors;
}

-(TrafficLights*)tfDurations
{
    if(!_tfDurations)
        _tfDurations = [[TrafficLights alloc] init];
    return _tfDurations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self changeColors];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

-(void)changeColors
{
    [self.trafficLightView setBackgroundColor: self.colors[self.currentIndex]];
    NSUInteger duration = [self.tfDurations durationForIndex:self.currentIndex];
    [self performSelector:@selector(changeColors) withObject:nil afterDelay:duration ];
    
    self.currentIndex++;
    if(self.currentIndex == self.colors.count)
        self.currentIndex = 0;

    NSLog(@"Changed Color");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
