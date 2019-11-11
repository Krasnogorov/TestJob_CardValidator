//
//  CardValidatorFrameworkTests.m
//  CardValidatorFrameworkTests
//
//  Created by Sergey Krasnogorov on 11/10/19.
//  Copyright © 2019 Sergey Krasnogorov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CardValidatorFramework/CardValidatorFramework.h>

@interface CardValidatorFrameworkTests : XCTestCase

@end

@implementation CardValidatorFrameworkTests

- (void)testValidLocalTests{
    XCTAssertTrue([CardValidator validateCardLocal:@"4929804463622139"]);
    XCTAssertTrue([CardValidator validateCardLocal:@"6762765696545485"]);
    
}

- (void)testInvalidLocalTests{
    XCTAssertFalse([CardValidator validateCardLocal:@"4929804463622138"]);
    XCTAssertFalse([CardValidator validateCardLocal:@"0"]);
    XCTAssertFalse([CardValidator validateCardLocal:@"6762765696545485123456789"]);
    XCTAssertFalse([CardValidator validateCardLocal:@"676276569654548512345678asd9"]);
}

- (void)testValidServerTests{
    [CardValidator validateCardOnline:@"4929804463622139" callback:^(Card * _Nonnull result, NSString * _Nonnull errorMessage) {
        XCTAssertNotNil(result);
    }];
    [CardValidator validateCardOnline:@"6762765696545485" callback:^(Card * _Nonnull result, NSString * _Nonnull errorMessage) {
        XCTAssertNotNil(result);
    }];
}
- (void)testInvalidServerTests{
    [CardValidator validateCardOnline:@"4929804463622138" callback:^(Card * _Nonnull result, NSString * _Nonnull errorMessage) {
        XCTAssertNil(result);
    }];
    [CardValidator validateCardOnline:@"4929804463622138" callback:^(Card * _Nonnull result, NSString * _Nonnull errorMessage) {
        XCTAssertNil(result);
    }];
}

- (void)testValidFullTests{
    [CardValidator validateCardFull:@"4929804463622139" callback:^(Card *result, NSString *errorMessage) {
        XCTAssertNotNil(result);
    }];
    [CardValidator validateCardFull:@"6762765696545485" callback:^(Card *result, NSString *errorMessage) {
        XCTAssertNotNil(result);
    }];
}

- (void)testInalidFullTests{
    [CardValidator validateCardFull:@"4929804463622138" callback:^(Card *result, NSString *errorMessage) {
        XCTAssertNil(result);
    }];
    [CardValidator validateCardFull:@"0" callback:^(Card *result, NSString *errorMessage) {
        XCTAssertNil(result);
    }];
    [CardValidator validateCardFull:@"6762765696545485123456789" callback:^(Card *result, NSString *errorMessage) {
        XCTAssertNil(result);
    }];
}
@end
