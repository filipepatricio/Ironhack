//
//  ImageService.h
//  Artists
//
//  Created by Filipe Patrício on 01/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageService : NSObject
+ (void)imageWithURL:(NSURL *)imageURL completion:(void (^)(UIImage *))completion;
@end
