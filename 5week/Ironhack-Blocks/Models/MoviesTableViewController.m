//
//  MoviesTableViewController.m
//  Models
//
//  Created by Daniel García García on 18/05/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "MoviesTableViewController.h"
#import "Movie.h"
#import "NSString+Random.h"

@interface MoviesTableViewController ()
@property (strong,nonatomic) NSMutableArray *movies;
@end

static NSString * const savedMoviesFileName=@"movies";

@implementation MoviesTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title=@"Movies";
        _movies=[NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *saveMoviesButton=[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveMovies:)];
    self.navigationItem.leftBarButtonItem = saveMoviesButton;
    
    UIBarButtonItem *addMovieButton=[[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addMovie:)];
    self.navigationItem.rightBarButtonItem = addMovieButton;
    
    [self loadMovies];
}

- (void)addMovie:(id)sender{
    [self.movies addObject:[self randomMovie]];
    [self.tableView reloadData];
}

- (Movie *)randomMovie{
    Movie *movie=[[Movie alloc] init];
    movie.movieId=[NSString randomString];
    movie.movieTitle=[NSString randomString];
    movie.movieDescription=[NSString randomString];
    movie.movieRating=arc4random()/10.0f;
    return movie;
}

- (NSString *)archivePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:savedMoviesFileName];
}

- (void)saveMovies:(id)sender{
    if (self.movies.count) {
        [NSKeyedArchiver archiveRootObject:self.movies toFile:[self archivePath]];
    }
}

- (void)loadMovies{
    NSArray *movies=[NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    if (movies.count) {
        self.movies=[movies mutableCopy];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
    }
    Movie *movie=[self.movies objectAtIndex:indexPath.item];
    cell.textLabel.text=movie.movieTitle;
    cell.detailTextLabel.text=movie.movieDescription;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Movie *movie=[self.movies objectAtIndex:indexPath.item];
    if (indexPath.row>=0 && indexPath.row<=1) {
        [self compareWithFirstMovie:movie];
    }else{
        [self findMovie:movie];
    }
}

- (void)compareWithFirstMovie:(Movie *)movie{
    Movie *firstMovie=[self.movies firstObject];
    if ([firstMovie isEqual:movie]) {
        [[[UIAlertView alloc]initWithTitle:@"Equal Movie" message:@"It is equal !!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
    }else{
        [[[UIAlertView alloc]initWithTitle:@"Equal Movie" message:@"It is NOT equal" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
    }
}

- (void)findMovie:(Movie *)movie{
    if ([self.movies containsObject:movie]) {
        [[[UIAlertView alloc]initWithTitle:@"Find Movie" message:@"Found !" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
    }else{
        [[[UIAlertView alloc]initWithTitle:@"Find Movie" message:@"Not in dataSource" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
    }
}

@end
