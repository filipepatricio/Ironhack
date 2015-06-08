//
//  SectionedArrayDataSource.h
//  Testing
//
//  Created by Joan Romano on 6/4/15.
//  Copyright (c) 2015 Joan Romano. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CellAdapterProtocol.h"

@interface SectionedArrayDataSource : NSObject <UITableViewDataSource>

/**
 The items that the table view should display. Setting this property will cause de table view to reload.
 
 NOTE: It is assumed that format of this property will be an array of arrays (sections)
 */
@property (nonatomic, copy) NSArray *items;

/**
 The item at the corresponding index path.
 
 @param indexPath The index path to retrieve the item from
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (instancetype)initWithTableView:(UITableView *)tableView cellAdapter:(id <CellAdapterProtocol>)cellAdapter NS_DESIGNATED_INITIALIZER;

@end
