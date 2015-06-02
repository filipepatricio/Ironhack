//
//  Product.h
//  Models
//
//  Created by Daniel García on 17/05/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface Show : MTLModel<MTLJSONSerializing>
@property (copy,nonatomic) NSString *showId;
@property (copy,nonatomic) NSString *showDescription;
@property (copy,nonatomic) NSString *showTitle;
@property (assign,nonatomic) CGFloat showRating;
@property (strong, nonatomic) NSURL *posterURL;

- (BOOL)isEqualToShow:(Show *)show;
@end
