//
//  RequestManager.h
//  Models
//
//  Created by Filipe Patrício on 02/06/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailureBlock)(NSError *error);

@interface RequestManager : NSObject
+(void)requestFromURL:(NSURL*)url success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;
@end
