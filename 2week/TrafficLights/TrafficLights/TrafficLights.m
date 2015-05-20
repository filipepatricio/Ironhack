//
//  TrafficLights.m
//  TrafficLights
//
//  Created by Filipe Patrício on 11/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "TrafficLights.h"

@interface TrafficLights ()
@property (nonatomic, strong)NSArray *durations;
@end

@implementation TrafficLights


-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.durations = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TrafficLights" ofType:@"plist"]];
    }
    return self;
}

-(instancetype)initWithArray:(NSArray*)arrayOfNumbers
{
    self = [super init];
    if(self)
    {
        self.durations = [NSArray arrayWithArray:arrayOfNumbers];
    }
    return self;
}

-(double)durationForIndex:(int)index
{
    return [(NSNumber*)self.durations[index] doubleValue];
}

@end
