#import "DescendantCombinator.h"

@implementation DescendantCombinator

- (NSString *)description {
    return @" ";
}

- (NSArray *)inverseRelativesOfView:(UIView *)subject {
    NSMutableArray *ancestors = [NSMutableArray array];
    id ancestor = [subject superview];
    while (ancestor) {
        [ancestors addObject:ancestor];
        ancestor = [ancestor superview];
    }
    return [NSArray arrayWithArray:ancestors];
}

- (NSArray *)inverseRelativesOfView:(UIView *)subject inTree:(UIView *)root {
    NSMutableArray *ancestorsOfView = [NSMutableArray arrayWithArray:[self inverseRelativesOfView:subject]];
    NSArray *ancestorsOfRoot = [self inverseRelativesOfView:root];
    [ancestorsOfView removeObjectsInArray:ancestorsOfRoot];
    return [NSArray arrayWithArray:ancestorsOfView];
}

// TODO Return all descendants?
- (NSArray *)relativesOfView:(UIView *)view {
    return [view subviews];
}

@end
