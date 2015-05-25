//
//  ShowDetailViewController.m
//  Copying
//
//  Created by Filipe Patrício on 25/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "PersistenceManager.h"

@interface ShowDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfSeasonsLabel;

@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.tvShow.title;
    self.numberOfSeasonsLabel.text = [NSString stringWithFormat:@"%lu", self.tvShow.numberOSeasons];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionCopy:(id)sender
{
    [self.tvShow copy];
    [self.delegate ShowDetailViewController:self didCopyTVShow:self.tvShow atIndex:self.index];
    [self.navigationController popViewControllerAnimated:YES];
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
