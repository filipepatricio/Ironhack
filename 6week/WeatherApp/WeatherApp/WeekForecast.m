//
//  WeekForecast.m
//  WeatherApp
//
//  Created by Filipe Patrício on 08/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "WeekForecast.h"
#import "ForecastCell.h"
#import "WeatherAPIHelper.h"
#import "ForecastParserHelper.h"
#import "ImageDownloader.h"
#import "Reachability.h"

@interface WeekForecast ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *weekForecast; //Of ForecastModel
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation WeekForecast

- (void)getForecast
{
    //TODO: Reachibility check
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    if([reachability currentReachabilityStatus] == ReachableViaWiFi || [reachability currentReachabilityStatus] == ReachableViaWWAN)
    {
        WeatherAPIHelper *helper = [[WeatherAPIHelper alloc] init];
        __weak typeof(self) weakSelf = self;
        [self.activityIndicator startAnimating];
        [helper weekForecastWithCompletionBlock:^(NSData *resultData) {
            typeof(self) strongSelf = weakSelf;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                ForecastParserHelper *parserHelper = [[ForecastParserHelper alloc] init];
                strongSelf.weekForecast = [parserHelper weekForecastWithData:resultData];
                [strongSelf.tableView reloadData];
                [strongSelf.activityIndicator stopAnimating];
            });
        }];
    }
}

-(void)viewDidLoad
{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60*3 target:self selector:@selector(getForecast) userInfo:nil repeats:YES];
    
    [self.timer fire];
    
    [self getForecast];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastCell"];
    
    ForecastModel *forecast = self.weekForecast[indexPath.row];
    
    [ImageDownloader imageWithURL:forecast.iconURL completionBlock:^(UIImage *image) {
        cell.forecastImageView.image = image;
    }];
    cell.maxTempLabel.text = [NSString stringWithFormat:@"%0.f ºC", forecast.maxTemp ];
    cell.minTempLabel.text = [NSString stringWithFormat:@"%0.f ºC", forecast.minTemp ];
    
    
    cell.dayOfWeekLabel.text = [self dayOfWeekAccordingTheDay:indexPath.row];
    
    return cell;
}

-(NSString *)dayOfWeekAccordingTheDay:(NSInteger)day;
{
    NSDateComponents* deltaComps = [[NSDateComponents alloc] init];
    [deltaComps setDay:day];
    NSDate* nextDay = [[NSCalendar currentCalendar] dateByAddingComponents:deltaComps toDate:[NSDate date] options:0];
    
    NSDateFormatter* theDateFormatter = [[NSDateFormatter alloc] init];
    [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [theDateFormatter setDateFormat:@"EEEE"];
    NSString *weekDay =  [theDateFormatter stringFromDate:nextDay];
    return weekDay;
}

@end
