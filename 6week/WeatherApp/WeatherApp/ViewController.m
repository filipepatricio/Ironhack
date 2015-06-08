//
//  ViewController.m
//  WeatherApp
//
//  Created by Filipe Patrício on 08/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import "WeatherAPIHelper.h"
#import "ForecastParserHelper.h"
#import "ImageDownloader.h"

@interface ViewController ()<NSURLSessionDelegate>
@property (strong, nonatomic) ForecastModel *forecast;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *actualTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self downloadWeather];
//    [self downloadWeatherWithDelegate];
//    [self sendInformationToTheServer];
    
    [self downloadCurrentForecast];
    
}

-(void)downloadCurrentForecast
{
    [self.activityIndicator startAnimating];
    __weak typeof(self) weakSelf = self;
    WeatherAPIHelper *wh = [[WeatherAPIHelper alloc] init];
    [wh currentDayForecastWithCompletionBlock:^(NSData *resultData) {
        typeof(self) strongSelf = weakSelf;
        
     //Create a Forecast Parser
        ForecastParserHelper *parser = [[ForecastParserHelper alloc] init];
        strongSelf.forecast = [parser todayForecastWithData:resultData];
        
     //Pass to it the NSData received from the WeatherAPI Helper
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf updateUI];
            [self.activityIndicator stopAnimating];
        });

        
     //Update the UI
     //Maybe a few nice things to have: i.e.: activity indicator
       
    }];
}

-(void)updateUI
{
    self.cityNameLabel.text = [self.cityNameLabel.text stringByAppendingString:self.forecast.cityName];
    
    self.actualTemperatureLabel.text = [self.actualTemperatureLabel.text stringByAppendingString: [NSString stringWithFormat:@"%.0f ºC", self.forecast.temp ]];
    self.maxTempLabel.text = [self.maxTempLabel.text stringByAppendingString: [NSString stringWithFormat:@"%.0f ºC", self.forecast.maxTemp ]];
    self.minTempLabel.text = [self.minTempLabel.text stringByAppendingString: [NSString stringWithFormat:@"%.0f ºC", self.forecast.minTemp ]];
    self.humidityLabel.text = [self.humidityLabel.text stringByAppendingString: [NSString stringWithFormat:@"%.0f %%", self.forecast.humidity ]];
    self.pressureLabel.text = [self.pressureLabel.text stringByAppendingString: [NSString stringWithFormat:@"%.0f", self.forecast.pressure ]];
    self.descriptionLabel.text = [self.descriptionLabel.text stringByAppendingString: self.forecast.weatherDescription];
    [ImageDownloader imageWithURL:self.forecast.iconURL
                  completionBlock:^(UIImage *image) {
                     self.iconImageView.image = image;
                 }];
    
}


//-(void)downloadWeatherWithBlock
//{
//    NSString *weatherURLString = @"http://api.openweathermap.org/data/2.5/weather?q=Barcelona,es";
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session dataTaskWithURL:[NSURL URLWithString:weatherURLString]
//            completionHandler:^(NSData *serverData, NSURLResponse *response, NSError *error) {
//        NSLog(@"DATA:\n%@\nEND DATA\n", [[NSString alloc] initWithData:serverData
//                                                              encoding:NSUTF8StringEncoding]);
//    }] resume ];
//}
//
//-(void)downloadWeatherWithDelegate
//{
//    NSURLSessionConfiguration *sessionConf = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConf
//                                                          delegate:self
//                                                     delegateQueue:nil];
//    
//    NSURL *url = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?q=Barcelona,es"];
//    NSURLSessionTask *task = [session dataTaskWithURL:url];
//    [task resume];
//    
//}
//
//
//-(void)sendInformationToTheServer
//{
//    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
//                                                        delegate:self
//                                                   delegateQueue:nil];
//    
//    NSURL *url = [NSURL URLWithString:@"http://posttestserver.com/post.php"];
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
//    urlRequest.HTTPMethod = @"POST";
//    
//    NSString *params = @"&name=Filipe&loc=Barcelona&age=24";
//    urlRequest.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
//    
//    [dataTask resume];
//}
//
//#pragma mark NSURLSession 
//
//
//
//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
//    didReceiveData:(NSData *)data
//{
//    NSLog(@"DATA:\n%@\nEND DATA\n", [[NSString alloc] initWithData:data
//                                                          encoding:NSUTF8StringEncoding]);
//}
//
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
//didCompleteWithError:(NSError *)error
//{
//    if(error)
//    {
//        NSLog(@"Something went wrong");
//    }else{
//        NSLog(@"Succeded");
//    }
//        
//}


@end
