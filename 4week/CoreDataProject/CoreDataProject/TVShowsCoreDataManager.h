//
//  TVShowsCoreDataManager.h
//  CoreDataProject
//
//  Created by Filipe Patrício on 26/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataStack.h"

@interface TVShowsCoreDataManager : ViewController
+(CoreDataStack *)sharedCoreDataManager;
@end
