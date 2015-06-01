//
//  ViewController.m
//  NetworkAndBlock
//
//  Created by Filipe Patrício on 27/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *urlTextField;

@end

@implementation ViewController

- (void)requestURL:(NSURL *)catURL {
    NSURLRequest *request = [NSURLRequest requestWithURL:catURL];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        UIImage *catImage = [UIImage imageWithData:data];
        self.imageView.image = catImage;
    }];
    
//    [connection start];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *catURL = [NSURL URLWithString:@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8yxb9X57QJ58n0ZAAnC89F08lwgxnGQOKkPSjGwfitl6VK4wy9Q"];
    
    [self requestURL:catURL];
    
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    UIImage *catImage = [UIImage imageWithData:data];
    self.imageView.image = catImage;
}
- (IBAction)actionGetImage:(id)sender
{
    NSURL *imageURL = [NSURL URLWithString:self.urlTextField.text];
    [self requestURL:imageURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
