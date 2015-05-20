//
//  ViewController.m
//  TVShowsCollectionView
//
//  Created by Filipe Patrício on 20/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import "CharacterViewCell.h"
#import "PlistToModelConverter.h"
#import "ShowModel.h"
#import "CharacterModel.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *characterNameLabel;
@property (strong, nonatomic) NSArray *shows; //Of ShowModel
@property (strong, nonatomic) NSIndexPath *lastIndexPathSelected;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
        self.shows = [PlistToModelConverter convertShowsPlistToShowsArray];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.shows.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ((ShowModel*)self.shows[section]).characters.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CharacterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CharacterCell" forIndexPath:indexPath];
    
    ShowModel *show = (ShowModel*)self.shows[indexPath.section];
    
    cell.characterImageView.image = [UIImage imageNamed:((CharacterModel*)show.characters[indexPath.row]).imageName];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShowModel *show = (ShowModel*)self.shows[indexPath.section];
    self.imageView.image = [UIImage imageNamed:((CharacterModel*)show.characters[indexPath.row]).imageName];
    self.characterNameLabel.text = ((CharacterModel*)show.characters[indexPath.row]).name;
    
    return YES;
}



@end
