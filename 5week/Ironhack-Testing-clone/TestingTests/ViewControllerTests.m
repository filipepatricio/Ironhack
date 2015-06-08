//
//  ViewControllerTests.m
//  Testing
//
//  Created by Joan Romano on 6/5/15.
//  Copyright (c) 2015 Joan Romano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ViewController.h"

@interface ViewControllerTests : XCTestCase

@property (nonatomic, strong) ViewController *sut;

@end

@implementation ViewControllerTests

- (void)setUp
{
    [super setUp];
    
    self.sut = [[ViewController alloc] init];
}

- (void)tearDown
{
    self.sut = nil;
    
    [super tearDown];
}

- (void)testSutIsNotNil
{
    XCTAssertNotNil(self.sut, @"SUT should not be nil");
}

- (void)testRandomStringIsNotNil
{
    NSString *string;
    
    string = [self.sut randomAlphanumericStringWithLength:10];
    
    XCTAssertNotNil(string, @"Random string should not be nil");
}

- (void)testRandomStringLengthOfFive
{
    NSString *string;
    
    string = [self.sut randomAlphanumericStringWithLength:5];
    
    XCTAssertEqual(string.length, 5, @"Random string with length 5 should return a string with length of 5");
}

- (void)testRandomStringLengthOfTen
{
    NSString *string;
    
    string = [self.sut randomAlphanumericStringWithLength:10];
    
    XCTAssertEqual(string.length, 10, @"Random string with length 5 should return a string with length of 10");
}

- (void)testTwoRandomStringsEqualLengths
{
    NSString *string1, *string2;
    
    string1 = [self.sut randomAlphanumericStringWithLength:10];
    string2 = [self.sut randomAlphanumericStringWithLength:10];
    
    XCTAssertEqual(string1.length, string2.length, @"Both string should have equal length for a given same length");
}

- (void)testTwoRandomStringsDifferentLengths
{
    NSString *string1, *string2;
    
    string1 = [self.sut randomAlphanumericStringWithLength:10];
    string2 = [self.sut randomAlphanumericStringWithLength:18];
    
    XCTAssertNotEqual(string1.length, string2.length, @"Both string should have different lengths for given different lengths");
}

- (void)testTwoRandomStringsSameLengthDifferent
{
    NSString *string1, *string2;
    
    string1 = [self.sut randomAlphanumericStringWithLength:10];
    string2 = [self.sut randomAlphanumericStringWithLength:10];
    
    XCTAssertFalse([string1 isEqualToString:string2], @"Strings shoul not be equal");
}

@end
