//
//  Agent.h
//  BadHunter
//
//  Created by Filipe Patrício on 04/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FreakType, NSManagedObject;

@interface Agent : NSManagedObject

@property (nonatomic, retain) NSNumber * appraisal;
@property (nonatomic, retain) NSNumber * destructionPower;
@property (nonatomic, retain) NSNumber * motivation;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * pictureUUID;
@property (nonatomic, retain) FreakType *category;
@property (nonatomic, retain) NSSet *domains;
@end

@interface Agent (CoreDataGeneratedAccessors)

- (void)addDomainsObject:(NSManagedObject *)value;
- (void)removeDomainsObject:(NSManagedObject *)value;
- (void)addDomains:(NSSet *)values;
- (void)removeDomains:(NSSet *)values;

@end
