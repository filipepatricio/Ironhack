//
//  HomeScreenViewController.m
//  ParseTutorial
//
//  Created by Filipe Patrício on 22/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "HomeScreenViewController.h"
#import <Parse/Parse.h>

@interface HomeScreenViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UIProgressView *progressIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation HomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
    self.progressIndicator.hidden = YES;
    self.activityIndicator.hidden = YES;
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        self.usernameLabel.text = currentUser.username;
        
        PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
        [query whereKey:@"user" equalTo:currentUser];
        NSArray *userPhotos = [query findObjects];
        
        if(userPhotos.count > 0)
        {
            PFObject *photo = [userPhotos lastObject];
            PFFile *imageFile = photo[@"imageFile"];
            
            [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                if (!error) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    self.photoView.image = image;
                }
            }];
            

        }
        
    } else {
        // show the signup or login screen
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.photoView.layer.cornerRadius = self.photoView.frame.size.height/2;
    self.photoView.clipsToBounds = YES;
    self.photoView.layer.borderWidth = 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionLogOut:(id)sender
{
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionCamera:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark UIImagePicker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedPhoto = info[UIImagePickerControllerOriginalImage];
    
    NSData *imageData = UIImagePNGRepresentation(selectedPhoto);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    
    PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
    userPhoto[@"imageName"] = @"Profile Image";
    userPhoto[@"imageFile"] = imageFile;
    userPhoto[@"user"] = [PFUser currentUser];
    [userPhoto saveInBackground];
    
    self.photoView.image = selectedPhoto;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // Handle success or failure here ...
        
        if(succeeded)
        {
            self.progressIndicator.hidden = YES;
            self.activityIndicator.hidden = YES;
        }
        
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
        float progress = percentDone / 100.0f;
        self.photoView.alpha = progress;
        self.progressIndicator.hidden = NO;
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
        self.progressIndicator.progress = progress;
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
