#import <UIKit/UIKit.h>

@interface SIMResponseViewController : UIViewController

-(instancetype)initWithBackground:(UIImageView *)backgroundView primaryColor:(UIColor *)primaryColor title:(NSString *)titleMessage description:(NSString *)descriptionMessage;

@property (nonatomic) BOOL isPaymentSuccessful;

@end
