//
//  ViewController.m
//  CoreDataProject
//
//  Created by Filipe Patrício on 26/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataStack.h"
#import "TVShowsCoreDataManager.h"
#import "TVShow.h"
#import "TVShow+Manager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberOfSeasonsTextField;
@property (strong, nonatomic) CoreDataStack *coreDataStack;
@property (weak, nonatomic) IBOutlet UITextField *searchTitleTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfSeasonsLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.coreDataStack = [TVShowsCoreDataManager sharedCoreDataManager];

#warning This won't work because we need to ask to managed object context to give us an object! :
//    TVShow *show = [[TVShow alloc] init];
//    show.title = @"Game of Thrones";
    
    //Like this:
    TVShow *show = [NSEntityDescription insertNewObjectForEntityForName:@"TVShow" inManagedObjectContext:self.coreDataStack.managedObjectContext];
    show.title = @"Game of Thrones";
    show.numberOfSeasons = @2;
    [self.coreDataStack.managedObjectContext save:nil];
    
}

- (IBAction)actionAddTvShow:(id)sender
{
    [TVShow createTVShowWithTitle:self.titleTextField.text numberOfSeasons:[self.numberOfSeasonsTextField.text integerValue]];
}

- (IBAction)actionSearchForTVShow:(id)sender
{
    TVShow *resultShow = [TVShow findTVShowWithTitle:self.searchTitleTextField.text];
    self.titleLabel.text = resultShow.title;
    self.numberOfSeasonsLabel.text = [NSString stringWithFormat: @"%@", resultShow.numberOfSeasons];
}

@end
