//
//  UIAlertView+Blocks.m
//  Models
//
//  Created by Filipe Patrício on 02/06/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

static const char kAlertBlockKey;

@implementation UIAlertView (Blocks)

-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message blockToDo:(AlertBlock)alertBlock  cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    
    if(self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil])
    {
        self.alertBlock = alertBlock;
    }
    
    return self;
}

-(AlertBlock)alertBlock
{
    return objc_getAssociatedObject(self, &kAlertBlockKey);
}

-(void)setAlertBlock:(AlertBlock)alertBlock
{
    objc_setAssociatedObject(self, &kAlertBlockKey, alertBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.alertBlock)
        self.alertBlock(buttonIndex);
}

@end
