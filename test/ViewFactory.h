@interface ViewFactory : NSObject

+ (UIButton *)button;

+ (UIButton *)buttonWithAccessibilityHint:(NSString *)hint;

+ (UIControl *)control;

+ (UIView *)view;

+ (UIWindow *)window;

@end

