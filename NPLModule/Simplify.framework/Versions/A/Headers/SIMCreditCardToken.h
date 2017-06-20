#import "SIMAddress.h"

/**
 * SIMCardType holds the card type as well as validation parameters such as maximum CVC length, minimum card number length, and maximum card number length.  The card number does not need to be complete for the card type to be determined.  If the card number does not match any type, card type "blank" is returned with loose validation parameters.
 */
@interface SIMCreditCardToken : NSObject

@property (nonatomic, readonly) NSString *token; /**< Unique ID associated with the card token */
@property (nonatomic, readonly) NSString *tokenId; /**< Unique ID of the card associated with the payment*/
@property (nonatomic, readonly) NSString *name; /**< Name as appears on the card. */
@property (nonatomic, readonly) NSString *type; /**< Type of credit or debit card */
@property (nonatomic, readonly) NSNumber *last4; /**< Last 4 digits of the card number */
@property (nonatomic, readonly) SIMAddress *address; /**<  Address of the card associated with the payment */
@property (nonatomic, readonly) NSNumber *expMonth; /**< Expiration month of the card. Format is MM. Example: January = 01 */
@property (nonatomic, readonly) NSNumber *expYear; /**< Expiration year of the card. Format is YY. Example: 2013 = 13 */
@property (nonatomic, readonly) NSDate *dateCreated; /**<  Unique ID of the card associated with the payment */

/**
 Credit Card Token object
 @param token Unique ID associated with the card token
 @param tokenID Unique ID of the card associated with the payment
 @param name Name as appears on the card.
 @param type Type of credit or debit card
 @param last4 Last 4 digits of the card number
 @param address Address of the card associated with the payment
 @param expMonth Expiration month of the card. Format is MM. Example: January = 01
 @param expYear Expiration year of the card. Format is YY. Example: 2013 = 13
 @param dateCreated Unique ID of the card associated with the payment
 @return SIMCreditCardToken
 */
-(instancetype)initWithToken:(NSString *)token tokenId:(NSString *)tokenId name:(NSString *)name type:(NSString *)type last4:(NSNumber *)last4
address:(SIMAddress *)address expMonth:(NSNumber *)expMonth expYear:(NSNumber *)expYear dateCreated:(NSDate *)dateCreated;

/**
 Credit Card Token object created from a dictionary (usually from a JSON dictionary) so that all properties are easily accessible
 @param dictionary is the JSON dictionary that contains the data for the SIMCreditCardToken
 @return SIMCreditCardToken which holds all of the information from the dictionary
 */
+(SIMCreditCardToken *)cardTokenFromDictionary:(NSDictionary *)dictionary;

@end