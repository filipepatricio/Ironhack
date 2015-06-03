//
//  MasterViewController.h
//  BadHunter
//
//  Created by Filipe Patrício on 03/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class AgentEditViewController;

@interface AgentsViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) AgentEditViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

