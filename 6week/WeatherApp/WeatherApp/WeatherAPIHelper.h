//
//  WeatherAPIHelper.h
//  WeatherApp
//
//  Created by Filipe Patrício on 08/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherAPIHelper : NSObject

//-(void)downloadCurrentForecast;

-(void)currentDayForecastWithCompletionBlock:(void (^)(NSData *resultData))completionBlock;
-(void)weekForecastWithCompletionBlock:(void (^)(NSData *resultData))completionBlock;

@end
