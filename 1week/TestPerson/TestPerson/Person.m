//
//  Person.m
//  TestPerson
//
//  Created by Filipe Patrício on 04/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Person.h"

@interface Person ()
@property (nonatomic, strong)UIImage *image;
@end

@implementation Person

-(UIImage *)image
{
    if(!self.image)
        self.image = [UIImage imageNamed:@"default"];
    return self.image;
}

-(instancetype)initWithName:(NSString*)name
{
    return [self initWithName:name andSurname:nil andID:nil];
}

-(instancetype)initWithName:(NSString*)name andSurname:(NSString*)surname andID:(NSString*)ID
{
    if(self = [super init])
    {
        self.name = name;
        self.surname = surname;
        self.ID = ID;
    }
    return self;
}

-(void)setName:(NSString *)name
{
    _name = name;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didChangeName:)])
        [self.delegate didChangeName:name];
}


-(void)printDescription
{
    NSLog(@"\nName: %@ \nSurname: %@ \nID: %@", self.name, self.surname, self.ID);
}

+(void)changeToUpperCase:(Person *)p
{
    p.name = [p.name uppercaseString];
    p.surname = [p.surname uppercaseString];
}

-(NSString*)debugDescription
{
    NSString *description = [NSString stringWithFormat: @"\nDebugDescription: \nName: %@ \nSurname: %@ \nID: %@", self.name, self.surname, self.ID ];
    return description;
}

@end
