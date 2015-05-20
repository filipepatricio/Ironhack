//
//  EditDurationsVC.m
//  TrafficLights
//
//  Created by Filipe Patrício on 11/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "EditDurationsVC.h"
#import "ViewController.h"
#import "TrafficLights.h"

@interface EditDurationsVC ()
@property (weak, nonatomic) IBOutlet UITextField *redLightDuration;
@property (weak, nonatomic) IBOutlet UITextField *yellowLightDuration;
@property (weak, nonatomic) IBOutlet UITextField *greeLightDuration;

@end

@implementation EditDurationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveDurationsButtonPressed:(id)sender
{
//    ViewController *lightsVC = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
//    
//    lightsVC.tfDurations = [[TrafficLights alloc]initWithArray:[self getDurationValues]];
//    
//    [self.navigationController showViewController:lightsVC sender:self];
}

#pragma mark - Navigation

- (NSArray *)getDurationValues {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSArray *durationsValue = @[
                                [NSNumber numberWithDouble:[self.redLightDuration.text doubleValue]],
                                [NSNumber numberWithDouble:[self.yellowLightDuration.text doubleValue]],
                                [NSNumber numberWithDouble:[self.greeLightDuration.text doubleValue]]
                                ];
    return durationsValue;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSArray *durationsValue = [self getDurationValues];
    
    if([segue.identifier isEqualToString:@"Edit Durations Segue"])
    {
        ViewController *lightsVC = segue.destinationViewController;
        lightsVC.tfDurations = [[TrafficLights alloc]initWithArray:durationsValue];
    }
}


@end
