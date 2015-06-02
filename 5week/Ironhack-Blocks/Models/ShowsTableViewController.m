//
//  MainTableViewController.m
//  Models
//
//  Created by Daniel García on 17/05/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "ShowsTableViewController.h"
#import "Show.h"
#import "NSString+Random.h"
#import <Mantle/Mantle.h>
#import "DetailViewController.h"
#import "CustomBarButtonItem.h"
#import "UIAlertView+Blocks.h"
#import "ShowsProvider.h"
#import <libextobjc/extobjc.h>


static NSString * const savedShowsFileName=@"shows";

@interface ShowsTableViewController ()
@property (strong,nonatomic) NSMutableArray *shows;
@end

@implementation ShowsTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title=@"Shows";
        _shows = [NSMutableArray array];
        [self loadShowsFromRemote];
        
    }
    return self;
}
- (void)loadShowsFromRemote{
    //NSDictionary *JSONDictionary = [self showsJSONDictionaryFromRemote];
    @weakify(self);
    [ShowsProvider getShowsWithBlock:^(NSArray *shows) {
        @strongify(self);
        self.shows = [shows mutableCopy];
        [self.tableView reloadData];
    }];
    
}
- (NSDictionary *)showsJSONDictionaryFromRemote{
    NSURL *jsonURL = [NSURL URLWithString:@"http://ironhack4thweek.s3.amazonaws.com/shows.json"];
    NSData *seriesData = [NSData dataWithContentsOfURL:jsonURL];
    NSError *error;
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:seriesData options:NSJSONReadingMutableContainers error:&error];
    return JSONDictionary;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CustomBarButtonItem *saveShowsButton=[[CustomBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain actionBlock:^{
        if (self.shows.count) {
            [NSKeyedArchiver archiveRootObject:self.shows toFile:[self archivePath]];
        }        
    }];
    self.navigationItem.leftBarButtonItem = saveShowsButton;
    
    CustomBarButtonItem *addShowButton=[[CustomBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain actionBlock:^{
        [self.shows addObject:[self randomShow]];
        [self.tableView reloadData];
    }];
    self.navigationItem.rightBarButtonItem = addShowButton;
    
}

- (Show *)randomShow{
    Show *show=[[Show alloc] init];
    show.showId=[NSString randomString];
    show.showTitle=[NSString randomString];
    show.showDescription=[NSString randomString];
    show.showRating=arc4random()/10.0f;
    return show;
}

- (NSString *)archivePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return [documentsDirectory stringByAppendingPathComponent:savedShowsFileName];
}

- (void)loadShows{
    NSArray *shows=[NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    if (shows.count) {
        self.shows=[shows mutableCopy];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
    }
    Show *show=[self.shows objectAtIndex:indexPath.item];
    cell.textLabel.text=show.showTitle;
    cell.detailTextLabel.text=show.showDescription;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Show *show=[self.shows objectAtIndex:indexPath.item];
//    if (indexPath.row>=0 && indexPath.row<=1) {
//        [self compareWithFirstShow:show];
//    }else{
//        [self findShow:show];
//    }
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.show = show;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (void)compareWithFirstShow:(Show *)show{
    Show *firstShow=[self.shows firstObject];
    if ([firstShow isEqualToShow:show]) {
        [[[UIAlertView alloc]initWithTitle:@"Equal Show" message:@"It is equal !!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
    }else{
        [[[UIAlertView alloc]initWithTitle:@"Equal Show" message:@"It is NOT equal" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
    }
}

- (void)findShow:(Show *)show{
    if ([self.shows containsObject:show]) {
        [[[UIAlertView alloc]initWithTitle:@"Find Show" message:@"Found !" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
    }else{
        [[[UIAlertView alloc]initWithTitle:@"Find Show" message:@"Not in dataSource" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
    }
}
@end
