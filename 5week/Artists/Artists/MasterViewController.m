//
//  ViewController.m
//  Artists
//
//  Created by Filipe Patrício on 01/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "MasterViewController.h"
#import "ArtistModel.h"
#import "ArtistService.h"
#import "ImageService.h"

@interface MasterViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *artists;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSMutableArray *artistCopies = [[NSMutableArray alloc] init];
//    ArtistModel *originalArtist = [ArtistModel randomArtist];
//    NSLog(@"Artist original - Name: %@; Object: %@", originalArtist.name, originalArtist);
//    for(int i = 0; i < 10; i++)
//    {
//        [artistCopies addObject: [originalArtist copy]];
//        ArtistModel *copyArtist = artistCopies[i];
//        NSLog(@"Artist copy %d - Name: %@; Object: %@", i, copyArtist.name, copyArtist);
//    }
    
    [self.activityIndicator startAnimating];
    [ArtistService artistsWithCompletion:^(NSArray *artistsArray) {
        self.artists = artistsArray;
        [self.activityIndicator stopAnimating];
        [self.tableView reloadData];
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.artists.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    ArtistModel *artist = self.artists[indexPath.row];
    
    cell.imageView.image = nil;
    cell.textLabel.text = artist.name;
    cell.detailTextLabel.text = artist.longDescription;
    
    //TO SOLVE Caching Problem;
    //Cocoapods - SDWEBIMAGE:
    //To get image from url with cache management
    
    [ImageService imageWithURL:artist.imageURL completion:^(UIImage *image) {
         cell.imageView.image = image;
    }];
    
    
    return cell;
}


@end
