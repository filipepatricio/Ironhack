//
//  PersonFactory.h
//  TestPerson
//
//  Created by Filipe Patrício on 05/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Employee.h"

@interface PersonFactory : NSObject

+(Person *)createPersonWithName:(NSString *)name
                        surname:(NSString*)surname
                       idNumber:(NSString*)idNumber;

+(Employee *)createEmployeeWithName:(NSString *)name
                        surname:(NSString*)surname
                       idNumber:(NSString*)idNumber
                       employeeId:(NSString*)employeeId;

+(NSString*)interestingIdForPersonOrEmployee:(id)personOrEmployee;

@end
