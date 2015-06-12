//
//  ViewController.m
//  CoreLocationAndMapKit
//
//  Created by Filipe Patrício on 11/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *lngLabel;
@property (weak, nonatomic) IBOutlet UILabel *altLabel;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    if([CLLocationManager locationServicesEnabled])
    {
        if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [self.locationManager requestWhenInUseAuthorization];
            //Add to Info.plist: NSLocationWhenInUseUsageDescription
        }
            
        self.locationManager.delegate = self;
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager startUpdatingLocation];
        
        if([CLLocationManager headingAvailable])
            [self.locationManager startUpdatingHeading];
            

    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.locationManager stopUpdatingHeading];
    [self.locationManager stopUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations.lastObject;
    
    self.latLabel.text = [NSString stringWithFormat:@"%.2f", location.coordinate.latitude];
    self.lngLabel.text = [NSString stringWithFormat:@"%.2f", location.coordinate.longitude];
    self.altLabel.text = [NSString stringWithFormat:@"%.2f", location.altitude];
    
     // Calculate distance [location distanceFromLocation:<#(const CLLocation *)#>];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    self.headingLabel.text = [NSString stringWithFormat:@"%.2f", newHeading.magneticHeading];
    
    [UIView animateWithDuration:0.01 animations:^{
        self.arrowImage.transform = CGAffineTransformMakeRotation( -newHeading.trueHeading* M_PI/180);
    }];
    

    
    
}



@end
