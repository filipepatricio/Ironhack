//
//  ArtistService.h
//  Artists
//
//  Created by Filipe Patrício on 01/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtistService : NSObject
+ (void)artistsWithCompletion:(void (^)(NSArray *))completion;
@end
