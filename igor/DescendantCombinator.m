#import "DescendantCombinator.h"
#import "SimpleMatcher.h"

@implementation DescendantCombinator {
    id <SimpleMatcher> subjectMatcher;
    id <SubjectMatcher> relativeMatcher;
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

- (NSMutableArray *)ancestorsOfView:(UIView *)view inTree:(UIView *)root {
    NSMutableArray *ancestorsOfView = [self ancestorsOfView:view];
    [ancestorsOfView removeObjectsInArray:[self ancestorsOfView:root]];
    return ancestorsOfView;
}

+ (id <Combinator>)combinatorWithSubjectMatcher:(id <SimpleMatcher>)subjectMatcher relativeMatcher:(id <SubjectMatcher>)relativeMatcher {
    return [[self alloc] initWithSubjectMatcher:subjectMatcher relativeMatcher:relativeMatcher];
}

- (id <Combinator>)initWithSubjectMatcher:(id <SimpleMatcher>)theSubjectMatcher relativeMatcher:(id <SubjectMatcher>)theRelativeMatcher {
    self = [super init];
    if (self) {
        subjectMatcher = theSubjectMatcher;
        relativeMatcher = theRelativeMatcher;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)subject inTree:(UIView *)tree {
    if (![subjectMatcher matchesView:subject]) {
        return NO;
    }
    for(id ancestor in [self ancestorsOfView:subject inTree:tree]) {
        if([relativeMatcher matchesView:ancestor inTree:tree]) {
            return YES;
        }
    }
    return NO;
}

@end