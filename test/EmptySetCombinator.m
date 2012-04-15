#import "EmptySetCombinator.h"

@implementation EmptySetCombinator

- (NSArray *)relativesOfView:(UIView *)view {
    return [NSArray array];
}

- (NSArray *)inverseRelativesOfView:(UIView *)subject inTree:(UIView *)root {
    return [NSArray array];
}

@end