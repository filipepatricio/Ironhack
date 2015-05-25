//
//  PersistenceManager.h
//  Copying
//
//  Created by Filipe Patrício on 25/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistenceManager : NSObject
+(NSString *)pathForFileWithClass:(Class)aclass;
+(void)copyObjectFromArray:(NSMutableArray *)array index:(NSInteger)index;
@end
