//
//  UIAlertView+Blocks.h
//  Models
//
//  Created by Filipe Patrício on 02/06/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertBlock)(NSInteger buttonIndex);

@interface UIAlertView (Blocks)<UIAlertViewDelegate>

@property (copy, nonatomic) AlertBlock alertBlock;

-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message blockToDo:(AlertBlock)alertBlock  cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;


@end
