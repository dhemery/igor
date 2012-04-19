#import "SiblingCombinator.h"


@implementation SiblingCombinator

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

- (NSArray *)inverseRelativesOfView:(UIView *)subject inTree:(UIView *)root {
    return [self relativesOfView:subject];
}

@end
