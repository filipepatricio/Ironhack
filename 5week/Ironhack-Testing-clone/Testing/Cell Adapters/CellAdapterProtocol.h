//
//  CellAdapterProtocol.h
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellAdapterProtocol <NSObject>

@required

- (id)cellForTableView:(UITableView *)tableView item:(id)item atIndexPath:(NSIndexPath *)indexPath;
- (void)registerClassOrNibForTableView:(UITableView *)tableView;

@end
