//
//  DetailViewController.h
//  BadHunter
//
//  Created by Filipe Patrício on 03/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditDataProtocol <NSObject>
@required
-(void)didModifiedData:(BOOL)didModifiedData;
@end

@interface AgentEditViewController : UIViewController

@property (weak, nonatomic) id<EditDataProtocol> delegate ;
@property (strong, nonatomic) id agent;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

