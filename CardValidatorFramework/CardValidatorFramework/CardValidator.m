//
//  CardValidator.m
//  CardValidatorFramework
//
//  Created by Sergey Krasnogorov on 11/10/19.
//  Copyright © 2019 Sergey Krasnogorov. All rights reserved.
//

#import "CardValidator.h"

#define SUCCESS_RESPONSE_CODE 200
#define SERVER_ENDPOINT_FORMAT @"https://lookup.binlist.net/%@"
#define MIN_CARD_NUMBER_LENGTH 12
#define MAX_CARD_NUMBER_LENGTH 19

@implementation CardValidator

/**
   Validate number of card locally using  Luhn algorithm
   @param cardNumber - string representation of number of card
   @return true if number is valid otherwise false
*/
+ (BOOL) ValidateCardLocal:(NSString *_Nonnull)cardNumber {
    if ([cardNumber length] < MIN_CARD_NUMBER_LENGTH ||
        [cardNumber length] > MAX_CARD_NUMBER_LENGTH) {
        return NO;
    }
    if ([cardNumber characterAtIndex:0] == '0') {
        return NO;
    }
    
    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:cardNumber];
        
    if (![_NumericOnly isSupersetOfSet: myStringSet]) {
        return NO;
    }
    
    int sum = 0;
    NSUInteger digits = [cardNumber length];
    int parity = (digits - 1) % 2;
    char digit[2] = "\0";
    
    for (NSUInteger i = digits; i>0; i--) {
        digit[0] = [cardNumber characterAtIndex:i-1];
        int nDigit = [[NSString stringWithUTF8String:digit] intValue];
        if (parity == i % 2) {
            nDigit = nDigit * 2;
        }
        sum += nDigit/10;
        sum += nDigit%10;
    }
    return ((sum % 10) == 0);
}
/**
   Validate number of card  using  API of binlist.net
   @param cardNumber - string representation of number of card
   @param callback - callback that returns Card object or nil and nil or  error message
*/
+ (void) ValidateCardOnline:(NSString *_Nonnull)cardNumber callback:(void (^)(Card *result, NSString *errorMessage))callback {
    NSString *targetUrl = [NSString stringWithFormat:SERVER_ENDPOINT_FORMAT, cardNumber];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
        
            if ([((NSHTTPURLResponse*)response) statusCode] == SUCCESS_RESPONSE_CODE) {
                NSError *errorJson = nil;
                NSDictionary *responseObj = [NSJSONSerialization
                                            JSONObjectWithData:data
                                            options:0
                                            error:&errorJson];

                if(! errorJson) {
                    Card *ret = [[Card alloc] initWithDictionary:responseObj cardNumber:cardNumber];
                    callback(ret, nil);
                } else {
                    callback(nil, [errorJson localizedDescription]);
                }
            }
            else {
                callback(nil, [error localizedDescription]);
            }        
    }] resume];
}
/**
   Validate number of card  using local validation and  API of binlist.net
   @param cardNumber - string representation of number of card
   @param callback - callback that returns Card object or nil and nil or  error message
*/
+ (void) ValidateCardFull:(NSString *_Nonnull)cardNumber callback:(void (^)(Card *result, NSString *errorMessage))callback {
    if ([CardValidator ValidateCardLocal:cardNumber]) {
        [CardValidator ValidateCardOnline:cardNumber callback:^(Card *result, NSString *errorMessage) {
            callback(result, errorMessage);
        }];
    }
    else {
        callback(nil, NSLocalizedString(@"Local validation failed", @"Local validation failed"));
    }
}

@end
