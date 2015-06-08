//
//  Agent+Model.h
//  BadHunter
//
//  Created by Filipe Patrício on 04/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "Agent.h"

#define kKeyAppraisal           @"appraisal"
#define kKeyDestructionPower    @"destructionPower"
#define kKeyMotivation          @"motivation"

@interface Agent (Model)
- (NSString *) generatePictureUUID;
+ (NSFetchRequest*)fetchForAllAgents;
+ (NSFetchRequest*)fetchForAllAgentsWithPredicate:(NSPredicate*)predicate;
+(NSFetchRequest*)fetchForAllAgentsWithSortDescriptors:(NSArray*)sortDescriptors;
@end
