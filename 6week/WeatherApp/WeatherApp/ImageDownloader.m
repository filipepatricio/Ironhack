//
//  ImageDownloader.m
//  WeatherApp
//
//  Created by Filipe Patrício on 08/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

+(void)imageWithURL:(NSString *)url completionBlock:(void (^) (UIImage *image))completionBlock
{
    dispatch_queue_t download = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(download, ^{
      
        NSURL *urlDownload = [NSURL URLWithString:url];
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:urlDownload completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
            if(HTTPResponse.statusCode == 200)
            {
                if(!error)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *image = [UIImage imageWithData:data];
                        completionBlock(image);
                    });
                }
                else
                {
                    NSLog(@"%@",error);
                }
            }

        }]resume ];
    });
}

@end
