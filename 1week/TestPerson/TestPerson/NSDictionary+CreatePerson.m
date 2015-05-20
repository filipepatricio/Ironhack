//
//  NSDictionary+CreatePerson.m
//  TestPerson
//
//  Created by Filipe Patrício on 05/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "NSDictionary+CreatePerson.h"
#import "Constants.h"

@implementation NSDictionary (CreatePerson)

-(Person *)convertToPerson
{
    return [[Person alloc]initWithName:self[kKeyForName]
                                 andSurname:self[kKeyForSurname]
                                      andID:self[kKeyForID]];
}

-(Images *)convertToImages
{
    return [[Images alloc]initWithName:self[@"name"]
                              andTitle:self[@"title"]];
}

@end
