#import "DEChildCombinator.h"

@implementation DEChildCombinator

- (NSString *)description {
    return @">";
}

- (NSArray *)inverseRelativesOfView:(UIView *)subject {
    UIView *parent = [subject superview];
    if (parent) {
        return [NSArray arrayWithObject:parent];
    }
    return [NSArray array];
}

- (NSArray *)relativesOfView:(UIView *)subject {
    return [subject subviews];
}

@end
