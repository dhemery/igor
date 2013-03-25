#import "DESiblingCombinator.h"


@implementation DESiblingCombinator

- (NSString *)description {
    return @"~";
}

- (NSArray *)relativesOfView:(id)subject {
    NSMutableArray *siblings = [NSMutableArray array];
    id parent = [subject superview];
    for (id view in [parent subviews]) {
        if (view != subject) [siblings addObject:view];
    }
    return [NSArray arrayWithArray:siblings];
}

- (NSArray *)inverseRelativesOfView:(id)subject {
    return [self relativesOfView:subject];
}

@end
