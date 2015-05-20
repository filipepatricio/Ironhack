//
//  Employee.m
//  TestPerson
//
//  Created by Filipe Patrício on 04/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Employee.h"

@implementation Employee
-(instancetype)initWithName:(NSString *)name
                 andSurname:(NSString *)surname
                      andID:(NSString *)ID
              andEmployeeID:(NSString *)employeeID
{
    if(self = [super initWithName:name andSurname:surname andID:ID])
    {
        self.employeeID = employeeID;
    }
    return self;
}

-(void)printEmployeeDescription
{
    [super printDescription];
    NSLog(@"\nEmployeeID: %@", self.employeeID);
}

@end
