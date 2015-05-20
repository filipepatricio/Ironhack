//
//  ViewController.m
//  Collection-demo
//
//  Created by Marin Todorov on 5/15/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"

#import "ShowModel.h"
#import "CharacterModel.h"

#import "PhotoViewController.h"

@interface ViewController ()
    <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)NSArray *shows;
@property(nonatomic) int index;

@property (strong, nonatomic) NSIndexPath* lastIndex;
@property (assign, nonatomic) int lastCharacter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TV Shows";
    self.shows = [ShowModel arrayOfShows];
    
    self.lastCharacter = -1;
}

-(void)viewWillAppear:(BOOL)animated
{
    //[self performSelector:@selector(showCharacter) withObject:nil afterDelay:2];
}

-(void)showCharacter
{
    ShowModel* show = self.shows[1];
    
    self.lastCharacter++;
    if (self.lastCharacter == show.showCharacters.count) {
        self.lastCharacter = 0;
    }
    
    self.lastIndex = [NSIndexPath indexPathForRow:self.lastCharacter inSection:1];
    [self performSegueWithIdentifier:@"show" sender:nil];
}

//COLLECTION DATA SOURCE METHODS

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.shows.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    ShowModel* show = self.shows[section];
    return show.showCharacters.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShowModel* show = self.shows[indexPath.section];
    CharacterModel* character = show.showCharacters[indexPath.row];
    
    if (indexPath.section==1) {
        MyCell* cell =
        
        [collectionView
         dequeueReusableCellWithReuseIdentifier:@"SimpsonCell"
         forIndexPath:indexPath];
        
        cell.photoLabel.text = character.name;
        
        UIImage* photo = [UIImage imageNamed:character.image];
        cell.photoView.image = photo;
        
        return cell;

    } else {
        MyCell* cell =
        
        [collectionView
         dequeueReusableCellWithReuseIdentifier:@"StarWarsCell"
         forIndexPath:indexPath];
        
        cell.photoLabel.text = character.name;
        
        UIImage* photo = [UIImage imageNamed:character.image];
        cell.photoView.image = photo;
        
        return cell;
        
    }
    
    
}

// FLOW LAYOUT METHODS

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat extraWidth = indexPath.row * 20;
    
    CGSize size = CGSizeMake(100 + extraWidth, 120);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsMake(20, 20, 20, 20);
    return insets;
}

-(BOOL)collectionView:(UICollectionView *)collectionView
    shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.lastIndex = indexPath;
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PhotoViewController* photoVC = segue.destinationViewController;

    ShowModel* show = self.shows[self.lastIndex.section];
    CharacterModel* character = show.showCharacters[self.lastIndex.row];

    photoVC.photo = [UIImage imageNamed: character.image ];
    photoVC.title = character.name;
}

-(void)collectionView:(UICollectionView *)collectionView
    didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader" forIndexPath:indexPath];
        return headerView;
    }
    
    return nil;
    
}





@end
