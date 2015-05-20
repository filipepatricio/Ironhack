//
//  CharactersViewController.m
//  ComplicatedModel
//
//  Created by Georgios Pessios on 5/14/15.
//  Copyright (c) 2015 Georgios Pessios. All rights reserved.
//

#import "CharactersViewController.h"
#import "CharacterModel.h"
#import "GeorgeCell.h"
#import "FormViewController.h"
#import "EditCharacterViewController.h"

@interface CharactersViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) NSArray *characters;

@end

@implementation CharactersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.characters = [CharacterModel allCharacters];
}

#pragma mark - UITableViewDataSource Protocol required methods implementation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.characters count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GeorgeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CHARACTER"];
    CharacterModel *oneCharacter = self.characters[indexPath.row];
    cell.nameOfCharacter.text= oneCharacter.name;
    
    UIImage *showImage = [UIImage imageNamed:oneCharacter.image];
    cell.imageOfCharacter.image = showImage;;
    
    return cell;
}


#pragma mark - UITableViewDataSource Protocol required methods implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



#pragma mark - FormViewControllerDelegate

-(void)didCreateCharacter:(CharacterModel *)model
{
    //ADD NEW CHARACTER - UPDATING OUR MODEL DATA
    NSMutableArray* mutableCharacters =
        [self.characters mutableCopy];
    [mutableCharacters addObject: model];
    
    self.characters = [mutableCharacters copy];
    
    //UPDATING THE VIEW
    [self.tableView reloadData];
    
    [self saveCharactersToDisc];
}



-(void)saveCharactersToDisc
{
    NSMutableArray* convertedCharacters =
        [NSMutableArray array];
    
    //TODO: add converting the model to dictionary here
    
    for(CharacterModel *model in self.characters)
    {
        NSDictionary *convertedModel = [model toDictionary];
        [convertedCharacters addObject:convertedModel];
    }
    
    //NOW convertedShows CONTAINS ONLY STRINGS, NUMBERS,
    //ARRAYS AND DICTIONARY
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = paths.firstObject;
    // documentsDirectory is smth like "/user/Marin/documents"
    
    NSString *destinationPath = [documentsDirectory
                                 stringByAppendingPathComponent:
                                 @"data.plist"];
    
    //NOW TELL THE ARRAY TO SAVE
    [convertedCharacters writeToFile:destinationPath
                     atomically:YES];
    
    [self.tableView reloadData];
    
}

#pragma mark - EditCharacterDelegate

-(void)viewController:(UIViewController*)viewController editedCharacter:(CharacterModel*)character indexPath:(NSIndexPath*)indexPath
{
    
    NSMutableArray *charactersMutableCopy = [self.characters mutableCopy];
    charactersMutableCopy[indexPath.row] = character;
    
    self.characters = [charactersMutableCopy copy];
    
    [self saveCharactersToDisc];
}

-(void)viewController:(UIViewController*)viewController deletedCharacter:(CharacterModel*)character indexPath:(NSIndexPath*)indexPath
{
    NSMutableArray *charactersMutableCopy = [self.characters mutableCopy];
    [charactersMutableCopy removeObjectAtIndex:indexPath.row];
    
    self.characters = [charactersMutableCopy copy];
    
    [self saveCharactersToDisc];
    
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddSegue"]) {

        FormViewController* formVC =
            segue.destinationViewController;
        formVC.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"EditCharacter"]) {
        
        EditCharacterViewController * editVC =
        segue.destinationViewController;
        editVC.delegate = self;
        editVC.indexPath = self.tableView.indexPathForSelectedRow;
        editVC.character = self.characters[editVC.indexPath.row];

    }
}

@end
