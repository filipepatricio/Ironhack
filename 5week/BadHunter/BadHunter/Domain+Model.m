//
//  Domain+Model.m
//  BadHunter
//
//  Created by Filipe Patrício on 04/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Domain+Model.h"

@implementation Domain (Model)
+ (instancetype)addNewDomainWithName:(NSString*)name inMOC:(NSManagedObjectContext*)moc
{
    Domain *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:kKeyDomainClass inManagedObjectContext:moc];
    newManagedObject.name = name;
    return newManagedObject;
}

+(Domain*)getDomainByName:(NSString*)name inMOC:(NSManagedObjectContext*)moc
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kKeyDomainClass];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", kKeyName, name];
    return [[moc executeFetchRequest:fetchRequest error:nil] firstObject];
}

+(NSInteger)getNumberOfDomainsWithMoreThanOneAgentWithMoreThan3OfDestructionPowerWithMOC:(NSManagedObjectContext*)moc
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Domain"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(agents, $agent, $agent.destructionPower >= 3).@count >= 1)"];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]];
    
    return [moc executeFetchRequest:fetchRequest error:nil].count;
}
@end
