//
//  ViewController.m
//  Copying
//
//  Created by Filipe Patrício on 25/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import "Beer.h"
#import "MovieModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *movies; // OF MovieModel
@end

@implementation ViewController

-(NSMutableArray *)movies
{
    if(!_movies)
    {
        _movies = [[NSMutableArray alloc] init];
        for(int i = 0; i < 5; i++)
        {
            MovieModel *movie = [[MovieModel alloc]init];
            movie.name = [NSString stringWithFormat:@"Movie %d", i];
            movie.director = [NSString stringWithFormat:@"Director %d", i];
            [_movies addObject:movie];
        }
    }
    return _movies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    MovieModel *movie = self.movies[indexPath.row];
    cell.textLabel.text = movie.name;
    cell.detailTextLabel.text = movie.director;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Copy movies array then add to table
    
    MovieModel *selectedMovie = self.movies[indexPath.row];
    
    MovieModel *copyMovie = [selectedMovie copy];
    
    [self.movies insertObject:copyMovie atIndex:indexPath.row+1];
    
    [tableView reloadData];
}



@end
