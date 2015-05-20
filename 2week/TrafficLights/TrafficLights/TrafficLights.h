//
//  TrafficLights.h
//  TrafficLights
//
//  Created by Filipe Patrício on 11/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrafficLights : NSObject
-(double)durationForIndex:(int)index;
-(instancetype)initWithArray:(NSArray*)arrayOfNumbers;
@end
