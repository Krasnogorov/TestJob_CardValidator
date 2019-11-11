//
//  CardValidator.h
//  CardValidatorFramework
//
//  Created by Sergey Krasnogorov on 11/10/19.
//  Copyright © 2019 Sergey Krasnogorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
NS_ASSUME_NONNULL_BEGIN

/**
    Class for validation number of card  with 3 variants : locally, using binlist.net and using both of methods
 */
@interface CardValidator : NSObject
/**
    Validate number of card locally using  Luhn algorithm
    @param cardNumber - string representation of number of card
    @return true if number is valid otherwise false
 */
+ (BOOL) validateCardLocal:(NSString *_Nonnull)cardNumber;
/**
   Validate number of card  using  API of binlist.net
   @param cardNumber - string representation of number of card
   @param callback - callback that returns Card object or nil and nil or  error message
*/
+ (void) validateCardOnline:(NSString *_Nonnull)cardNumber callback:(void (^)(Card *result, NSString *errorMessage))callback;
/**
   Validate number of card  using local validation and  API of binlist.net
   @param cardNumber - string representation of number of card
   @param callback - callback that returns Card object or nil and nil or  error message
*/
+ (void) validateCardFull:(NSString *_Nonnull)cardNumber callback:(void (^)(Card *result, NSString *errorMessage))callback;

@end

NS_ASSUME_NONNULL_END
