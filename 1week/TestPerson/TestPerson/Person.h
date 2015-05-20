//
//  Person.h
//  TestPerson
//
//  Created by Filipe Patrício on 04/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChangeNameDelegate.h"

@interface Person : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *surname;
@property (nonatomic) NSString *ID;
@property (nonatomic, weak) id<ChangeNameDelegate> delegate;
@property (nonatomic, weak, readonly) UIImage *image;

-(instancetype)initWithName:(NSString*)name;
-(instancetype)initWithName:(NSString*)name andSurname:(NSString*)surname andID:(NSString*)ID;

-(void)printDescription;
+(void)changeToUpperCase:(Person *)p;

@end
