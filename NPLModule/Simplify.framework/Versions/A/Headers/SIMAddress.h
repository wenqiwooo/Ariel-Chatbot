/**
 * Holds all of the address information of the cardholder
 */
@interface SIMAddress : NSObject

@property (nonatomic, readonly) NSString *name; /**< Name of credit card holder */
@property (nonatomic, readonly) NSString *addressLine1; /**< First line of address */
@property (nonatomic, readonly) NSString *addressLine2; /**< Second line of address */
@property (nonatomic, readonly) NSString *city; /**< City of address */
@property (nonatomic, readonly) NSString *state; /**< US state (USPS code) */
@property (nonatomic, readonly) NSString *zip; /**< Postal code of the cardholder (between 5-9 digits in length) */
@property (nonatomic, readonly) NSString *country; /**< Country code (ISO-3166-1-alpha-2 code) */

/**
 Creates an instance of SIMAddress
 @param name is the name of the card holder.  Should be min length: 2, max length: 50
 @param addressLine1 is the first line of the address.  Should have a maximum length of 255
 @param addressLine2 is the second line of the address.  Should have a maximum length of 255
 @param city is the city of the card holder.  Should be min length: 2, max length: 50
 @param state is the state code (USPS code) of residence of the cardholder.  Should be only 2 characters
 @param zip is the postal code of the cardholder.  The postal code size should between 5 and 9 in length and only contain numbers. 
 @return an instnace of SIMAddress with all of the input information
 */
-(instancetype)initWithName:(NSString *)name addressLine1:(NSString *)addressLine1 addressLine2:(NSString *)addressLine2 city:(NSString *)city state:(NSString *)state zip:(NSString *)zip;

/**
 Creates an instance of SIMAddress
 @param name is the name of the card holder.  Should be min length: 2, max length: 50
 @param addressLine1 is the first line of the address.  Should have a maximum length of 255
 @param addressLine2 is the second line of the address.  Should have a maximum length of 255
 @param city is the city of the card holder.  Should be min length: 2, max length: 50
 @param state is the state code (USPS code) of residence of the cardholder.  Should be only 2 characters
 @param country is the country code (ISO-3166-1-alpha-2 code)
 @param zip is the postal code of the cardholder.  The postal code size should between 5 and 9 in length and only contain numbers.
 @return an instnace of SIMAddress with all of the input information
 */
-(instancetype)initWithName:(NSString *)name addressLine1:(NSString *)addressLine1 addressLine2:(NSString *)addressLine2 city:(NSString *)city state:(NSString *)state country:(NSString *)country zip:(NSString *)zip;
@end
