//
//  Person.m
//  TableDemo
//
//  Created by Filipe Patrício on 13/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Person.h"

@implementation Person
-(instancetype)initWithName:(NSString*)name andImageName:(NSString*)imageName
{
    self = [self init];
    if(self)
    {
        self.name = name;
        self.imageName = imageName;
    }
    return self;
}
@end
