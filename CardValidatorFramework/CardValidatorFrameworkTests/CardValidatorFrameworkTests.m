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
    XCTAssertTrue([CardValidator ValidateCardLocal:@"4929804463622139"]);
    XCTAssertTrue([CardValidator ValidateCardLocal:@"6762765696545485"]);
    
}

- (void)testInvalidLocalTests{
    XCTAssertFalse([CardValidator ValidateCardLocal:@"4929804463622138"]);
    XCTAssertFalse([CardValidator ValidateCardLocal:@"0"]);
    XCTAssertFalse([CardValidator ValidateCardLocal:@"6762765696545485123456789"]);
    XCTAssertFalse([CardValidator ValidateCardLocal:@"676276569654548512345678asd9"]);
}

- (void)testValidServerTests{
    [CardValidator ValidateCardOnline:@"4929804463622139" callback:^(Card * _Nonnull result, NSString * _Nonnull errorMessage) {
        XCTAssertNotNil(result);
    }];
    [CardValidator ValidateCardOnline:@"6762765696545485" callback:^(Card * _Nonnull result, NSString * _Nonnull errorMessage) {
        XCTAssertNotNil(result);
    }];
}
- (void)testInvalidServerTests{
    [CardValidator ValidateCardOnline:@"4929804463622138" callback:^(Card * _Nonnull result, NSString * _Nonnull errorMessage) {
        XCTAssertNil(result);
    }];
    [CardValidator ValidateCardOnline:@"4929804463622138" callback:^(Card * _Nonnull result, NSString * _Nonnull errorMessage) {
        XCTAssertNil(result);
    }];
}

- (void)testValidFullTests{
    [CardValidator ValidateCardFull:@"4929804463622139" callback:^(Card *result, NSString *errorMessage) {
        XCTAssertNotNil(result);
    }];
    [CardValidator ValidateCardFull:@"6762765696545485" callback:^(Card *result, NSString *errorMessage) {
        XCTAssertNotNil(result);
    }];
}

- (void)testInalidFullTests{
    [CardValidator ValidateCardFull:@"4929804463622138" callback:^(Card *result, NSString *errorMessage) {
        XCTAssertNil(result);
    }];
    [CardValidator ValidateCardFull:@"0" callback:^(Card *result, NSString *errorMessage) {
        XCTAssertNil(result);
    }];
    [CardValidator ValidateCardFull:@"6762765696545485123456789" callback:^(Card *result, NSString *errorMessage) {
        XCTAssertNil(result);
    }];
}
@end
