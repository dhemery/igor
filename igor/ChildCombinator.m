#import "ChildCombinator.h"

@implementation ChildCombinator

- (NSArray *)inverseRelativesOfView:(UIView *)subject {
    UIView *parent = [subject superview];
    if (parent) {
        return [NSArray arrayWithObject:parent];
    }
    return [NSArray array];
}

- (NSArray *)inverseRelativesOfView:(UIView *)subject inTree:(UIView *)root {
    if (subject == root) {
        return [NSArray array];
    }
    return [self inverseRelativesOfView:subject];
}

- (NSArray *)relativesOfView:(UIView *)subject {
    return [subject subviews];
}

@end
