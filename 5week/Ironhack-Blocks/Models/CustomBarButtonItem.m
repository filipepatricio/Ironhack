//
//  CustomBarButtonItem.m
//  Models
//
//  Created by Filipe Patrício on 02/06/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

#import "CustomBarButtonItem.h"

@interface CustomBarButtonItem ()
@property (copy, nonatomic) ActionBlock actionBlock;
@end

@implementation CustomBarButtonItem

-(instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlock:(ActionBlock)block
{
 
    if(self = [self initWithTitle:title style:style target:self action:@selector(buttonAction)])
    {
        self.actionBlock = block;
    }
    return self;
}

-(void)buttonAction
{
    self.actionBlock();
}

@end
