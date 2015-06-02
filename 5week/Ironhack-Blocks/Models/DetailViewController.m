//
//  DetailViewController.m
//  Models
//
//  Created by Filipe Patrício on 02/06/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

#import "DetailViewController.h"
#import "CustomBarButtonItem.h"
#import "UIAlertView+Blocks.h"
#import <libextobjc/extobjc.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSData *imageData = [NSData  dataWithContentsOfURL:self.show.posterURL];
    self.imageView.image = [UIImage imageWithData:imageData];
    self.descriptionLabel.text = self.show.showDescription;
    
    @weakify(self);
    
    CustomBarButtonItem *button = [[CustomBarButtonItem alloc]initWithTitle:@"Like" style:UIBarButtonItemStyleBordered actionBlock:^{
            NSLog(@"Like Button BLOCK");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Like" message:@"Do you really like this movie?" blockToDo:^(NSInteger buttonIndex) {
                if(buttonIndex == 1)
                {
                    @strongify(self);
                    NSLog(@"YEYYY");
                    self.descriptionLabel.text = @"YEEEEY";
                }
            } cancelButtonTitle:@"NO" otherButtonTitles:@"YES"];
            [alert show];
    }];
    
    self.navigationItem.rightBarButtonItem = button;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.view layoutIfNeeded];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
