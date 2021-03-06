//
//  FreakType+Model.m
//  BadHunter
//
//  Created by Filipe Patrício on 04/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "FreakType+Model.h"



@implementation FreakType (Model)

+ (instancetype)addNewFreakTypeWithName:(NSString*)name inMOC:(NSManagedObjectContext*)moc
{
    FreakType *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:kKeyFreakyClass inManagedObjectContext:moc];
    newManagedObject.name = name;
    return newManagedObject;
}


+(FreakType*)getFreakTypeByName:(NSString*)name inMOC:(NSManagedObjectContext*)moc
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kKeyFreakyClass];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", kKeyName, name];
    return [[moc executeFetchRequest:fetchRequest error:nil] firstObject];
}

@end
