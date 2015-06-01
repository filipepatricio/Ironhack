//
//  LocalizationModel.h
//  IronSquare
//
//  Created by Filipe Patrício on 29/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface LocationModel : MTLModel <MTLJSONSerializing>
@property (assign, nonatomic) NSInteger id;
@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *map_image;
-(instancetype)initWithText:(NSString*)text latitude:(double)lat longitude:(double)lng URL:(NSString*)url;
@end
