#import "DEDescendantCombinator.h"

@implementation DEDescendantCombinator

- (NSString *)description {
    return @" ";
}

- (NSArray *)inverseRelativesOfView:(id)subject {
    NSMutableArray *ancestors = [NSMutableArray array];
    id ancestor = [subject superview];
    while (ancestor) {
        [ancestors addObject:ancestor];
        ancestor = [ancestor superview];
    }
    return [NSArray arrayWithArray:ancestors];
}

- (NSArray *)inverseRelativesOfView:(id)subject inTree:(id)root {
    NSMutableArray *ancestorsOfView = [NSMutableArray arrayWithArray:[self inverseRelativesOfView:subject]];
    NSArray *ancestorsOfRoot = [self inverseRelativesOfView:root];
    [ancestorsOfView removeObjectsInArray:ancestorsOfRoot];
    return [NSArray arrayWithArray:ancestorsOfView];
}

- (NSArray *)relativesOfView:(id)subject {
    NSArray *const subviews = [subject subviews];
    NSMutableArray* descendants = [NSMutableArray arrayWithArray:subviews];
    for (id subview in subviews) {
        [descendants addObjectsFromArray:[self relativesOfView:subview]];
    }
    return [NSArray arrayWithArray:descendants];
}

@end
