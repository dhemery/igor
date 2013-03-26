#import "ViewFactory.h"


@implementation ViewFactory

+ (Class)classForButton {
  return NSClassFromString([self classNameForButton]);
}

+ (Class)classForControl {
  return NSClassFromString([self classNameForControl]);
}

+ (Class)classForLabel {
  return NSClassFromString([self classNameForLabel]);
}

+ (Class)classForView {
  return NSClassFromString([self classNameForView]);
}

+ (Class)classForWindow {
  return NSClassFromString([self classNameForWindow]);
}

+ (NSString *)classNameForButton {
#if TARGET_OS_IPHONE
  return @"UIButton";
#else
  return @"NSButton";
#endif
}

+ (NSString *)classNameForControl {
#if TARGET_OS_IPHONE
  return @"UIControl";
#else
  return @"NSControl";
#endif
}

+ (NSString *)classNameForLabel {
#if TARGET_OS_IPHONE
  return @"UILabel";
#else
  return @"NSTextField";
#endif
}

+ (NSString *)classNameForView {
#if TARGET_OS_IPHONE
  return @"UIView";
#else
  return @"NSView";
#endif
}

+ (NSString *)classNameForWindow {
#if TARGET_OS_IPHONE
  return @"UIWindow";
#else
  return @"NSWindow";
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