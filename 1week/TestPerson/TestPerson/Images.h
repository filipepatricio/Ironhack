//
//  Images.h
//  TestPerson
//
//  Created by Filipe Patrício on 06/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Images : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *title;
-(instancetype)initWithName:(NSString*)name andTitle:(NSString*)title;
@end
