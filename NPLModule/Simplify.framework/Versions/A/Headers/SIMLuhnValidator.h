#import <Foundation/Foundation.h>
/**
 * SIMLuhnValidator determines if a string of digits is a valid credit card number according to the Luhn algorithm
 */
@interface SIMLuhnValidator : NSObject

/**
 Validates a string of digits based on the Luhn algorithm.  If the string has non-digits, then it is immediately invalidated.
 @param cardNumberString should be a string of digits
 @return BOOL YES if cardNumberString is valid according to the Luhn algorithm
 */

-(BOOL)luhnValidateString:(NSString *)cardNumberString;
@end
