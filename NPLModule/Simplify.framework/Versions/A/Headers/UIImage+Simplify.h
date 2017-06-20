#import <UIKit/UIKit.h>

@interface UIImage (Simplify)

/**
 Obtains the UIImage from an NSString
 @param name is the file name of the image to be retrieved
 @return UIImage image housed in the framework bundle
 */
+(UIImage *)imageNamedFromFramework:(NSString*)name;
+(UIImageView *)blurImage:(CALayer *)layer;
+(UIImage *)boxblurImage:(UIImage *)originalImage withBlur:(CGFloat)blur;

@end
