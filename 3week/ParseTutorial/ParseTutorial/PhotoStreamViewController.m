//
//  PhotoStreamViewController.m
//  ParseTutorial
//
//  Created by Filipe Patrício on 22/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "PhotoStreamViewController.h"
#import "PhotoCollectionViewCell.h"
#import <Parse/Parse.h>

@interface PhotoStreamViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *photos;
@end

@implementation PhotoStreamViewController

-(NSMutableArray *)photos
{
    if(!_photos)
        _photos = [[NSMutableArray alloc]init];
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadPhotos];
}

-(void)loadPhotos
{
    PFQuery *query = [PFQuery queryWithClassName:@"StreamPhotoObject"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu photos.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *photo in objects) {
                [self getPhoto:photo];
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)getPhoto:(PFObject *)photo
{
    NSLog(@"%@", photo.objectId);
    
    PFFile *imageFile = photo[@"imageFile"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:imageData];
            [self.photos addObject:image];
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoImageCell" forIndexPath:indexPath];
    cell.photoImageView.image = self.photos[indexPath.row];
    
    return cell;
}



- (IBAction)actionUploadPhoto:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}


#pragma mark UIImagePicker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedPhoto = info[UIImagePickerControllerEditedImage];
    
    NSData *imageData = UIImagePNGRepresentation(selectedPhoto);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    
    PFObject *photo = [PFObject objectWithClassName:@"StreamPhotoObject"];
    photo[@"imageName"] = @"Stream Image";
    photo[@"imageFile"] = imageFile;
    photo[@"user"] = [PFUser currentUser];
    [photo saveInBackground];
    
//    self.photoView.image = selectedPhoto;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // Handle success or failure here ...
        
        if(succeeded)
        {
            [self loadPhotos];
        }else
        {
            NSLog(@"%@", error.description);
        }
        
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
        float progress = percentDone / 100.0f;

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
