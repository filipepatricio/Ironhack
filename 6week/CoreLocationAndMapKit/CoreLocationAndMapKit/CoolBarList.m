//
//  CoolBarList.m
//  CoreLocationAndMapKit
//
//  Created by Filipe Patrício on 11/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "CoolBarList.h"
#import "CoolBar.h"

@implementation CoolBarList

+(NSArray*)allCoolBarsFromPList
{
    NSArray *coolBarsFromFile = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CoolBarList" ofType:@"plist"]];
    
    NSMutableArray *barArray = [[NSMutableArray alloc] initWithCapacity:coolBarsFromFile.count];
    for(NSDictionary *barDict in coolBarsFromFile)
    {
        CoolBar *bar = [[CoolBar alloc] init];
        bar.name = barDict[@"name"];
        bar.type = [barDict[@"type"] integerValue];
        bar.coordinate = CLLocationCoordinate2DMake([barDict[@"latitude"] floatValue], [barDict[@"longitude"] floatValue]) ;
        [barArray addObject:bar];
    }
    
    return [barArray copy];
}

@end
