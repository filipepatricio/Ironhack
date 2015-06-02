//
//  ShowsProvider.h
//  Models
//
//  Created by Filipe Patrício on 02/06/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^GetShowsBlock)(NSArray* shows);

@interface ShowsProvider : NSObject
+(void)getShowsWithBlock:(GetShowsBlock)showsDictionary;
@end
