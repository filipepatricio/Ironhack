 //
//  ViewController.m
//  SensorsApp
//
//  Created by Filipe Patrício on 10/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import "DeviceHardwareHelper.h"
#import "SoundHelper.h"

@interface ViewController ()
@property (strong, nonatomic) DeviceHardwareHelper *deviceHardwareHelper;
@property (weak, nonatomic) IBOutlet UILabel *batteryLevelLabel;
@property (strong, nonatomic) SoundHelper *sound;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.deviceHardwareHelper = [[DeviceHardwareHelper alloc] init];
    self.sound = [[SoundHelper alloc] init];
    
    self.batteryLevelLabel.text = [DeviceHardwareHelper batteryLevel];
    
    self.batteryLevelLabel.font = [UIFont fontWithName:@"Doctor Soos Bold" size:36];
    
    __weak typeof(self) weakSelf = self;
    [self.deviceHardwareHelper onProximityEventApproachDoThis:^{
        [weakSelf.sound play:@"Glass Up"];
    }];
    
    [self.deviceHardwareHelper onProximityEventLeavingDoThis:^{
        [weakSelf.sound play:@"Glass Down"];
    }];
    
    [self listFonts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)listFonts
{
    for(NSString *family in [UIFont familyNames])
    {
        NSLog(@"%@",family);
        for(NSString *name in [UIFont fontNamesForFamilyName:family])
            NSLog(@"%@",name);
    }
}

@end
