
//  Card.h
//  CardValidatorFramework
//
//  Created by Sergey Krasnogorov on 11/10/19.
//  Copyright © 2019 Sergey Krasnogorov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
    Class - container information about card.
 */
@interface Card : NSObject
// number of card
@property (nonatomic, readonly) NSString *cardNumber;
// string representation of brand
@property (nonatomic, readonly) NSString *brand;
// is this card valid
@property (nonatomic, readonly) BOOL isValid;
/**
    Initialize card with parsed dictionary from API of binlist.net
    @param data - dictionary from response
    @param cardNumber - number of card
    @return - initialized object
 */
-(instancetype)initWithDictionary:(NSDictionary *_Nonnull)data cardNumber:(NSString*)cardNumber;

@end

NS_ASSUME_NONNULL_END
