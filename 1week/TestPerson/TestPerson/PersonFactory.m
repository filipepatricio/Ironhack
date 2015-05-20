//
//  PersonFactory.m
//  TestPerson
//
//  Created by Filipe Patrício on 05/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "PersonFactory.h"

@implementation PersonFactory

+(Person *)createPersonWithName:(NSString *)name
                        surname:(NSString*)surname
                       idNumber:(NSString*)idNumber
{
    return [[Person alloc] initWithName:name andSurname:surname andID:idNumber];
}

+(Employee *)createEmployeeWithName:(NSString *)name
                            surname:(NSString*)surname
                           idNumber:(NSString*)idNumber
                         employeeId:(NSString*)employeeId
{
    return [[Employee alloc] initWithName:name andSurname:surname andID:idNumber andEmployeeID:employeeId];
}

+(NSString*)interestingIdForPersonOrEmployee:(id)personOrEmployee
{
    if([personOrEmployee isMemberOfClass:[Person class]])
        return ((Person*)personOrEmployee).ID;
    else if([personOrEmployee isMemberOfClass:[Employee class]])
        return ((Employee*)personOrEmployee).employeeID;
    else
        return nil;
    
}

@end
