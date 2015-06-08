//
//  ViewController.m
//  Testing
//
//  Created by Joan Romano on 6/4/15.
//  Copyright (c) 2015 Joan Romano. All rights reserved.
//

#import "ViewController.h"

#import "SectionedArrayDataSource.h"
#import "ArtistCellAdapter.h"

#import "Artist.h"

@interface ViewController ()

@property (nonatomic, strong) SectionedArrayDataSource *dataSource;

@property (nonatomic, weak) IBOutlet UITableView *resultsTableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [[SectionedArrayDataSource alloc] initWithTableView:self.resultsTableView cellAdapter:[[ArtistCellAdapter alloc] init]];
    
    [self insertObjects];
}

- (void)insertObjects
{
    NSMutableArray *objects = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 50; i++)
    {
        [objects addObject:[[Artist alloc] initWithName:[self randomAlphanumericStringWithLength:20]]];
    }
    
    self.dataSource.items = @[[objects copy], [objects copy]];
}

- (NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}

@end
