//
//  Domain.h
//  BadHunter
//
//  Created by Filipe Patrício on 04/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agent;

@interface Domain : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Agent *agents;

@end
