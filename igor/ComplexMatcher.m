
#import "ComplexMatcher.h"
#import "InstanceMatcher.h"
#import "UniversalMatcher.h"

@implementation ComplexMatcher {
    id<SubjectMatcher> _head;
    id<SubjectMatcher> _subject;
    id<SubjectMatcher> _tail;
}

@synthesize head = _head;
@synthesize subject = _subject;
@synthesize tail = _tail;

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

- (BOOL)headMatchesAnAncestorOfView:(UIView *)view inTree:(UIView *)root {
    for (id ancestor in [self ancestorsOfView:view withinTree:root]) {
        if ([_head matchesView:ancestor inTree:root]) {
            return true;
        }
    }
    return false;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[Complex:[head:%@][subject:%@][tail:%@]]", _head, _subject, _tail];
}

- (ComplexMatcher *)initWithHead:(id<SubjectMatcher>)head subject:(id <SubjectMatcher>)subject tail:(id<SubjectMatcher>)tail {
    if (self = [super init]) {
        _head = head;
        _subject = subject;
        _tail = tail;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root {
    return [_subject matchesView:view inTree:root] && [self headMatchesAnAncestorOfView:view inTree:root];
}

+ (ComplexMatcher *)withHead:(id<SubjectMatcher>)head subject:(id <SubjectMatcher>)subject {
    return [self withHead:head subject:subject tail:[UniversalMatcher new]];
}

+ (ComplexMatcher *)withHead:(id<SubjectMatcher>)head subject:(id <SubjectMatcher>)subject tail:(id<SubjectMatcher>)tail {
    return [[self alloc] initWithHead:head subject:subject tail:tail];
}

+ (ComplexMatcher *)withSubject:(id <SubjectMatcher>)subject {
    return [self withHead:[UniversalMatcher new] subject:subject tail:[UniversalMatcher new]];
}

@end
