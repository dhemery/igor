#import "DEDescendantCombinator.h"

@implementation DEDescendantCombinator

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

- (NSArray *)relativesOfView:(UIView *)subject {
    NSArray *const subviews = [subject subviews];
    NSMutableArray* descendants = [NSMutableArray arrayWithArray:subviews];
    for (UIView *subview in subviews) {
        [descendants addObjectsFromArray:[self relativesOfView:subview]];
    }
    return [NSArray arrayWithArray:descendants];
}

@end
