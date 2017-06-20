#import <Foundation/Foundation.h>

/**
 * SIMCardType holds the card type as well as validation parameters such as maximum CVC length, minimum card number length, and maximum card number length.  The card number does not need to be complete for the card type to be determined.  If the card number does not match any type, card type "blank" is returned with loose validation parameters.
 */
@interface SIMCardType : NSObject
@property (nonatomic, strong, readonly) NSString *cardTypeString; /**< One of 8 types of card types */
@property (nonatomic, readonly) int CVCLength; /**< Valid CVC length for particular card type.  If type "blank", this is the maximum CVC length */
@property (nonatomic, readonly) int minCardLength; /**< Minimum length of the card number for particular type of card  */
@property (nonatomic, readonly) int maxCardLength; /**< Maximum length of the card number for particular type of card  */

/** 
 A class method that returns a card type and validations from a card number string in the form of an instance of SIMCardType.
 @param cardNumber should be a string of digits.  If there are non-digits in the cardNumber string, the card type will return "blank".
 @return An instance of SIMCardType that contains the card type, the CVC length, the minumum card length, and the maximum card length for that particular card type.
 */
+(instancetype)cardTypeFromCardNumberString:(NSString *)cardNumber;

/**
 A class method that takes in an array of prefixes and determines if any are present in the cardString
 @param prefixArray is an array of prefixes
 @param cardNumber is the string in which the presence of a prefix will be sought out
 @return A boolean of whether or not a prefix was found in the cardString
 */
+(BOOL)hasPrefixFromArray:(NSArray *)prefixArray inString:(NSString *)cardString;
@end
