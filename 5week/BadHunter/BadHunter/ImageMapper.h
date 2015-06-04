//
//  ImageMapper.h
//  BadHunter
//
//  Created by Filipe Patrício on 04/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageMapper : NSObject
+ (void) storeImage:(UIImage *)image withUUID:(NSString *)uuid;
+ (void) deleteImageWithUUID:(NSString *)uuid;
+ (UIImage *) retrieveImageWithUUID:(NSString *)uuid;
@end
