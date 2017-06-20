#import <Foundation/Foundation.h>
/**
 * SIMDigitVerfier determines if a string is comprised of only digits 
 */
@interface SIMDigitVerifier : NSObject

/**
 Method that determines if the input string is comprised of digits zero through nine or not
 @param potentialStringOfDigits is the string that will be checked to see if it only has digits
 @return BOOL YES if string only has digits in it.
 */
-(BOOL)isDigit:(NSString *)potentialStringOfDigits;

@end
