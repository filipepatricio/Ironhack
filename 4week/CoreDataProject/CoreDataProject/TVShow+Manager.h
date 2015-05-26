//
//  TVShow+Manager.h
//  CoreDataProject
//
//  Created by Filipe Patrício on 26/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "TVShow.h"
#import "CoreDataStack.h"

@interface TVShow (Manager)

+(TVShow*)createTVShowWithTitle:(NSString *)title numberOfSeasons:(NSInteger)numberOfSeasons;
+(TVShow*)getTVShowWithTitle:(NSString *)title;
+(NSArray*)getAllTVShows;

@end
