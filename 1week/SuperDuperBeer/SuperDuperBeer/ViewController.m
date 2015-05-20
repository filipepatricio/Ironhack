//
//  ViewController.m
//  SuperDuperBeer
//
//  Created by Filipe Patrício on 08/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"
#import "Beer.h"
#import "DetailsVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *beerImage;
@property (nonatomic, strong) NSMutableArray *beersArray;   //Of Beer
@property (nonatomic) NSUInteger currentBeerIndex;
@property (nonatomic) NSString *beersFile;
@end

@implementation ViewController

-(NSString*)beersFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    _beersFile = [documentsDirectory stringByAppendingPathComponent:@"beers.plist"];
    return _beersFile;
}

-(NSMutableArray*)beersArray
{
    NSMutableArray *arrayFromFile = [NSKeyedUnarchiver unarchiveObjectWithFile:self.beersFile];
    if(arrayFromFile)
    {
        _beersArray = arrayFromFile;
    }
    else if(!_beersArray)
    {
        _beersArray = [[NSMutableArray alloc]init];

        
        if(_beersArray.count == 0)
        {
            NSArray *beersPList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Beers" ofType:@"plist"]]; //Of NSDictionary
            for(NSDictionary *dict in beersPList)
            {
                
                [_beersArray addObject:[[Beer alloc] initWithName: dict[kKeyName]
                                                    withCountryID: [(NSNumber*)dict[kKeyCountryID] integerValue]
                                                    withImageName: dict[kKeyImageName]
                                               withAlcoholPercent: [(NSNumber*)dict[kKeyAlcoholPercent] integerValue]]];
            }
        }
    }
    
    return _beersArray;
}

- (void)showBeer
{
    // Do any additional setup after loading the view, typically from a nib.
    Beer *currentBeer = self.beersArray[self.currentBeerIndex];
    self.beerImage.image = [UIImage imageNamed:currentBeer.imageName];
    self.navigationController.navigationBar.topItem.title = currentBeer.name;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentBeerIndex = [(NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:@"currentBeerIndex"] longValue];
    
    [self showBeer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveSettings)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
}

- (void)saveSettings
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLong:self.currentBeerIndex] forKey:@"currentBeerIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)previousButtonPressed:(id)sender
{
    if(self.currentBeerIndex == 0)
        self.currentBeerIndex = self.beersArray.count - 1;
    else
        self.currentBeerIndex--;
    
    [self showBeer];
}

- (IBAction)nextButtonPressed:(id)sender
{
    if(self.currentBeerIndex == self.beersArray.count - 1)
        self.currentBeerIndex = 0;
    else
        self.currentBeerIndex++;
    
    [self showBeer];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Details Segue"])
    {
        DetailsVC *detailsVC = [segue destinationViewController];
        detailsVC.currentBeerIndex = self.currentBeerIndex;
        detailsVC.beersArray = self.beersArray;
        detailsVC.beersFile = self.beersFile;
        [self saveSettings];
    }
}


@end
