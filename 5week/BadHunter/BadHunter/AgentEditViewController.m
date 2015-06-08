//
//  DetailViewController.m
//  BadHunter
//
//  Created by Filipe Patrício on 03/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "AgentEditViewController.h"
#import <CoreData/CoreData.h>
#import "Agent+Model.h"
#import "ImageMapper.h"
#import "FreakType+Model.h"
#import "Domain+Model.h"

@interface AgentEditViewController ()<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *baddieNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *destroyPowerLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *motivationLabel;
@property (weak, nonatomic) IBOutlet UILabel *appraisalLabel;

@property (copy, nonatomic) NSArray *destroyPowerLevels; //Of NSString
@property (copy, nonatomic) NSArray *motivationValues; //Of NSString
@property (copy, nonatomic) NSArray *appraisalValues;

@property (weak, nonatomic) IBOutlet UIStepper *destructionPowerStepper;
@property (weak, nonatomic) IBOutlet UIStepper *motivationStepper;

@property (weak, nonatomic) IBOutlet UIButton *buttonAddImage;

@property (weak, nonatomic) IBOutlet UITextField *domainsTextField;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;

@end

@implementation AgentEditViewController

-(NSArray *)destroyPowerLevels
{
    if(!_destroyPowerLevels)
        _destroyPowerLevels = @[@"Soft", @"Weak", @"Potential", @"Destroyer", @"Nuke"];
    return _destroyPowerLevels;
}

-(NSArray *)motivationValues
{
    if(!_motivationValues)
        _motivationValues = @[@"Doesn't care", @"Would like to", @"Quite", @"Interested", @"Focused"];
    return _motivationValues;
}

-(NSArray *)appraisalValues
{
    if(!_appraisalValues)
        _appraisalValues = @[@"No way", @"Better not", @"Maybe", @"Yes", @"A must"];
    return _appraisalValues;
}

- (IBAction)actionSave:(id)sender
{
    
    //Fill the changes on object KVC
    self.agent.name = self.baddieNameTextField.text;
    
    BOOL categoryExists = [FreakType getFreakTypeByName:self.categoryTextField.text inMOC:self.agent.managedObjectContext] != nil;
    if(!categoryExists)
        self.agent.category = [FreakType addNewFreakTypeWithName:self.categoryTextField.text inMOC:self.agent.managedObjectContext];
    
    NSArray *words = [self.domainsTextField.text componentsSeparatedByString:@","];
    NSMutableSet *mutableSet = [self.agent.domains mutableCopy];
    for (NSString *word in words)
    {
        Domain *domain = [Domain getDomainByName:word inMOC:self.agent.managedObjectContext];
        BOOL domainExists = domain != nil;
        !domainExists ? [mutableSet addObject:[Domain addNewDomainWithName:word inMOC:self.agent.managedObjectContext]] : nil;
    }
    self.agent.domains = [mutableSet copy];
    
    [self.delegate didModifiedData:YES];
}

- (IBAction)actionCancel:(id)sender
{
    [self.delegate didModifiedData:NO];
}

- (IBAction)actionDestructionPowerValueChanged:(UIStepper *)sender
{
    NSNumber *value = [NSNumber numberWithDouble:sender.value];
    self.agent.destructionPower = value;
    NSLog(@"%@", value);
}

- (IBAction)actionMotivationPowerValueChanged:(UIStepper *)sender
{
    NSNumber *value = [NSNumber numberWithDouble:sender.value];
//    self.motivationLabel.text = self.motivationValues[[value integerValue]];
    self.agent.motivation = value;
    NSLog(@"%@", value);
}

#pragma mark - Managing the detail item

- (void)setAgent:(id)newDetailItem {
    if (_agent != newDetailItem) {
        _agent = newDetailItem;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.destructionPowerStepper.minimumValue = 0;
    self.destructionPowerStepper.maximumValue = self.destroyPowerLevels.count - 1;
    self.motivationStepper.minimumValue = 0;
    self.motivationStepper.maximumValue = self.motivationValues.count - 1;
    
    self.destructionPowerStepper.value = self.agent.destructionPower.intValue;
    self.motivationStepper.value = self.agent.motivation.intValue;

    self.baddieNameTextField.text = self.agent.name;
    self.appraisalLabel.text = self.appraisalValues[self.agent.appraisal.intValue];
    self.destroyPowerLevelLabel.text = self.destroyPowerLevels[self.agent.destructionPower.intValue];
    self.motivationLabel.text = self.motivationValues[self.agent.motivation.intValue];
    
    self.categoryTextField.text = ((FreakType*)self.agent.category).name;
    for(Domain *domain in self.agent.domains)
        self.domainsTextField.text = [self.domainsTextField.text stringByAppendingString:[NSString stringWithFormat:@"%@,", domain.name]];
    
    if(self.agent.pictureUUID)
    {
        self.buttonAddImage.backgroundColor = [UIColor colorWithPatternImage:[ImageMapper retrieveImageWithUUID:self.agent.pictureUUID]];
    }

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addObserver:self forKeyPath:@"agent.destructionPower" options:0 context:nil];
    [self addObserver:self forKeyPath:@"agent.motivation" options:0 context:nil];
    [self addObserver:self forKeyPath:@"agent.appraisal" options:0 context:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self removeObserver:self forKeyPath:@"agent.destructionPower"];
    [self removeObserver:self forKeyPath:@"agent.motivation"];
    [self removeObserver:self forKeyPath:@"agent.appraisal"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"agent.destructionPower"])
    {
        NSNumber *value = self.agent.destructionPower;
        self.destroyPowerLevelLabel.text = self.destroyPowerLevels[[value integerValue]];
    }
    else if([keyPath isEqualToString:@"agent.motivation"])
    {
        NSNumber *value = self.agent.motivation;
        self.motivationLabel.text = self.motivationValues[[value integerValue]];
    }
    else if([keyPath isEqualToString:@"agent.appraisal"])
    {
        NSNumber *value = self.agent.appraisal;
        self.appraisalLabel.text = self.appraisalValues[[value integerValue]];
    }
}

- (IBAction)actionAddImage:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField == self.domainsTextField)
    {
        NSArray *words = [self.domainsTextField.text componentsSeparatedByString:@","];
        NSMutableArray *values = [[NSMutableArray alloc]init];
        for (NSString *word in words)
        {
            BOOL exists = [Domain getDomainByName:word inMOC:self.agent.managedObjectContext] != nil;
            [values addObject:[NSNumber numberWithBool:exists]];
        }
        [self decorateTextField:self.domainsTextField withContents:words values:[values copy]];
    }
    else if(textField == self.categoryTextField)
    {
        BOOL exists = [FreakType getFreakTypeByName:textField.text inMOC:self.agent.managedObjectContext] != nil;
        [self decorateTextField:self.categoryTextField withContents:@[self.categoryTextField.text] values:@[[NSNumber numberWithBool:exists]]];
    }
    
    return [textField resignFirstResponder];;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    if(textField == self.domainsTextField)
//    {
//        [self removeDecorationOfTextInTextField:textField];
//    }
//    else if(textField == self.categoryTextField)
//    {
        [self removeDecorationOfTextInTextField:textField];
//    }
    return YES;
}


- (void) decorateTextField:(UITextField *)textField withContents:(NSArray *)contents
                    values:(NSArray *)values {
    NSMutableAttributedString *coloredString = [[NSMutableAttributedString alloc] init];
    for (NSUInteger i = 0; i < [contents count]; i++) {
        BOOL exists = [[values objectAtIndex:i] boolValue];
        NSString *substring = [contents objectAtIndex:i];
        UIColor *decorationColor = (exists)?[UIColor greenColor]:[UIColor redColor];
        NSAttributedString *attributedSubstring = [[NSAttributedString alloc] initWithString:substring attributes:@{NSForegroundColorAttributeName: decorationColor}];
        [coloredString appendAttributedString:attributedSubstring];
        if (i < ([contents count] - 1)) {
            [coloredString appendAttributedString:[[NSAttributedString alloc] initWithString:@","]];
        }
    }
    textField.attributedText = coloredString;
}

- (void) removeDecorationOfTextInTextField:(UITextField *)textField {
    textField.attributedText = [[NSAttributedString alloc] initWithString:textField.text
                                                               attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
}

#pragma mark UIImagePickerController

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imageChosen = (UIImage*)info[UIImagePickerControllerOriginalImage];
    NSString *pictureUUID = [self.agent generatePictureUUID];
    [ImageMapper storeImage:imageChosen withUUID:pictureUUID];
    self.agent.pictureUUID = pictureUUID;
    self.buttonAddImage.backgroundColor = [UIColor colorWithPatternImage:[ImageMapper retrieveImageWithUUID:self.agent.pictureUUID]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
