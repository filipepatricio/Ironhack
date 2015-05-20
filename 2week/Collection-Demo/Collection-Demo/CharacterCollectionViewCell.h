//
//  CharacterCollectionViewCell.h
//  Collection-Demo
//
//  Created by Filipe Patrício on 15/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *characterNameLabel;
@end
