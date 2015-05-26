//
//  TVShow+Manager.m
//  CoreDataProject
//
//  Created by Filipe Patrício on 26/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "TVShow+Manager.h"
#import "TVShowsCoreDataManager.h"
#import <CoreData/CoreData.h>

@implementation TVShow (Manager)

//CRUD (Create Read Update Delete)

+(TVShow*)createTVShowWithTitle:(NSString *)title numberOfSeasons:(NSInteger)numberOfSeasons
{
    NSManagedObjectContext *moc = [TVShowsCoreDataManager sharedCoreDataManager].managedObjectContext;
    TVShow *show = [NSEntityDescription insertNewObjectForEntityForName:@"TVShow" inManagedObjectContext:moc];
    show.title = title;
    show.numberOfSeasons = [NSNumber numberWithLong:numberOfSeasons] ;
    [moc save:nil];
    return show;
}

+(TVShow*)getTVShowWithTitle:(NSString *)title
{
    TVShow *show = nil;
    
    NSManagedObjectContext *moc = [TVShowsCoreDataManager sharedCoreDataManager].managedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TVShow"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"title = %@", title];
    NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
    
    if(results.count)
        show = [results firstObject];
    
    return show;
}


+(NSArray*)getAllTVShows
{
    
    NSManagedObjectContext *moc = [TVShowsCoreDataManager sharedCoreDataManager].managedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TVShow"];
    fetchRequest.predicate = [NSPredicate predicateWithValue:YES];
    NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
    
    return results;
}

@end
