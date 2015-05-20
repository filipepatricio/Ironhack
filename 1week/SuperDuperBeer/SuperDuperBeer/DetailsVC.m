//
//  DetailsVC.m
//  SuperDuperBeer
//
//  Created by Filipe Patrício on 08/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "DetailsVC.h"
#import "Country.h"

@interface DetailsVC ()
@property (weak, nonatomic) IBOutlet UIImageView *beerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *countryFlagImageView;
@property (weak, nonatomic) IBOutlet UILabel *alcoholLabel;
@property (nonatomic, strong) NSMutableArray *countriesArray;   //Of Country
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (strong, nonatomic) UIBarButtonItem *rightBarButton;
@property (weak, nonatomic) IBOutlet UITextField *beerNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UITextField *alcoholTextField;
@end

@implementation DetailsVC


-(NSMutableArray*)countriesArray
{
    
    if(!_countriesArray)
    {
        _countriesArray = [[NSMutableArray alloc]init];
        NSArray *beersPList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Countries" ofType:@"plist"]]; //Of NSDictionary
        for(NSDictionary *dict in beersPList)
        {
            [_countriesArray addObject:[[Country alloc] initWithCountryID:[(NSNumber*)dict[kKeyCountryID] integerValue]
                                                                 withName: dict[kKeyName]
                                                             withFlagIcon: dict[kKeyFlagIcon]]];
        }
    }
    return _countriesArray;
}

- (void)showBeer
{
    // Do any additional setup after loading the view, typically from a nib.
    
    Beer *currentBeer = self.beersArray[self.currentBeerIndex];
    Country *currentBeerCountry = (Country*)self.countriesArray[currentBeer.countryID];
    
    self.beerImage.image = [UIImage imageNamed:currentBeer.imageName];
    self.navigationController.navigationBar.topItem.title = currentBeer.name;
    self.nameLabel.text = currentBeer.name;
    self.countryLabel.text = currentBeerCountry.name;
    self.countryFlagImageView.image = [UIImage imageNamed:currentBeerCountry.flagIcon];
    self.alcoholLabel.text = [NSString stringWithFormat:@"%lu %%", currentBeer.alcoholPercent];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showBeer];
    self.rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonPressed:)];
    self.navigationItem.rightBarButtonItem = self.rightBarButton;
}

-(IBAction)rightBarButtonPressed:(UIBarButtonItem*)sender
{
    if([sender.title isEqualToString:@"Edit" ])
    {
        self.detailView.hidden = YES;
        self.editView.hidden = NO;
        self.rightBarButton.title = @"Done";
        self.rightBarButton.style = UIBarButtonItemStyleDone;
    }
    else if([sender.title isEqualToString:@"Done"])
    {
        self.detailView.hidden = NO;
        self.editView.hidden = YES;
        self.rightBarButton.title = @"Edit";
        self.rightBarButton.style = UIBarButtonItemStylePlain;
        
        Beer *currentBeer = self.beersArray[self.currentBeerIndex];
        currentBeer.name = self.beerNameTextField.text;
        
        [NSKeyedArchiver archiveRootObject:self.beersArray toFile:self.beersFile];
        
#warning Update Values
        
    }
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
