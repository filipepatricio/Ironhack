//
//  DetailViewController.m
//  BadHunter
//
//  Created by Filipe Patrício on 03/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "AgentEditViewController.h"
#import <CoreData/CoreData.h>

@interface AgentEditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *baddieNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *destroyPowerLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *motivationLabel;
@property (weak, nonatomic) IBOutlet UILabel *appraisalLabel;

@property (copy, nonatomic) NSArray *destroyPowerLevels; //Of NSString
@property (copy, nonatomic) NSArray *motivationValues; //Of NSString
@property (copy, nonatomic) NSArray *appraisalValues;

@property (weak, nonatomic) IBOutlet UIStepper *destructionPowerStepper;
@property (weak, nonatomic) IBOutlet UIStepper *motivationStepper;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
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
    NSManagedObject *object = self.agent;
    [object setValue:self.baddieNameTextField.text forKey:@"name"];
    [object setValue:[NSNumber numberWithDouble:self.destructionPowerStepper.value] forKey:@"destructionPower"];
    [object setValue:[NSNumber numberWithDouble:self.motivationStepper.value] forKey:@"motivation"];
    
    [self.delegate didModifiedData:YES];
}

- (IBAction)actionCancel:(id)sender
{
    [self.delegate didModifiedData:NO];
}

- (IBAction)actionDestructionPowerValueChanged:(UIStepper *)sender
{
    NSNumber *value = [NSNumber numberWithDouble:sender.value];
    self.destroyPowerLevelLabel.text = self.destroyPowerLevels[[value integerValue]];
    NSLog(@"%@", value);
}

- (IBAction)actionMotivationPowerValueChanged:(UIStepper *)sender
{
    NSNumber *value = [NSNumber numberWithDouble:sender.value];
    self.motivationLabel.text = self.motivationValues[[value integerValue]];
    NSLog(@"%@", value);
}

#pragma mark - Managing the detail item

- (void)setAgent:(id)newDetailItem {
    if (_agent != newDetailItem) {
        _agent = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.agent) {
        self.detailDescriptionLabel.text = [[self.agent valueForKey:@"name"] description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    self.navigationItem.leftBarButtonItem = self.cancelButton;
    
    self.appraisalLabel.text = self.appraisalValues[0];
    self.destroyPowerLevelLabel.text = self.destroyPowerLevels[0];
    self.motivationLabel.text = self.motivationValues[0];
    
    self.destructionPowerStepper.minimumValue = 0;
    self.destructionPowerStepper.maximumValue = self.destroyPowerLevels.count - 1;
    self.motivationStepper.minimumValue = 0;
    self.motivationStepper.maximumValue = self.motivationValues.count - 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
