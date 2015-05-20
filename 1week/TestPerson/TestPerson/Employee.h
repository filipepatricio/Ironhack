//
//  Employee.h
//  TestPerson
//
//  Created by Filipe Patrício on 04/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Person.h"

@interface Employee : Person
@property (nonatomic, strong) NSString* employeeID;
-(instancetype)initWithName:(NSString*)name
                 andSurname:(NSString*)surname
                      andID:(NSString*)ID
              andEmployeeID:(NSString*)employeeID ;
@end
