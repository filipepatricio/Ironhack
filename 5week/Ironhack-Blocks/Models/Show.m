//
//  Product.m
//  Models
//
//  Created by Daniel García on 17/05/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "Show.h"

@implementation Show
- (NSString *)description{
    return self.showTitle;
}

#pragma mark - Comparison
- (BOOL)isEqualToShow:(Show *)show{
    return [self isEqual:show];
}

+ (NSValueTransformer *)posterURLJSONTransformer {
    
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
    
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"showDescription": @"description",
             @"showTitle": @"title",
             @"showId":@"id",
             @"posterURL":@"posterURL",
             };
}

@end
