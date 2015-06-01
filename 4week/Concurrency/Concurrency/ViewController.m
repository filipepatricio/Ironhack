//
//  ViewController.m
//  Concurrency
//
//  Created by Filipe Patrício on 29/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionGetImageInBackgroundQueue:(id)sender
{
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    dispatch_queue_t background_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(background_queue, ^{
        [self getImageWithURLString:@"http://s3.amazonaws.com/TimeScapes/images/stills/4k/moonbow.jpg"];
    });
    
}
- (IBAction)actionGetImageInMainQueue:(id)sender
{
    [self getImageWithURLString:@"http://s3.amazonaws.com/TimeScapes/images/stills/4k/big_sur.jpg"];
    
    
}

-(void)getImageWithURLString:(NSString*)urlString
{
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    //Run a block on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = image;
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
    });

}

@end
