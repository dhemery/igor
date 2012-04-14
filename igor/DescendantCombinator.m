#import "DescendantCombinator.h"

@implementation DescendantCombinator

- (NSString *)description {
    return @" ";
}

- (NSMutableArray *)ancestorsOfView:(UIView *)view {
    NSMutableArray *ancestors = [NSMutableArray array];
    id ancestor = [view superview];
    while (ancestor) {
        [ancestors addObject:ancestor];
        ancestor = [ancestor superview];
    }
    return ancestors;
}

- (NSArray *)inverseRelativesOfView:(UIView *)subject inTree:(UIView *)root {
    NSMutableArray *ancestorsOfView = [self ancestorsOfView:subject];
    NSMutableArray *ancestorsOfRoot = [self ancestorsOfView:root];
    [ancestorsOfView removeObjectsInArray:ancestorsOfRoot];
    return ancestorsOfView;
}

- (NSArray *)relativesOfView:(UIView *)view {
    return [view subviews];
}

@end
