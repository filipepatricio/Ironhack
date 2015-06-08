//
//  ViewControllerTests.m
//  Testing
//
//  Created by Filipe Patrício on 05/06/15.
//  Copyright (c) 2015 Joan Romano. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>

#import "ViewController.h"
@interface ViewControllerTests : XCTestCase
@property(strong, nonatomic) ViewController *sut;
@end

@implementation ViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    self.sut = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    self.sut = nil;
    
    [super tearDown];
}

-(void)testSutIsNotNil
{
    XCTAssertNotNil(self.sut, @"Sut should not be nil");
}


-(void)testRandomStringIsNotNil
{
    NSString *string;
    string = [self.sut randomAlphanumericStringWithLength:10];
    XCTAssertNotNil(string, @"Random string should not be nil");
}

-(void)testRandomStringLenghtOfFive
{
    NSString *string;
    string = [self.sut randomAlphanumericStringWithLength:5];
    XCTAssertEqual(string.length, 5, @"Random string should be 5");
}


- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
