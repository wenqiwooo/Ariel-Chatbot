#import "SIMCardType.h"
#import "SIMAddress.h"
#import "SIMCreditCardToken.h"
#import "SIMSimplify.h"
#import <PassKit/PassKit.h>

/**
 Protocol for communicating success or failure of the token generation.
 */
@protocol SIMChargeCardModelDelegate

/**
 Token failure Callback. If token generation fails, this will be called back and an error will be provided with a localizedDescription and code.
 */
-(void)tokenFailedWithError:(NSError *)error;

/**
 Token success Callback. If token generation succeeds, this will be called back and the fully hydrated credit card token.
 */
-(void)tokenProcessed:(SIMCreditCardToken *)token;

@end

/**
 * Model for storing credit card details such as card number, expiration date, and CVC code and then validating such details.  Input public API token in the "retrieve token" method in order to retrieve tokens
 */
@interface SIMChargeCardModel : NSObject
@property (nonatomic, weak) id<SIMChargeCardModelDelegate> delegate; /**< Delegate for SIMChargeCardModelDelegate */
@property (nonatomic, strong, readonly) NSString *cardNumber; /**< Credit card number string in digits, no more than 19 digits */
@property (nonatomic, strong, readonly) NSString *expirationDate; /**< Unformatted expiration date (MMYYY), digits only, can be 3-4 digits */
@property (nonatomic, strong, readonly) NSString *expirationMonth; /**< Expiration month of the card, digits only. Format is MM. Example: January = 1 or 01 */
@property (nonatomic, strong, readonly) NSString *expirationYear; /**< Expiration year of the card. Format is YY, digits only. Example: Example: 2013 = 13 */
@property (nonatomic, strong, readonly) NSString *formattedCardNumber; /**< Credit card number with proper spacing based on type of card, digits and spaces only */
@property (nonatomic, strong, readonly) NSString *formattedExpirationDate; /**< Expiration date string formatted as MM/YY, digits and slash only */
@property (nonatomic, strong, readonly) NSString *cvcCode; /**< 3-4 digit CVC code, digits only */
@property (nonatomic, strong, readonly) NSString *zipCode; /**< 5 digit zip code, digits only */
@property (nonatomic, strong, readonly) NSString *cardTypeString; /**< String with the card type.  Example "mastercard" */
@property (nonatomic, strong, readonly) SIMAddress *address; /**< SIMAddress with all address details of the card holder */
@property (nonatomic, strong, readonly) SIMCardType *cardType; /**< card type, including validations of CVC code length and card number length */
@property (nonatomic, strong) PKPaymentRequest *paymentRequest; /**< user-created PKPaymentRequest for Apple Pay */

@property (nonatomic) BOOL isZipRequired;
@property (nonatomic) BOOL isCVCRequired;

-(instancetype)initWithPublicKey:(NSString *)publicKey error:(NSError **)error;

/**
 * Method that determines if card number, expiration date, and CVC code are all valid
 */
-(BOOL)isCardChargePossible;

/**
 * Determines if credit card number is valid in terms of length and Luhn validation
 */
-(BOOL)isCardNumberValid;

/**
 * Determines if the expiration date is an actual date and if it is in the future
 */
-(BOOL)isExpirationDateValid;

/**
 * Determines if the CVC code is long enough for the type of card.  If the card type is "blank", 3 or 4 are acceptible lengths
 */
-(BOOL)isCVCCodeValid;

/**
 * Determines if the zip code is five digits long
 */
-(BOOL)isZipCodeValid;

/**
 * Method that determines if it is possible to make an Apple Pay payment
 */
-(BOOL)isApplePayAvailable;

/**
 * Updates the model's card number by removing all non-digits.  Will not update the length if it is longer than the card type's maximum card number length
 */
-(void)updateCardNumberWithString:(NSString *)newString;

/**
 * Updates the expiration date it is all digits and has a valid month.  Invalid months (ex. 15) are not accepted.  Format: MYY for 3 digits or MMYY for 4 digits.
 */
-(void)updateExpirationDateWithString:(NSString *)newString;

/**
 * Updates the CVC number if the string is all digits and the length is not more than the card type's prescribed CVC length
 */
-(void)updateCVCNumberWithString:(NSString *)newString;

/**
 * Updates the zip code if the string is all digits and the length is not more than 5
 */
-(void)updateZipCodeWithString:(NSString *)newString;

/**
 * Deletes a character in the expiration date while maintaining formatting
 */
-(void)deleteCharacterInExpiration;

/**
 * Deletes a character in the card number while maintaining formatting
 */
-(void)deleteCharacterInCardNumber;

/**
 * Input your public key here to be able to retrieve a credit card token
 */
-(void)retrieveToken;

@end
