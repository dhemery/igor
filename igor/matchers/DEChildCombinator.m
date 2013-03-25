#import "DEChildCombinator.h"

@implementation DEChildCombinator

- (NSString *)description {
    return @">";
}

- (NSArray *)inverseRelativesOfView:(id)subject {
    id parent = [subject superview];
    if (parent) {
        return [NSArray arrayWithObject:parent];
    }
    return [NSArray array];
}

- (NSArray *)relativesOfView:(id)subject {
    return [subject subviews];
}

@end
