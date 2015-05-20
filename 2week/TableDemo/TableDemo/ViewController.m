//
//  ViewController.m
//  TableDemo
//
//  Created by Filipe Patrício on 13/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import "PhotoViewController.h"
#import "Person.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray* students; // Of NSString
@property (strong, nonatomic) NSArray* teachers; // Of NSString
@property (strong, nonatomic) NSMutableArray* simpsons;
@end

@implementation ViewController

-(NSMutableArray *)simpsons
{

    if(!_simpsons)
    {
        _simpsons = [NSMutableArray array];
        NSArray *arrayOfDict = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PersonsList" ofType:@"plist"]];
        for(NSDictionary *dict in arrayOfDict)
            [_simpsons addObject:[[Person alloc] initWithName:dict[@"name"] andImageName:dict[@"image"]]];
        
    }
    return _simpsons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.students = @[
                      @"Marin",
                      @"Filipe",
                      @"John",
                      @"Lalala"];
    
    self.teachers = @[
                      @"Teacher A",
                      @"Teacher B",
                      @"Teacher C",
                      ];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return @"Students";
    else if(section == 1)
        return @"Teachers";
    else if(section == 2)
        return @"Simpsons";
    else
        return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if(section == 0)
        return @"These are all the students of the class";
    else if(section == 1)
        return @"And here are the teachers";
    else
        return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section == 0)
        return self.students.count;
    else if(section == 1)
        return self.teachers.count;
    else if(section == 2)
        return self.simpsons.count;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.", indexPath.row+1];
    if(indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell"];
        cell.detailTextLabel.text = self.students[indexPath.row];
    }
    else if(indexPath.section == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell"];
        cell.detailTextLabel.text = self.teachers[indexPath.row];
    }
    else if(indexPath.section == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SimpsonCell"];
        cell.textLabel.text = ((Person*)self.simpsons[indexPath.row]).name;
        cell.imageView.image = [UIImage imageNamed:((Person*)self.simpsons[indexPath.row]).imageName];
        
    }
    
    return cell;
}

#pragma mark UITableDataDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // To deselect the row
    
    Person *person = self.simpsons[indexPath.row];
    
    PhotoViewController *photoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    
    photoVC.image = [UIImage imageNamed:((Person*)self.simpsons[indexPath.row]).imageName];
    
    [self.navigationController pushViewController:photoVC animated:YES];
    
    
}



@end
