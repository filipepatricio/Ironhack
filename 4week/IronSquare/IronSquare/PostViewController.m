//
//  PostViewController.m
//  IronSquare
//
//  Created by Filipe Patrício on 29/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "PostViewController.h"
#import "LocationModel.h"
#import <AFNetworking/AFNetworking.h>
#import <Mantle/Mantle.h>

@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textTextField;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)actionPost:(id)sender
{

    LocationModel *location = [[LocationModel alloc] initWithText:self.textTextField.text
                                                         latitude:[self.latitudeTextField.text doubleValue]
                                                        longitude:[self.longitudeTextField.text doubleValue]
                                                              URL:self.urlTextField.text];
    
    NSDictionary *update = [MTLJSONAdapter JSONDictionaryFromModel:location error:nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"update": update,
                                 };
    [manager POST:@"http://ironsquare.herokuapp.com/updates.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
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
