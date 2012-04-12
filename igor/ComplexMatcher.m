
#import "ComplexMatcher.h"
#import "InstanceMatcher.h"
#import "UniversalMatcher.h"
#import "TreeWalker.h"

@implementation ComplexMatcher

@synthesize head, subject, tail;

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
    if ([self.head isMemberOfClass:[UniversalMatcher class]]) return true;
    for (id ancestor in [self ancestorsOfView:view withinTree:root]) {
        if ([self.head matchesView:ancestor inTree:root]) {
            return true;
        }
    }
    return false;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[Complex:[head:%@][subject:%@][tail:%@]]", self.head, self.subject, self.tail];
}

- (ComplexMatcher *)initWithHead:(id<SubjectMatcher>)headMatcher subject:(id <SubjectMatcher>)subjectMatcher tail:(id<SubjectMatcher>)tailMatcher {
    if (self = [super init]) {
        head = headMatcher;
        subject = subjectMatcher;
        tail = tailMatcher;
    }
    return self;
}

- (BOOL)tailMatchesASubviewOfView:(UIView *)view {
    if ([self.tail isMemberOfClass:[UniversalMatcher class]]) return true;
    __block BOOL subtreeHasAMatch = NO;
    for (id subview in [view subviews]) {
        void (^noteMatch)(UIView *) = ^(UIView *target) {
            if ([self.tail matchesView:target inTree:subview]) {
                subtreeHasAMatch = YES;
            }
        };
        [TreeWalker walkTree:subview withVisitor:noteMatch];
    }
    return subtreeHasAMatch;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root {
    return [self.subject matchesView:view inTree:root] && [self headMatchesAnAncestorOfView:view inTree:root] && [self tailMatchesASubviewOfView:view];
}

+ (ComplexMatcher *)matcherWithHead:(id<SubjectMatcher>)head subject:(id <SubjectMatcher>)subject {
    return [self matcherWithHead:head subject:subject tail:[UniversalMatcher new]];
}

+ (ComplexMatcher *)matcherWithHead:(id<SubjectMatcher>)head subject:(id <SubjectMatcher>)subject tail:(id<SubjectMatcher>)tail {
    return [[self alloc] initWithHead:head subject:subject tail:tail];
}

+ (ComplexMatcher *)matcherWithSubject:(id <SubjectMatcher>)subject {
    return [self matcherWithHead:[UniversalMatcher new] subject:subject tail:[UniversalMatcher new]];
}

+ (ComplexMatcher *)matcherWithSubject:(id <SubjectMatcher>)subject tail:(id <SubjectMatcher>)tail {
    return [self matcherWithHead:[UniversalMatcher new] subject:subject tail:tail];
}

@end
