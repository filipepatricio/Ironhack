//
//  LocationCellTableViewCell.h
//  IronSquare
//
//  Created by Filipe Patrício on 29/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellUserLabel;
@end
