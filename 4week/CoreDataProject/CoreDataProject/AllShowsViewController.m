//
//  AllShowsViewController.m
//  CoreDataProject
//
//  Created by Filipe Patrício on 26/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "AllShowsViewController.h"
#import "TVShow+Manager.h"
#import "DetailTVShowViewController.h"

@interface AllShowsViewController()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *tvShows; //Of TVShow
@end

@implementation AllShowsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshDidChange:) forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tvShows = [TVShow getAllTVShows];
    [self.tableView reloadData];
}

- (IBAction)actionEdit:(id)sender
{
    self.tableView.editing = !self.tableView.editing;
}

-(void)refreshDidChange:(id)sender
{
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tvShows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    TVShow *show = self.tvShows[indexPath.row];
    cell.textLabel.text = show.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Number of seasons: %@", show.numberOfSeasons];
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TVShow *show = self.tvShows[indexPath.row];
        [TVShow deleteTVShow:show];
        self.tvShows = [TVShow getAllTVShows];
        [self.tableView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"DetailSegue"])
    {
        DetailTVShowViewController *detailTVShowVC = segue.destinationViewController;
        detailTVShowVC.selectedTVShow = self.tvShows[self.tableView.indexPathForSelectedRow.row];
    }
}

@end
