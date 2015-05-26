//
//  TVShowsCoreDataManager.m
//  CoreDataProject
//
//  Created by Filipe Patrício on 26/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "TVShowsCoreDataManager.h"

@implementation TVShowsCoreDataManager
+(CoreDataStack *)sharedCoreDataManager
{
    static CoreDataStack *_sharedCoreDataManager;
    if(!_sharedCoreDataManager)
    {
        _sharedCoreDataManager = [[CoreDataStack alloc] initWithModelName:@"TVShows"];
    }
    return _sharedCoreDataManager;
}
@end
