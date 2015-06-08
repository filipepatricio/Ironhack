//
//  WeatherAPIHelper.m
//  WeatherApp
//
//  Created by Filipe Patrício on 08/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "WeatherAPIHelper.h"

@implementation WeatherAPIHelper

- (void)executeURLSessionWithCompletionBlock:(void (^)(NSData *))completionBlock weatherURLString:(NSString *)weatherURLString
{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:weatherURLString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                if(HTTPResponse.statusCode == 200)
                {
                    if(!error)
                    {
                        completionBlock(data);
                    }
                    else
                    {
                        NSLog(@"%@", error);
                    }
                }
                
            }] resume ];
}

//-(void)downloadCurrentForecast
//{
//    NSString *weatherURLString = @"http://api.openweathermap.org/data/2.5/weather?q=Barcelona,es";
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session dataTaskWithURL:[NSURL URLWithString:weatherURLString]
//            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                
//                NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
//                if(HTTPResponse.statusCode == 200)
//                {
//                    if(!error)
//                    {
//                        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                        NSLog(@"%@", json);
//                    }
//                    else
//                    {
//                        NSLog(@"%@", error);
//                    }
//                }
//                
//            }] resume ];
//}

-(void)currentDayForecastWithCompletionBlock:(void (^)(NSData *resultData))completionBlock
{
    NSString *weatherURLString = @"http://api.openweathermap.org/data/2.5/weather?q=Barcelona,es&units=metric";
    [self executeURLSessionWithCompletionBlock:completionBlock weatherURLString:weatherURLString];
}

-(void)weekForecastWithCompletionBlock:(void (^)(NSData *resultData))completionBlock
{
    NSString *forecastURLString = @"http://api.openweathermap.org/data/2.5/forecast?q=Barcelona,es&units=metric&cnt=5";
    [self executeURLSessionWithCompletionBlock:completionBlock weatherURLString:forecastURLString];
}


@end
