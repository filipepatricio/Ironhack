//
//  PhotoViewController.h
//  Collection-demo
//
//  Created by Marin Todorov on 5/15/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (strong, nonatomic) UIImage * photo;
@property (weak, nonatomic) IBOutlet UIImageView* imageView;


@end
