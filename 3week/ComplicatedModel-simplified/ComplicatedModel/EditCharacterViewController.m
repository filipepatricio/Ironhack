//
//  EditCharacterViewController.m
//  ComplicatedModel
//
//  Created by Filipe Patrício on 20/05/15.
//  Copyright (c) 2015 Georgios Pessios. All rights reserved.
//

#import "EditCharacterViewController.h"

@interface EditCharacterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (assign, nonatomic) CGPoint firstPoint;
@end

@implementation EditCharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.image = [UIImage imageNamed:self.character.image];
    self.textField.text = self.character.name;
    
    //ENABLE USER INTERACTION FOR IMAGE VIEW
    self.imageView.userInteractionEnabled = YES;
    
    //CREATE TAP GESTURE
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnImage:)];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeOnImage:)];
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchOnImage:)];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnImage:)];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressOnImage:)];
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapOnImage:)];
    
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    doubleTapGesture.numberOfTapsRequired = 2;
    
    //ATTACH RECOGNIZERS TO IMAGE VIEW
    [self.imageView addGestureRecognizer:tapGesture];
    [self.imageView addGestureRecognizer:swipeGesture];
    [self.imageView addGestureRecognizer:pinchGesture];
    [self.imageView addGestureRecognizer:panGesture];
    [self.imageView addGestureRecognizer:longPressGesture];
    [self.imageView addGestureRecognizer:doubleTapGesture];
    
}

//REACT RECOGNIZERs
-(void)tapOnImage:(UITapGestureRecognizer*)recognizer
{
//    [self.textField becomeFirstResponder];
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionAutoreverse
                     animations:^{
                         self.imageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                     }
                     completion:^(BOOL complete)
                     {
                         self.imageView.transform = CGAffineTransformIdentity;
                     }];
}

-(void)swipeOnImage:(UISwipeGestureRecognizer*)recognizer
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pinchOnImage:(UIPinchGestureRecognizer*)recognizer
{
    self.imageView.transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
}

-(void)panOnImage:(UIPanGestureRecognizer*)recognizer
{
    CGPoint offset = [recognizer translationInView:self.view];
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
    self.imageView.transform = transform;
    
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
        self.firstPoint = [self.view convertPoint:offset toView:self.imageView];
        
    }
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        self.imageView.transform = CGAffineTransformIdentity;
        self.imageView.frame = CGRectMake(offset.x - self.firstPoint.x, offset.y - self.firstPoint.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
    }
}

-(void)longPressOnImage:(UILongPressGestureRecognizer*)recognizer
{
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                        self.imageView.backgroundColor = [UIColor blueColor];
                         
                     }completion:nil];
}

-(void)doubleTapOnImage:(UITapGestureRecognizer*)recognizer
{
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.imageView.backgroundColor = [UIColor clearColor];
                         
                     }completion:nil];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 2;
}

- (IBAction)actionDone:(id)sender
{
    self.character.name = self.textField.text;
    [self.delegate viewController:self editedCharacter:self.character indexPath:self.indexPath];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionDelete:(id)sender
{
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.imageView.alpha = 0.0;
        self.textField.alpha = 0.0;
        self.nameLabel.alpha = 0.0;
        
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 animations:^{
                self.view.backgroundColor = ((UIButton*)sender).backgroundColor;
        }completion:^(BOOL finished) {
            [self.delegate viewController:self deletedCharacter:self.character indexPath:self.indexPath];
            [self.navigationController popViewControllerAnimated:YES];
        }];
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
