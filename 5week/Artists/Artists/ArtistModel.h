//
//  ArtistModel.h
//  Artists
//
//  Created by Filipe Patrício on 01/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtistModel : NSObject
@property(assign, nonatomic) NSInteger artistID;
@property(copy, nonatomic) NSString *name;
@property(copy, nonatomic) NSString *longDescription;
@property(copy, nonatomic) NSString *stage;
@property(strong, nonatomic) NSURL *imageURL;
@property(strong, nonatomic) NSDate *startDate;
+ (instancetype)randomArtist;
- (BOOL)isEqualToArtist:(ArtistModel*)artist;
@end
