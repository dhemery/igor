//
//  DEPositionMatcher.m
//  Igor
//
//  Created by Chong Francis on 13年8月14日.
//
//

#import "DEPositionMatcher.h"

@interface DEPositionMatcher()
@end

@implementation DEPositionMatcher

- (NSString *)description {
    return [NSString stringWithFormat:@":%@", self.position];
}

- (instancetype)initWithPosition:(NSString *)position {
    self = [super init];
    if (self) {
        _position = [position copy];
    }
    return self;
}

- (void)appendCombinator:(id <DECombinator>)combinator matcher:(id <DEMatcher>)matcher {
    
}

- (BOOL)matchesView:(UIView *)view {
    if ([self.position isEqualToString:@"root"] && [self isRootView:view]) {
        return YES;
    }
    
    if ([self.position isEqualToString:@"empty"] && [self isEmptyView:view]) {
        return YES;
    }
    
    if ([self.position isEqualToString:@"first-child"] && [self isFirstChild:view]) {
        return YES;
    }

    if ([self.position isEqualToString:@"last-child"] && [self isLastChild:view]) {
        return YES;
    }

    if ([self.position isEqualToString:@"only-child"] && [self isOnlyChild:view]) {
        return YES;
    }

    return NO;
}

- (BOOL) isRootView:(UIView *)view {
    return view.superview == [UIApplication sharedApplication].keyWindow;
}

- (BOOL) isEmptyView:(UIView *)view {
    return [view.subviews count] == 0;
}

- (BOOL) isFirstChild:(UIView *)view {
    return view.superview && view.superview.subviews[0] == view;
}

- (BOOL) isLastChild:(UIView *)view {
    return view.superview && [view.superview.subviews lastObject] == view;
}

- (BOOL) isOnlyChild:(UIView *)view {
    return view.superview && view.superview.subviews.count == 1;
}

+ (DEPositionMatcher *)matcherForPosition:(NSString*)position {
    return [[DEPositionMatcher alloc] initWithPosition:position];
}

@end
