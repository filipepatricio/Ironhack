//
//  FakeCellAdapter.m
//  Testing
//
//  Created by Filipe Patrício on 05/06/15.
//  Copyright (c) 2015 Joan Romano. All rights reserved.
//

#import "FakeCellAdapter.h"

@implementation FakeCellAdapter
- (id)cellForTableView:(UITableView *)tableView item:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}

- (void)registerClassOrNibForTableView:(UITableView *)tableView
{
    
}
@end
