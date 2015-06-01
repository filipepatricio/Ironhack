//
//  ImageService.m
//  Artists
//
//  Created by Filipe Patrício on 01/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ImageService.h"

@implementation ImageService
+ (void)imageWithURL:(NSURL *)imageURL completion:(void (^)(UIImage *))completion
{
    
    if(![imageURL pathComponents])
        return;
    
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES )[0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.dat",documentsPath, [[imageURL pathComponents] lastObject]];
    NSLog(@"%@",filePath);
    NSData *imageData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    if(imageData)
        completion([UIImage imageWithData:imageData]);
    else
    {
    
        NSURLSession *urlSession = [NSURLSession sharedSession];
        [[urlSession dataTaskWithRequest:[NSURLRequest requestWithURL:imageURL]
                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                           [NSKeyedArchiver archiveRootObject:data toFile:filePath];
                           
                           dispatch_async(dispatch_get_main_queue(), ^{
                               completion([UIImage imageWithData:data]);
                           });
                           
                       }] resume];
        
    }
    
    
}
@end
