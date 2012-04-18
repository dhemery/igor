@interface ViewFactory : NSObject

+ (UIButton *)button;

+ (UIControl *)control;

+ (UIView *)view;

+ (UIView *)viewWithName:(NSString *)name;

+ (UIWindow *)window;

@end

