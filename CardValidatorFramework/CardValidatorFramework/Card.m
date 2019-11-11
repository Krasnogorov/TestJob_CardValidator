//
//  Card.m
//  CardValidatorFramework
//
//  Created by Sergey Krasnogorov on 11/10/19.
//  Copyright © 2019 Sergey Krasnogorov. All rights reserved.
//

#import "Card.h"

@implementation Card

/**
   Initialize card with parsed dictionary from API of binlist.net
   @param data - dictionary from response
   @param cardNumber - number of card
   @return - initialized object
*/
-(instancetype)initWithDictionary:(NSDictionary *_Nonnull)data cardNumber:(NSString*)cardNumber {
    self = [self init];
    if (self) {
        _brand = [data objectForKey:@"scheme"];
        _isValid = true;
        _cardNumber = cardNumber;
    }
    return self;
}

@end
