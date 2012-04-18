#import "EmptySetCombinator.h"

@implementation EmptySetCombinator

- (NSString *)description {
    return @"{empty.combinator}";
}

- (NSArray *)relativesOfView:(UIView *)view {
    return [NSArray array];
}

- (NSArray *)inverseRelativesOfView:(UIView *)subject {
    return [NSArray array];
}

- (NSArray *)inverseRelativesOfView:(UIView *)subject inTree:(UIView *)root {
    return [NSArray array];
}

@end