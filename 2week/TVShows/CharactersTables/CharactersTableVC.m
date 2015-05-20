//
//  CharactersTableVC.m
//  CharactersTables
//
//  Created by Filipe Patrício on 14/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "CharactersTableVC.h"
#import "CharacterModel.h"
#import "CharacterTableViewCell.h"
#import "AddCharacterVC.h"

@interface CharactersTableVC ()<UINavigationControllerDelegate, AddCharacterViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *charactersTableView;


@end

@implementation CharactersTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.show.name;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.show.characters.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%@ Characters", self.show.name];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CharacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CharacterCell" forIndexPath:indexPath];
    
    CharacterModel *character = self.show.characters[indexPath.row];
    cell.nameLabel.text = character.name;
    cell.photoView.image = [UIImage imageNamed:character.imageName];
    
    return cell;
}

#pragma mark - FormViewControllerDelegate
-(void)formViewController:(AddCharacterVC *)addCharacterVC didCreateCharacter:(CharacterModel *)character
{
    NSMutableArray *mutableCopyOfCharacterArray = [self.show.characters mutableCopy]; //Returns NSMutableArray
    
    [mutableCopyOfCharacterArray addObject:character];
    
    self.show.characters = [mutableCopyOfCharacterArray copy]; //Returns NSArray
    
    [self.charactersTableView reloadData];

}

-(void)saveCharactersToDisk
{
    NSMutableArray *convertedShows = [NSMutableArray array];
    
#warning TODO: implement save to the disk
    
//    for (ShowModel *show in )
//    {
//        NSDictionary *showDictionary = [show toDictionary];
//        [convertedShows addObject:showDictionary];
//    }
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = paths.firstObject;
//    
//    NSString *destinationPath =[documentsDirectory stringByAppendingString:@"NewShows.plist"];
//    //destinationPath is "/user/filipe/Documents/NewShows.plist"
//    
//    [convertedShows writeToFile:destinationPath atomically:YES];
}


#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"AddCharacterSegue"])
    {
        AddCharacterVC *addCharacterVC = segue.destinationViewController;
        addCharacterVC.delegate = self;
    }
    
}


@end
