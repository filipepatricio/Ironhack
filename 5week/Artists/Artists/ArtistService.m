//
//  ArtistService.m
//  Artists
//
//  Created by Filipe Patrício on 01/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ArtistService.h"
#import "ArtistModel.h"

@implementation ArtistService
+ (void)artistsWithCompletion:(void (^)(NSArray *))completion
{
    
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES )[0];
    NSString *filePath = [documentsPath stringByAppendingString:@"/artists.plist"];
    NSLog(@"%@",filePath);
    
    __block NSMutableSet *artistSet = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    if(artistSet)
        completion([artistSet allObjects]);

    artistSet = [[NSMutableSet alloc]init];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"https://ironhackartists.firebaseio.com/artists.json"];
    
    [[urlSession dataTaskWithURL:url
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   
                   if(!error)
                   {
                       NSDictionary *artistsJSONArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                       NSLog(@"%@", artistsJSONArray);
                       

                       
                       for (NSDictionary *artistDictionary in artistsJSONArray) {
                           ArtistModel *artist = [[ArtistModel alloc] init];
                           @try {
                               
                               artist.artistID = [artistDictionary[@"id"] longValue];
                               artist.name = artistDictionary[@"name"];
                               artist.stage = artistDictionary[@"stage"];
                               artist.longDescription = artistDictionary[@"description"];
                               artist.imageURL = [NSURL URLWithString:artistDictionary[@"image_url"]];
                               
                               // Convert string to date object
                               NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                               [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
                               NSDate *date = [dateFormat dateFromString:artistDictionary[@"start_date"]];
                               
                               artist.startDate = date;
                               
                               [artistSet addObject:artist];
                           }
                           @catch (NSException *exception) {
                               NSLog(@"Expected format");
                           }
                           @finally {
                               
                           }
                           
                       }
                       
                       //TODO: parse to ArtistModel first -> put into NSArray // Of Artists and call completion block with that array
                       
                       dispatch_async(dispatch_get_main_queue(), ^{
                           //it should be on the main thread because the receiver Might use UIKit
                           completion([artistSet allObjects] );
                       });
                       
                       NSLog(@"%d", [NSKeyedArchiver archiveRootObject:artistSet toFile:filePath]);
                       
                   }
                   else
                       NSLog(@"%@", error);
                   
                   
                   
                   
               }] resume];
    
}
@end
