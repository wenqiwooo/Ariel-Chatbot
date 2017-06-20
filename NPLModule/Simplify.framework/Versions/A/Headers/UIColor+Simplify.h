#import <UIKit/UIKit.h>

@interface UIColor (Simplify)

+ (UIColor *)buttonBackgroundColorEnabled;
+ (UIColor *)buttonHighlightColorEnabled;
+ (UIColor *)buttonBackgroundColorDisabled;
+ (UIColor *)buttonHighlightColorDisabled;
+ (UIColor *)fieldBackgroundColorValid;
+ (UIColor *)fieldBackgroundColorInvalid;
+ (UIColor *)viewBackgroundColorValid;
+ (UIColor *)viewBackgroundColorInvalid;


+ (UIColor *)darkerColorThanColor:(UIColor *)originalColor;

@end
