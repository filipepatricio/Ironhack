//
//  ViewController.m
//  Collection-Demo
//
//  Created by Filipe Patrício on 15/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import "CharacterCollectionViewCell.h"
#import "CharacterDetailViewController.h"
#import "PlistToModelConverter.h"
#import "ShowModel.h"
#import "CharacterModel.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)NSArray *shows;
@property (strong, nonatomic)NSIndexPath *selectedIndexPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.shows = [PlistToModelConverter convertShowsPlistToShowsArray];
}


#pragma mark DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ((ShowModel*)self.shows[section]).characters.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CharacterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CharacterCell" forIndexPath:indexPath];
    
    CharacterModel *character = ((ShowModel*)self.shows[indexPath.section]).characters[indexPath.row];
    cell.photo.image = [UIImage imageNamed:character.imageName];
    cell.characterNameLabel.text = character.name;
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    return YES;
}

#pragma mark Delegate




#pragma DelegateFlowLayout




#pragma mark Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CharacterDetailSegue"])
    {
        CharacterDetailViewController *characterDetailVC = segue.destinationViewController;
        characterDetailVC.character = ((ShowModel*)self.shows[self.selectedIndexPath.section]).characters[self.selectedIndexPath.row];
    }
}


@end
