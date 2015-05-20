//
//  Header.h
//  TestPerson
//
//  Created by Filipe Patrício on 04/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#ifndef TestPerson_Header_h
#define TestPerson_Header_h

@protocol ChangeNameDelegate <NSObject>

-(void)didChangeName:(NSString*)newName;

@end

#endif
