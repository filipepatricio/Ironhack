//
//  TVShowModel.h
//  Copying
//
//  Created by Filipe Patrício on 25/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface TVShowModel : MTLModel
@property (strong, nonatomic)NSString *title;
@property (assign, nonatomic)NSUInteger numberOSeasons;
@end
