//
//  SecondViewController.m
//  Autolayout
//
//  Created by Filipe Patrício on 19/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIButton *pushDownButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionPushDown:(id)sender
{
    
    [UIView animateWithDuration:0.2 animations:^{
            self.topMargin.constant += 20;
        [self.pushDownButton layoutIfNeeded];
    }];

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
