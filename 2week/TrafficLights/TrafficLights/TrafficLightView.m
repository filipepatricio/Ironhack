//
//  TrafficLightView.m
//  TrafficLights
//
//  Created by Filipe Patrício on 11/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "TrafficLightView.h"

@implementation TrafficLightView


-(void)awakeFromNib
{
    //self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.layer.frame.size.width / 2;
    self.layer.borderWidth = 5;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowColor = self.backgroundColor.CGColor;
    self.layer.shadowRadius = 10;
    self.layer.shadowOffset =CGSizeMake(10, 10);
}


@end
