//
//  FakeCellAdapter.h
//  Testing
//
//  Created by Filipe Patrício on 05/06/15.
//  Copyright (c) 2015 Joan Romano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellAdapterProtocol.h"

@interface FakeCellAdapter : NSObject<CellAdapterProtocol>

- (id)cellForTableView:(UITableView *)tableView item:(id)item atIndexPath:(NSIndexPath *)indexPath;
- (void)registerClassOrNibForTableView:(UITableView *)tableView;

@end
