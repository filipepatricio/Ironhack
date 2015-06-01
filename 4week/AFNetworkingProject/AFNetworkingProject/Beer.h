//
//  Beer.h
//  AFNetworkingProject
//
//  Created by Filipe Patrício on 27/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface Beer : MTLModel <MTLJSONSerializing>

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *info;
@property (strong,nonatomic) NSString *labelImageURL;
@property (strong,nonatomic) NSString *labelThumbnailURL;

@end
