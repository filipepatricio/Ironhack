//
//  Domain+Model.m
//  BadHunter
//
//  Created by Filipe Patrício on 04/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Domain+Model.h"

@implementation Domain (Model)
-(instancetype)initWithName:(NSString*)name
{
    if(self = [self init])
    {
        self.name = name;
    }
    return self;
}

+(Domain*)getDomainTypeByName:(NSString*)name inMOC:(NSManagedObjectContext*)moc
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kKeyDomainClass];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", kKeyName, name];
    
    return [[moc executeFetchRequest:fetchRequest error:nil] firstObject];
}
@end
