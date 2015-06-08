//
//  ViewController.h
//  Testing
//
//  Created by Joan Romano on 6/4/15.
//  Copyright (c) 2015 Joan Romano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
 Generates a random string with a given length.
 
 @param length The length of the random string
 */
- (NSString *)randomAlphanumericStringWithLength:(NSInteger)length;

@end

