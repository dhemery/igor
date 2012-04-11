#import "SubjectOnRightMatcher.h"

@implementation SubjectOnRightMatcher

@synthesize head = _head, subject = _subject;

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
        if ([_head matchesView:ancestor inTree:root]) {
            return true;
        }
    }
    return false;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[SubjectOnRight:[head:%@][subject:%@]]", _head, _subject];
}

- (SubjectOnRightMatcher *)initWithSubjectMatcher:(id<SubjectMatcher>)subjectMatcher ancestorMatcher:(id <SubjectMatcher>)ancestorMatcher {
    if (self = [super init]) {
        _head = ancestorMatcher;
        _subject = subjectMatcher;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root {
    return [_subject matchesView:view inTree:root] && [self ancestorMatcherMatchesAnAncestorOfView:view withinTree:root];
}

+ (SubjectOnRightMatcher *)withSubject:(id<SubjectMatcher>)subject head:(id <SubjectMatcher>)head {
    return [[self alloc] initWithSubjectMatcher:subject ancestorMatcher:head];
}

@end
