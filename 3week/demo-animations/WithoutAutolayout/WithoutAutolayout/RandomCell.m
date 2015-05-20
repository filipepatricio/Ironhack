//
//  RandomCell.m
//  WithoutAutolayout
//
//  Created by Filipe Patrício on 19/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "RandomCell.h"

@interface RandomCell ()
@property (weak, nonatomic) IBOutlet UIView *image;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation RandomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
