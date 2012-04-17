#import "ViewFactory.h"


@implementation ViewFactory

+ (UIButton *)button {
    return [self viewWithClass:[UIButton class]];
}

+ (UIControl *)control {
    return [self viewWithClass:[UIControl class]];
}

+ (CGRect)frame {
    return CGRectMake(0, 0, 100, 100);
}

+ (UIView *)view {
    return [self viewWithName:@"anonymous"];
}

+ (id)viewWithClass:(Class)theClass {
    return [self viewWithClass:theClass name:@"anonymous"];
}

+ (UIView *)viewWithName:(NSString *)name {
    return [self viewWithClass:[UIView class] name:name];
}

+ (id)viewWithClass:(Class)theClass name:(NSString *)name {
    UIView *view = [[theClass alloc] initWithFrame:[self frame]];
    view.accessibilityIdentifier = name;
    return view;
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
    return [NSString stringWithFormat:@"[%@(%@)]", [self class], [self accessibilityIdentifier]];
}
@end