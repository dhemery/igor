#import "ViewFactory.h"


@implementation ViewFactory

+ (Class)classForButton {
#if TARGET_OS_IPHONE
  return [UIButton class];
#else
  return [NSButton class];
#endif
}

+ (Class)classForControl {
#if TARGET_OS_IPHONE
  return [UIControl class];
#else
  return [NSControl class];
#endif
}

+ (Class)classForLabel {
#if TARGET_OS_IPHONE
  return [UILabel class];
#else
  return [NSTextField class];
#endif
}

+ (Class)classForView {
#if TARGET_OS_IPHONE
  return [UIView class];
#else
  return [NSView class];
#endif
}

+ (Class)classForWindow {
#if TARGET_OS_IPHONE
  return [UIWindow class];
#else
  return [NSWindow class];
#endif
}

+ (id)button {
    return [self viewWithClass:[self classForButton]];
}

+ (id)control {
    return [self viewWithClass:[self classForControl]];
}

+ (CGRect)frame {
    return CGRectMake(0, 0, 100, 100);
}

+ (id)view {
    return [self viewWithName:@"anonymous"];
}

+ (id)viewWithClass:(Class)theClass {
    return [self viewWithClass:theClass name:@"anonymous"];
}

+ (id)viewWithName:(NSString *)name {
    return [self viewWithClass:[self classForView] name:name];
}

+ (id)viewWithClass:(Class)theClass name:(NSString *)name {
    id view = [[theClass alloc] initWithFrame:[self frame]];
#if TARGET_OS_IPHONE
    [view setAccessibilityIdentifier:name];
#else
    [view setIdentifier:name];
#endif
    return view;
}


+ (id)window {
    return [[[self classForWindow] alloc] initWithFrame:[self frame]];
}

@end

#if TARGET_OS_IPHONE
@interface UIView (ViewFactory)
- (NSString *)description;
@end

@implementation UIView (ViewFactory)

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@(%@)]", [self class], [self accessibilityIdentifier]];
}
@end
#endif