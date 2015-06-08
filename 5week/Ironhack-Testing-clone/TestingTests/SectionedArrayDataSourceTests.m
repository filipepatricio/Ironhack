//
//  SectionedArrayDataSourceTests.m
//  Testing
//
//  Created by Filipe Patrício on 05/06/15.
//  Copyright (c) 2015 Joan Romano. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SectionedArrayDataSource.h"
#import "FakeCellAdapter.h"

@interface SectionedArrayDataSourceTests : XCTestCase
@property (strong, nonatomic) SectionedArrayDataSource *sut;
@property (strong, nonatomic) UITableView *fakeTableView;
@property (strong, nonatomic) FakeCellAdapter *fakeCellAdapter;
@end

@implementation SectionedArrayDataSourceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.fakeTableView = [[UITableView alloc] init];
    self.fakeCellAdapter = [[FakeCellAdapter alloc] init];
    self.sut = [[SectionedArrayDataSource alloc] initWithTableView:self.fakeTableView
                                                       cellAdapter:self.fakeCellAdapter];
    
}

- (void)tearDown {
    
    self.fakeCellAdapter = nil;
    self.fakeTableView = nil;
    self.sut = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

-(void)testIfSUTIsNil
{
    XCTAssertNotNil(self.sut, @"sut shouldn't be nil");
}

-(void)testTableViewDataSourceIsEqualSutTableViewDataSource
{
    XCTAssertEqual(self.fakeTableView.dataSource, self.sut  ,@"Data source should be the same");
}

-(void)testNoItems
{
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.fakeTableView], 0, @"should be zero");
    XCTAssertEqual([self.sut tableView:self.fakeTableView numberOfRowsInSection:0], 0, @"should be zero");
}

-(void)testHasSectionWith3rows
{
    self.sut.items = @[@[@"a",
                         @"b",
                         @"c",
                         ],
                       ];
    
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.fakeTableView], 1, @"Sections should be 1");
    XCTAssertEqual([self.sut tableView:self.fakeTableView numberOfRowsInSection:0], 3,@"Number of Rows should be 3");
}

-(void)testHas2SectionWith3rows
{
    self.sut.items = @[@[@"a",
                         @"b",
                         @"c",
                         ],
                       @[@"e",
                         @"f",
                         @"g",
                         ],
                       ];
    
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.fakeTableView], 2, @"Sections should be 1");
    for(int i = 0; i < self.sut.items.count; i++)
        XCTAssertEqual([self.sut tableView:self.fakeTableView numberOfRowsInSection:i], 3,@"Number of Rows should be 3");
    
}

-(void)testHas2SectionWith2RowsOnFirst6RowsOnSecond
{
    self.sut.items = @[@[@"a",
                         @"b",
                         ],
                       @[@"c",
                         @"d",
                         @"e",
                         @"f",
                         @"g",
                         @"h",
                         ],
                       ];
    
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.fakeTableView], 2, @"Sections should be 1");
    XCTAssertEqual([self.sut tableView:self.fakeTableView numberOfRowsInSection:0], 2,@"Number of Rows should be 2");
    XCTAssertEqual([self.sut tableView:self.fakeTableView numberOfRowsInSection:1], 6,@"Number of Rows should be 6");
    
}

-(void)testChange3timesItems
{
    self.sut.items = @[@[@"a",
                         @"b",
                         @"c",
                         ],
                       ];
    
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.fakeTableView], 1, @"Sections should be 1");
    XCTAssertEqual([self.sut tableView:self.fakeTableView numberOfRowsInSection:0], 3,@"Number of Rows should be 3");
    
    self.sut.items = @[@[@"a",
                         @"b",
                         @"c",
                         ],
                       @[@"e",
                         @"f",
                         @"g",
                         ],
                       ];
    
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.fakeTableView], 2, @"Sections should be 1");
    for(int i = 0; i < self.sut.items.count; i++)
        XCTAssertEqual([self.sut tableView:self.fakeTableView numberOfRowsInSection:i], 3,@"Number of Rows should be 3");
    
    self.sut.items = @[@[@"a",
                         @"b",
                         ],
                       @[@"c",
                         @"d",
                         @"e",
                         @"f",
                         @"g",
                         @"h",
                         ],
                       ];
    
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.fakeTableView], 2, @"Sections should be 1");
    XCTAssertEqual([self.sut tableView:self.fakeTableView numberOfRowsInSection:0], 2,@"Number of Rows should be 2");
    XCTAssertEqual([self.sut tableView:self.fakeTableView numberOfRowsInSection:1], 6,@"Number of Rows should be 6");
}

-(void)testValidIndexPath
{
    self.sut.items = @[@[@"a",
                         @"b",
                         @"c",
                         ],
                       ];
    
    XCTAssertNotNil([self.sut itemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]],@"Shouldn't be nil");
}

-(void)testInvalidIndexPath
{
    self.sut.items = @[@[@"a",
                         @"b",
                         @"c",
                         ],
                       ];
    
    XCTAssertNil([self.sut itemAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:0]],@"Should be nil");
}

-(void)testInvalidValueOfItems
{
    
    XCTAssertThrowsSpecificNamed(self.sut.items = @[@"wrong object"], NSException, NSInvalidArgumentException, @"Should throw an exception");
    
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
