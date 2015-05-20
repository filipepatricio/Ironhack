//
//  Counter.h
//  Animals
//
//  Created by Filipe Patrício on 12/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kKeyCounter @"counterKey"
@interface Counter : NSObject
@property (assign, nonatomic, readonly) long counter;
-(void)incrementCounter;
+(instancetype)sharedInstance;
@end
