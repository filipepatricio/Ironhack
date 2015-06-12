//
//  CoolBar.h
//  CoreLocationAndMapKit
//
//  Created by Filipe Patrício on 11/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

typedef enum : NSUInteger {
    classic_bar     = 0,
    tapas_bar       = 1,
    piano_bar       = 2,
    disco           = 3,
} BAR_TYPE;


@interface CoolBar : NSObject <MKAnnotation>

@property (assign, nonatomic) BAR_TYPE type;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end
