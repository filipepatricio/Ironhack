//
//  TVShowsViewController.m
//  Copying
//
//  Created by Filipe Patrício on 25/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "TVShowsViewController.h"
#import "TVShowModel.h"

@interface TVShowsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *tvShows; // OF MovieModel
@end

@implementation TVShowsViewController

-(NSMutableArray *)tvShows
{
    if(!_tvShows)
    {
        //LOAD movies from documents directory
        _tvShows = [NSKeyedUnarchiver unarchiveObjectWithFile:[self moviesFile]];
        if(!_tvShows)
        {
            _tvShows = [[NSMutableArray alloc] init];
            for(int i = 0; i < 5; i++)
            {
                TVShowModel *tvShow = [[TVShowModel alloc]init];
                tvShow.title = [NSString stringWithFormat:@"TVShow %d", i];
                tvShow.numberOSeasons = [[NSNumber numberWithInt: i] unsignedLongValue];
                [_tvShows addObject:tvShow];
            }
        }
    }
    return _tvShows;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tvShows.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    TVShowModel *tvShow = self.tvShows[indexPath.row];
    cell.textLabel.text = tvShow.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Number Of Seasons: %lu", tvShow.numberOSeasons ];
    
    return cell;
}

-(NSString *)moviesFile
{
    
    //NSCachesDirectory - it may be erasable
    //NSDocumentDirectory - it's permanent
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return [documentsDirectory stringByAppendingString:@"/tvShows.dat"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Copy movies array then add to table
    
    TVShowModel *selectedTVShow = self.tvShows[indexPath.row];
    
    TVShowModel *copyTVShow = [selectedTVShow copy];

    NSLog(@"%d", copyTVShow == selectedTVShow);
    
    copyTVShow.title = [copyTVShow.title stringByAppendingString:@" (Copied)"];
    
    NSLog(@"%d", [copyTVShow isEqual:selectedTVShow]);
    
    [self.tvShows insertObject:copyTVShow atIndex:indexPath.row+1];
    
    //SAVE movies from documents directory
    [NSKeyedArchiver archiveRootObject:self.tvShows toFile:[self moviesFile]];
    
    [tableView reloadData];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
