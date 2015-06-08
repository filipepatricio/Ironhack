//
//  ForecastModel.h
//  WeatherApp
//
//  Created by Filipe Patrício on 08/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastModel : NSObject

@property(assign, nonatomic) float temp;
@property(assign, nonatomic) float minTemp;
@property(assign, nonatomic) float maxTemp;
@property(assign, nonatomic) float pressure;
@property(assign, nonatomic) float humidity;
@property(copy, nonatomic) NSString *cityName;
@property(copy, nonatomic) NSString *weatherDescription;
@property(copy, nonatomic) NSString *iconURL;

@end
