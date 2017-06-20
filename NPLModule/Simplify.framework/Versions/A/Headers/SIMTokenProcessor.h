#import <PassKit/PassKit.h> 

@interface SIMTokenProcessor : NSObject

+(NSData *) formatDataForRequestWithKey:(NSString *)publicKey withPayment:(PKPayment *)payment error:(NSError *)error;

@end