//
//  Movie.h
//  Models
//
//  Created by Daniel García García on 18/05/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "MTLModel.h"

@interface Movie : MTLModel
@property (copy,nonatomic) NSString *movieId;
@property (copy,nonatomic) NSString *movieDescription;
@property (copy,nonatomic) NSString *movieTitle;
@property (assign,nonatomic) CGFloat movieRating;
@end
