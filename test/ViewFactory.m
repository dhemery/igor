#import "ViewFactory.h"


@implementation ViewFactory

+ (UIButton *)button {
    return [[UIButton alloc] initWithFrame:[self frame]];
}

+ (UIButton *)buttonWithAccessibilityHint:(NSString *)hint {
    UIButton *button = [ViewFactory button];
    button.accessibilityHint = hint;
    return button;
}

+ (UIControl *)control {
    return [[UIControl alloc] initWithFrame:[self frame]];
}

+ (CGRect)frame {
    return CGRectMake(0, 0, 100, 100);
}

+ (UIView *)view {
    return [[UIView alloc] initWithFrame:[self frame]];
}

+ (UIWindow *)window {
    return [[UIWindow alloc] initWithFrame:[self frame]];
}

@end

@interface UIView (ViewFactory)
- (NSString *)description;
@end

@implementation UIView (ViewFactory)

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@(%@)]", [self class], [self accessibilityHint]];
}
@end