//
//  CharacterDetailViewController.m
//  Collection-Demo
//
//  Created by Filipe Patrício on 15/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "CharacterDetailViewController.h"

@interface CharacterDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@end

@implementation CharacterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photo.image = [UIImage imageNamed:self.character.imageName];
    self.title = self.character.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
