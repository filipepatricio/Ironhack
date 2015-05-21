//
//  ViewController.m
//  shakeTextFieldCocoaPods
//
//  Created by Filipe Patrício on 21/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import <UITextField+Shake/UITextField+Shake.h>
#import <JSONModel/JSONModelLib.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can    be recreated.
}
- (IBAction)actionLogin:(id)sender
{
    if(![self.passwordTextField.text isEqualToString:@"ironhack"])
    {
        [self.passwordTextField shake];
        self.passwordTextField.backgroundColor = [UIColor clearColor];
    }
    else
    {
        self.passwordTextField.backgroundColor = [UIColor greenColor];
    }
    
}

- (IBAction)actionGetWeather:(id)sender
{
    NSString *url = [NSString stringWithFormat:
                        @"http://api.openweathermap.org/data/2.5/weather?q=%@",
                        [self.cityTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                     ];
    
    [JSONHTTPClient getJSONFromURLWithString:url completion:^(id json, JSONModelError *err) {
        NSLog(@"data: %@", json);
        NSDictionary *response = json;
        self.descriptionLabel.text = response[@"weather"][0][@"main"];
        
        NSNumber *degrees = response[@"main"][@"temp"];
        double celsiusDegrees = [degrees doubleValue] - 273;
        
        self.temperatureLabel.text = [NSString stringWithFormat:@"%.2f ºC", celsiusDegrees ];
        
        
    }];
}



@end
