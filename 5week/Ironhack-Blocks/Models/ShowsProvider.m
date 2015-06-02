//
//  ShowsProvider.m
//  Models
//
//  Created by Filipe Patrício on 02/06/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

#import "ShowsProvider.h"
#import "RequestManager.h"
#import "Show.h"

@implementation ShowsProvider

+(void)getShowsWithBlock:(GetShowsBlock)showsDictionary
{
    
    [RequestManager requestFromURL:[NSURL URLWithString:@"http://ironhack4thweek.s3.amazonaws.com/shows.json"]
                            success:^(id responseObject) {
                                
                                NSDictionary *JSONDictionary = responseObject;
                                NSMutableArray *shows = [[NSMutableArray alloc]init];
                                for (NSDictionary *tvshowDictionary in [JSONDictionary valueForKey:@"shows"]) {
                                    NSError *parseError;
                                    Show *showItem = [MTLJSONAdapter modelOfClass:[Show class] fromJSONDictionary:tvshowDictionary error:&parseError];
                                    if (parseError) {
                                        NSLog(@"%@",parseError);
                                    }
                                    [shows addObject:showItem];
                                }
                                
                                showsDictionary([shows copy]);
                                
                            } failure:^(NSError *error) {
                                NSLog(@"%@", error);
                            }];
    
}

@end
