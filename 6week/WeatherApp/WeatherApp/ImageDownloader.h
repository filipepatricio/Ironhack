//
//  ImageDownloader.h
//  WeatherApp
//
//  Created by Filipe Patrício on 08/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageDownloader : NSObject
+(void)imageWithURL:(NSString *)url completionBlock:(void (^) (UIImage *image))completionBlock;
@end
