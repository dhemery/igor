#import "RelationshipMatcher.h"

@implementation RelationshipMatcher

@synthesize ancestorMatcher = _ancestorMatcher, subjectMatcher = _subjectMatcher;

- (NSMutableArray *)ancestorsOfView:(UIView *)view {
    NSMutableArray *ancestors = [NSMutableArray array];
    id ancestor = [view superview];
    while (ancestor) {
        [ancestors addObject:ancestor];
        ancestor = [ancestor superview];
    }
    return ancestors;
}

- (NSMutableArray *)ancestorsOfView:(UIView *)view withinTree:(UIView *)root {
    NSMutableArray *ancestorsOfView = [self ancestorsOfView:view];
    [ancestorsOfView removeObjectsInArray:[self ancestorsOfView:root]];
    return ancestorsOfView;
}

- (BOOL)ancestorMatcherMatchesAnAncestorOfView:(UIView *)view withinTree:(UIView *)root {
    for (id ancestor in [self ancestorsOfView:view withinTree:root]) {
        if ([_ancestorMatcher matchesView:ancestor withinTree:root]) {
            return true;
        }
    }
    return false;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[Relationship:[subject:%@][ancestor:%@]]", _subjectMatcher, _ancestorMatcher];
}

- (RelationshipMatcher *)initWithSubjectMatcher:(id<SubjectMatcher>)subjectMatcher ancestorMatcher:(id <SubjectMatcher>)ancestorMatcher {
    if (self = [super init]) {
        _ancestorMatcher = ancestorMatcher;
        _subjectMatcher = subjectMatcher;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view withinTree:(UIView *)root {
    return [_subjectMatcher matchesView:view withinTree:root] && [self ancestorMatcherMatchesAnAncestorOfView:view withinTree:root];
}

+ (RelationshipMatcher *)withSubjectMatcher:(id<SubjectMatcher>)subjectMatcher ancestorMatcher:(id <SubjectMatcher>)ancestorMatcher {
    return [[self alloc] initWithSubjectMatcher:subjectMatcher ancestorMatcher:ancestorMatcher];
}

@end
