//
//  PersistenceManager.m
//  Copying
//
//  Created by Filipe Patrício on 25/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "PersistenceManager.h"
#import "MovieModel.h"
#import "TVShowModel.h"

@implementation PersistenceManager

+(NSString *)pathForFileWithClass:(Class)aClass
{
    //NSCachesDirectory - it may be erasable
    //NSDocumentDirectory - it's permanent
    
    NSString *filename = [NSString stringWithFormat:@"/%@.plist", NSStringFromClass(aClass) ];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return [documentsDirectory stringByAppendingString:filename];
}

+(void)copyObjectFromArray:(NSMutableArray *)array index:(NSInteger)index
{
    id object = array[index];
    
    id copyObject = [object copy];
    
    if([object respondsToSelector:@selector(title )])
    {
        NSString *title = (NSString *)[copyObject title];
        
        title = [title stringByAppendingString:@" (Copied)"];
        [copyObject setTitle:title];
    }
    
    NSLog(@"%d", [copyObject isEqual:object]);
    
    [array insertObject:copyObject atIndex:index+1];
    
    //SAVE movies from documents directory
    [NSKeyedArchiver archiveRootObject:array toFile:[PersistenceManager pathForFileWithClass:[copyObject class]]];
}

@end
