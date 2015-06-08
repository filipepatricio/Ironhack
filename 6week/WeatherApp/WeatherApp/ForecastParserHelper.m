//
//  ForecastParserHelper.m
//  WeatherApp
//
//  Created by Filipe Patrício on 08/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ForecastParserHelper.h"

@implementation ForecastParserHelper
- (ForecastModel *)forecastModelFromDictionary:(NSDictionary *)singleDayJsonDictionary
{
    ForecastModel *newForecastModel = [[ForecastModel alloc] init];
    newForecastModel.cityName = singleDayJsonDictionary[@"name"];
    newForecastModel.temp = [singleDayJsonDictionary[@"main"][@"temp"] floatValue];
    newForecastModel.minTemp = [singleDayJsonDictionary[@"main"][@"temp_min"] floatValue];
    newForecastModel.maxTemp = [singleDayJsonDictionary[@"main"][@"temp_max"] floatValue];
    newForecastModel.pressure = [singleDayJsonDictionary[@"main"][@"pressure"] floatValue];
    newForecastModel.humidity = [singleDayJsonDictionary[@"main"][@"humidity"] floatValue];
    newForecastModel.weatherDescription= [singleDayJsonDictionary[@"weather"] firstObject][@"description"];
    newForecastModel.iconURL= [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", [singleDayJsonDictionary[@"weather"] firstObject][@"icon"]];
    return newForecastModel;
}

-(ForecastModel *)todayForecastWithData:(NSData *)forecastData
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:forecastData options:kNilOptions error:&error];
    NSLog(@"%@", json);
    
    ForecastModel *newForecastModel;
    newForecastModel = [self forecastModelFromDictionary:json];
    
    return newForecastModel;
}

-(NSArray*)weekForecastWithData:(NSData*)weekForecastData
{
    NSMutableArray *forecastArray = [NSMutableArray array]; //Of ForecastModel
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:weekForecastData options:kNilOptions error:&error];
    NSLog(@"%@", json);
    
    for(NSDictionary *dayForecastDict in json[@"list"])
    {
        [forecastArray addObject:[self forecastModelFromDictionary:dayForecastDict]];
    }
    
    return [forecastArray copy];
}

@end
