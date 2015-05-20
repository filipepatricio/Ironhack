//
//  DetailsVC.h
//  SuperDuperBeer
//
//  Created by Filipe Patrício on 08/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beer.h"

@interface DetailsVC : UIViewController
@property (nonatomic, strong) NSMutableArray *beersArray;   //Of Beer
@property (nonatomic) NSUInteger currentBeerIndex;
@property (nonatomic) NSString *beersFile;
@end
