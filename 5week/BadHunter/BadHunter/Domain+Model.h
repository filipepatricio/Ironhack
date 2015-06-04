//
//  Domain+Model.h
//  BadHunter
//
//  Created by Filipe Patrício on 04/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Domain.h"

#define kKeyDomainClass @"Domain"
#define kKeyName @"name"

@interface Domain (Model)
-(instancetype)initWithName:(NSString*)name;
+(Domain*)getDomainTypeByName:(NSString*)name inMOC:(NSManagedObjectContext*)moc;
@end