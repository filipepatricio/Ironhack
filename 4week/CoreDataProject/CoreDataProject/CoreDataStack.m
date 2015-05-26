//
//  CoreDataStack.m
//  CoreDataProject
//
//  Created by Filipe Patrício on 26/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack ()

// Create singleton! SharedInstance to use on all classes

@property (strong, nonatomic, readwrite) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readwrite) NSPersistentStoreCoordinator *persistenceStoreCoordinator;
@property (strong, nonatomic, readwrite) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic, readwrite) NSString *modelName;
@end

@implementation CoreDataStack


-(instancetype)initWithModelName:(NSString *)modelName
{
    self = [self init];
    if(self)
    {
        self.modelName = modelName;
    }
    return self;
}

#pragma mark Setup CoreData Connections

-(NSManagedObjectContext*)managedObjectContext
{
    if(!_managedObjectContext)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        
        //Connect Managed Object Context with Persistent Store Coordinator
        _managedObjectContext.persistentStoreCoordinator = self.persistenceStoreCoordinator;
    }
    return _managedObjectContext;
}

-(NSPersistentStoreCoordinator *)persistenceStoreCoordinator
{
    if(!_persistenceStoreCoordinator)
    {
        //Connect Persistent Store Coordinator with Manage Object Context
        _persistenceStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        
        //Connect Persistent Store Coordinator with Persistent Object Store and with the real Database
        NSError *error = nil;
        [_persistenceStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:nil error:&error];
        
        if(error)
        {
            //Something has failed. Maybe there's no space on the device.
            //We don't know how to deal with the error, close the app and
            //pray that the next time would work
            abort();
        }
    }
    return _persistenceStoreCoordinator;
}

-(NSManagedObjectModel *)managedObjectModel
{
    if(!_managedObjectModel)
    {
        //Connect Managed Object Model to DataModel
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[self dataModelURL]];
    }
    return _managedObjectModel;
}


#pragma mark GetUrls

-(NSURL*)storeURL
{
    NSString *sqlLiteFileName = @"TVShows.sqlite";
    return [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:sqlLiteFileName];
}

-(NSURL*)dataModelURL
{
    return [[NSBundle mainBundle] URLForResource:self.modelName withExtension:@"momd"];
}

@end
