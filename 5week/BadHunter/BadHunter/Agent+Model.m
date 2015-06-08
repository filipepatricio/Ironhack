//
//  Agent+Model.m
//  BadHunter
//
//  Created by Filipe Patrício on 04/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Agent+Model.h"

@implementation Agent (Model)

//WITH +(NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key method
//We don't need to use the setters for notification

-(void)setDestructionPower:(NSNumber *)destructionPower
{
    [self willChangeValueForKey:@"destructionPower"];
    [self willChangeValueForKey:@"appraisal"];
    [self setPrimitiveValue:destructionPower forKey:@"destructionPower"];
    [self didChangeValueForKey:@"destructionPower"];
    [self setPrimitiveValue:[self calculateAppraisal] forKey:kKeyAppraisal];
    [self didChangeValueForKey:@"appraisal"];
}

-(void)setMotivation:(NSNumber *)motivation
{
    [self willChangeValueForKey:@"motivation"];
    [self willChangeValueForKey:@"appraisal"];
    [self setPrimitiveValue:motivation forKey:@"motivation"];
    [self didChangeValueForKey:@"motivation"];
    [self setPrimitiveValue:[self calculateAppraisal] forKey:kKeyAppraisal];
    [self didChangeValueForKey:@"appraisal"];

}

- (NSNumber*)calculateAppraisal
{
    NSNumber *appraisal;
    [self willAccessValueForKey:kKeyAppraisal];
    appraisal = [NSNumber numberWithDouble:([self.destructionPower integerValue] + [self.motivation integerValue]) / 2];
    [self didAccessValueForKey:kKeyAppraisal];
    return appraisal;
}

-(NSNumber *)appraisal
{
    NSNumber *appraisal;
    if(!(appraisal = [self primitiveValueForKey:kKeyAppraisal]))
    {
        appraisal = [self calculateAppraisal];
    }
    return appraisal;
}

+(NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSMutableSet *keyPathsSet = [[NSMutableSet alloc]initWithSet:[super keyPathsForValuesAffectingValueForKey:key]];
    if([key isEqualToString:kKeyAppraisal])
    {
        [keyPathsSet addObject:kKeyDestructionPower];
        [keyPathsSet addObject:kKeyMotivation];
    }
    return keyPathsSet;
}

- (NSString *) generatePictureUUID {
    CFUUIDRef     fileUUID;
    CFStringRef   fileUUIDString;
    fileUUID = CFUUIDCreate(kCFAllocatorDefault);
    fileUUIDString = CFUUIDCreateString(kCFAllocatorDefault, fileUUID);
    CFRelease(fileUUID);
    return (__bridge_transfer NSString *)fileUUIDString;
}

#pragma mark Fetch Requests

+(NSFetchRequest*)fetchForAllAgents
{
    return [Agent fetchForAllAgentsWithPredicate:[NSPredicate predicateWithFormat:@"TRUEPREDICATE"]];
}

+(NSFetchRequest*)fetchForAllAgentsWithPredicate:(NSPredicate*)predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Agent"];
    fetchRequest.predicate = predicate;
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    return fetchRequest;
}

+(NSFetchRequest*)fetchForAllAgentsWithSortDescriptors:(NSArray*)sortDescriptors
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Agent"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setSortDescriptors:sortDescriptors];
    return fetchRequest;
}

@end
