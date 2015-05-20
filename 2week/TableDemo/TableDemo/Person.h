//
//  Person.h
//  TableDemo
//
//  Created by Filipe Patrício on 13/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageName;
-(instancetype)initWithName:(NSString*)name andImageName:(NSString*)imageName;
@end
