//
//  ViewController.m
//  IronSquare
//
//  Created by Filipe Patrício on 29/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "LocationModel.h"
#import <Mantle/Mantle.h>
#import "LocationCellTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *locations; //OF LocalizationModel
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation ViewController

-(NSMutableArray *)locations
{
    if(!_locations)
        _locations = [[NSMutableArray alloc] init];
    return _locations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([self checkLogin])
    {
        [self getLocations];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.locations.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    LocationModel *location = self.locations[indexPath.row];
    cell.cellTextLabel.text = location.text;
    cell.cellUserLabel.text = location.user;
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:location.map_image]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationModel *location = self.locations[indexPath.row];
    self.textLabel.text = location.text;
    self.userLabel.text = location.user;
    self.urlLabel.text = location.url;
    [self.imageView setImageWithURL:[NSURL URLWithString:location.map_image]];
    self.latitudeLabel.text = [NSString stringWithFormat:@"%f", location.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%f", location.longitude];
}


-(void)getLocations
{
    [self.activityIndicator startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{};
    [manager GET:@"http://ironsquare.herokuapp.com/updates.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        for(NSDictionary *locationDict in responseObject)
        {
            LocationModel *location = [MTLJSONAdapter modelOfClass:[LocationModel class] fromJSONDictionary:locationDict error:nil];
            //LocationModel *location = [[LocationModel alloc] initWithDictionary:locationDict error:nil];
            [self.locations addObject:location];
        }
        
        [self.tableView reloadData];
        [self.activityIndicator stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)actionLogout:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email"];
    [self checkLogin];
}

- (BOOL)checkLogin
{
    // 1. Check if the user is logged in NSUserDefaults
    
    NSString *userEmail = [[NSUserDefaults standardUserDefaults] objectForKey: @"email"];
    
    if(!userEmail)
    {
        // 2. Show login screen if it's not signed up
        //  use segue identifier to show the modal view controller
        [self performSegueWithIdentifier:@"LoginSegue" sender:self];
        return false;
        
    }
    else
    {
        NSLog(@"User logged in");
        return true;
    }
}


@end
