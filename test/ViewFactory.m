#import "ViewFactory.h"

@implementation ViewFactory

+ (UIButton *)button {
    return [[UIButton alloc] initWithFrame:[ViewFactory frame]];
}

+ (UIButton *)buttonWithAccessibilityHint:(NSString *)hint {
    UIButton *button = [ViewFactory button];
    button.accessibilityHint = hint;
    return button;
}

+ (UIControl *)control {
    return [[UIControl alloc] initWithFrame:[ViewFactory frame]];
}

+ (CGRect)frame {
    return CGRectMake(0, 0, 100, 100);
}

+ (UIView *)view {
    return [[UIView alloc] initWithFrame:[ViewFactory frame]];
}

+ (UIWindow *)window {
    return [[UIWindow alloc] initWithFrame:[ViewFactory frame]];
}

@end
