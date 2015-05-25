//
//  ShowDetailViewController.h
//  Copying
//
//  Created by Filipe Patrício on 25/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVShowModel.h"

@protocol CopyTVShow <NSObject>

@required
-(void)ShowDetailViewController:(UIViewController*)viewController didCopyTVShow:(TVShowModel*)tvShow atIndex:(NSUInteger)index;

@end

@interface ShowDetailViewController : UIViewController
@property (weak, nonatomic) id<CopyTVShow> delegate;
@property (strong, nonatomic) TVShowModel *tvShow;
@property (assign, nonatomic) NSUInteger index;
@end
