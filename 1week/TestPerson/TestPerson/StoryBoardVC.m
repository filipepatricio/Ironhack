//
//  StoryBoardVC.m
//  TestPerson
//
//  Created by Filipe Patrício on 06/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "StoryBoardVC.h"
#import "NSDictionary+CreatePerson.h"
#import "Images.h"

@interface StoryBoardVC()
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (nonatomic) NSUInteger counter;
@property (nonatomic) NSUInteger currentImageIndex;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (weak, nonatomic) IBOutlet UILabel *imageTitle;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic, strong) NSArray *languagesArray; // Of NSString
@property (nonatomic, strong) NSArray *countriesArray; //Of NSString
@property (nonatomic, strong) NSArray *numbersArray; // Of NSNUmber
@property (nonatomic, strong) NSArray *helloArray;
@property (weak, nonatomic) IBOutlet UILabel *helloWordLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

typedef enum
{
    LanguagesPickerColumn = 0,
    CountriesPickerColumn = 1,
    NumbersPickerColumn = 2,
}PickerViewColumns;

@implementation StoryBoardVC

-(void)viewDidLoad
{

    [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
    
    NSMutableArray *imageDictionaryArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"]]; //OF NSDictionary
    
    self.imagesArray = [[NSMutableArray alloc]init];
    
    for(NSDictionary *dict in imageDictionaryArray)
    {
        [self.imagesArray addObject:[dict convertToImages]];
    }
    
    [self showImage];
    
    self.languagesArray = @[@"Portuguese", @"English", @"Spanish"];
    self.countriesArray = @[@"PT", @"EN"];
    self.numbersArray = @[@1, @2, @3, @4, @5];
    self.helloArray = @[@"Olá",@"Hello", @"Hola"];
    
    self.helloWordLabel.text = self.helloArray[[self.pickerView selectedRowInComponent:0]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkTextFieldString)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
    
}
- (IBAction)didPreviousButtonPressed:(id)sender
{
    if(self.currentImageIndex == 0)
        self.currentImageIndex = self.imagesArray.count - 1;
    else
        self.currentImageIndex--;
    
    [self showImage];
}

- (IBAction)didNextButtonPressed:(id)sender
{
    if(self.currentImageIndex == self.imagesArray.count - 1)
        self.currentImageIndex = 0;
    else
        self.currentImageIndex++;
    
    [self showImage];
}

-(void)showImage
{
    Images *img = self.imagesArray[self.currentImageIndex];
    self.imgView.image = [UIImage imageNamed:img.name];
    
    self.imageTitle.text = img.title;
}

- (IBAction)didPressCountButton:(UIButton *)sender
{
    self.counterLabel.text = [NSString stringWithFormat:@"%lu", ++self.counter];
}

#pragma mark - UIPickerViewDataSource


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case LanguagesPickerColumn:
            return self.languagesArray.count;
            break;
        case CountriesPickerColumn:
            return self.countriesArray.count;
            break;
        case NumbersPickerColumn:
            return self.numbersArray.count;
        default:
            return 0;
            break;
    }
    
    return self.languagesArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (component) {
        case LanguagesPickerColumn:
            return self.languagesArray[row];
            break;
        case CountriesPickerColumn:
            return self.countriesArray[row];
            break;
        case NumbersPickerColumn:
            return [NSString stringWithFormat:@"%lu", [(NSNumber*)self.numbersArray[row] integerValue]];
        default:
            return nil;
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case LanguagesPickerColumn:
            return 170;
            break;
        case CountriesPickerColumn:
            return 70;
            break;
        case NumbersPickerColumn:
            return 70;
        default:
            return 0;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case LanguagesPickerColumn:
            self.helloWordLabel.text = self.helloArray[row];
            break;
        case CountriesPickerColumn:
            //return self.countriesArray[row];
            break;
        default:
            //return nil;
            break;
    }
}


#pragma mark UITextField

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)checkTextFieldString
{
    if([self.textField.text isEqualToString:@"ironhack"])
        self.counterLabel.text = @"YEAH!";
    else if([self.textField.text isEqualToString:@"show"])
    {
        UIViewController *VC =
        [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"VC"];
        [self showViewController:VC sender:nil];
        
    }
    
    else
        self.counterLabel.text = @"Ironhack";
}


//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if([textField.text isEqualToString:@"ironhack"])
//        self.counterLabel.text = @"YEAH!";
//    else
//        self.counterLabel.text = @"Ironhack";
//    
//    return YES;
//}




@end
