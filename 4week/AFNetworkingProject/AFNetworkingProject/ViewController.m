//
//  ViewController.m
//  AFNetworkingProject
//
//  Created by Filipe Patrício on 27/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <Mantle/Mantle.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "Beer.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *beers;
@end

@implementation ViewController

-(NSMutableArray *)beers
{
    if(!_beers)
    {
        _beers = [self requestBeers];
    }
    return _beers;
}


- (NSMutableArray *)requestBeers {
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *beersArray = [[NSMutableArray alloc] init];
    
    NSString *apiString = @"http://api.brewerydb.com/v2/beers?key=8c65e1f1d40ea9eaab9de54da8b5e425&abv=-10";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:apiString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *beers = responseObject[@"data"];
        
        for(NSDictionary *beerDict in beers)
        {
            NSError *error;
            Beer *beer = [MTLJSONAdapter modelOfClass:[Beer class] fromJSONDictionary:beerDict error:&error];
            if(error)
                NSLog(@"Error creating Beer: %@", error);
            else
            {
                [beersArray addObject:beer];
                NSLog(@"%@",beer.name);
            }
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    return beersArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.beers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Beer *beer = self.beers[indexPath.row];
    cell.textLabel.text = beer.name;
    cell.detailTextLabel.text = beer.labelThumbnailURL;
    [cell.imageView setImageWithURL: [NSURL URLWithString:beer.labelThumbnailURL] placeholderImage:[UIImage imageNamed:@"homer"]];
    
    return cell;
}


@end
