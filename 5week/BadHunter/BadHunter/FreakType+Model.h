//
//  FreakType+Model.h
//  BadHunter
//
//  Created by Filipe Patrício on 04/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "FreakType.h"

#define kKeyFreakyClass @"FreakType"
#define kKeyName @"name"

@interface FreakType (Model)
+ (instancetype)addNewFreakTypeWithName:(NSString*)name inMOC:(NSManagedObjectContext*)moc;
+(FreakType*)getFreakTypeByName:(NSString*)name inMOC:(NSManagedObjectContext*)moc;
@end
