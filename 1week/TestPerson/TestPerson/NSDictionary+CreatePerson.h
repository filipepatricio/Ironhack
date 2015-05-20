//
//  NSDictionary+CreatePerson.h
//  TestPerson
//
//  Created by Filipe Patrício on 05/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Images.h"

@interface NSDictionary (CreatePerson)
-(Person *)convertToPerson;
-(Images *)convertToImages;
@end
