//
//  Images.m
//  TestPerson
//
//  Created by Filipe Patrício on 06/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Images.h"

@implementation Images
-(instancetype)initWithName:(NSString*)name andTitle:(NSString*)title
{
    if(self = [super init])
    {
        self.name = name;
        self.title = title;
    }
    return self;
}
@end
