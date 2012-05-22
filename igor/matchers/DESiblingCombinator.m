#import "DESiblingCombinator.h"


@implementation DESiblingCombinator

- (NSString *)description {
    return @"~";
}

- (NSArray *)relativesOfView:(UIView *)subject {
    NSMutableArray *siblings = [NSMutableArray array];
    UIView *parent = [subject superview];
    for (UIView *view in [parent subviews]) {
        if (view != subject) [siblings addObject:view];
    }
    return [NSArray arrayWithArray:siblings];
}

- (NSArray *)inverseRelativesOfView:(UIView *)subject {
    return [self relativesOfView:subject];
}

@end
