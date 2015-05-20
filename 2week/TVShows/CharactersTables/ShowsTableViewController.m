//
//  ViewController.m
//  CharactersTables
//
//  Created by Filipe Patrício on 14/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ShowsTableViewController.h"
#import "CharactersTableVC.h"
#import "PlistToModelConverter.h"
#import "ShowModel.h"

@interface ShowsTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *shows;
@property (strong, nonatomic) NSIndexPath *lastIndexPathSelected;
@end

@implementation ShowsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.shows = [PlistToModelConverter convertShowsPlistToShowsArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shows.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Shows";
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"Footer text";
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel* label = [[UILabel alloc] init];
    label.text = @"SHOWS FOOTER";
    label.backgroundColor = [UIColor yellowColor];
    label.textColor = [UIColor purpleColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowCell" forIndexPath:indexPath];
    
    ShowModel *show = self.shows[indexPath.row];
    cell.textLabel.text = show.name;
    cell.imageView.image = [UIImage imageNamed:show.imageName];
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.lastIndexPathSelected = indexPath;
    return indexPath;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    CharactersTableVC *destinationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CharactersTableVC"];
//    destinationVC.show = self.shows[indexPath.row];
//    [self.navigationController showViewController:destinationVC sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CharactersTableVC *destinationVC = segue.destinationViewController;
    destinationVC.show = self.shows[self.lastIndexPathSelected.row];
}




@end
