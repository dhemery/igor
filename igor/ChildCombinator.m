#import "ChildCombinator.h"

// TODO Test
@implementation ChildCombinator {

}
- (NSArray *)relativesOfView:(UIView *)view {
    return [view subviews];
}

- (NSArray *)inverseRelativesOfView:(UIView *)subject inTree:(UIView *)root {
    if (subject != root) {
        [NSArray arrayWithObject:[subject superview]];
    }
    return [NSArray array];
}

@end
