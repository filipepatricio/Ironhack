//
//  RequestManager.m
//  Models
//
//  Created by Filipe Patrício on 02/06/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

#import "RequestManager.h"

#import <AFHTTPRequestOperationManager.h>

@implementation RequestManager

+(void)requestFromURL:(NSURL*)url success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;
{
    AFHTTPRequestOperationManager *opManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    [opManager GET:url.path
        parameters:nil
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               successBlock(responseObject);
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               failureBlock(error);
           }];
}

@end
