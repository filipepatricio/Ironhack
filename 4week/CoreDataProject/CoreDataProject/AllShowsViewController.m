//
//  AllShowsViewController.m
//  CoreDataProject
//
//  Created by Filipe Patrício on 26/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "AllShowsViewController.h"
#import "TVShow+Manager.h"

@interface AllShowsViewController()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *tvShows; //Of TVShow
@end

@implementation AllShowsViewController

-(void)viewDidLoad
{
    self.tvShows = [TVShow getAllTVShows];
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(refreshDidChange:) forControlEvents:UIControlEventValueChanged];
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
        //add code here for when you hit delete
    }
}

@end
