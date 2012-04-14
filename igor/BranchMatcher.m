#import "BranchMatcher.h"
#import "TreeWalker.h"
#import "Combinator.h"

@implementation BranchMatcher

@synthesize subjectMatcher, combinator, relativeMatcher;

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@$$%@%@)", self.subjectMatcher, self.combinator, self.relativeMatcher];
}

- (BranchMatcher *)initWithSubjectMatcher:(id <SubjectMatcher>)theSubjectMatcher
                                   combinator:(id <Combinator>)theCombinator
                              relativeMatcher:(id <SubjectMatcher>)theRelativeMatcher {
    if (self = [super init]) {
        subjectMatcher = theSubjectMatcher;
        combinator = theCombinator;
        relativeMatcher = theRelativeMatcher;
    }
    return self;
}

- (BOOL)branchTestMatchesARelativeOfView:(UIView *)view {
    __block BOOL subtreeHasAMatch = NO;
    for (id subview in [combinator relativesOfView:view]) {
        void (^noteMatch)(UIView *) = ^(UIView *target) {
            if ([self.relativeMatcher matchesView:target inTree:subview]) {
                subtreeHasAMatch = YES;
            }
        };
        [TreeWalker walkTree:subview withVisitor:noteMatch];
    }
    return subtreeHasAMatch;
}

- (BOOL)subjectMatcherMatchesView:(UIView *)view inTree:(UIView *)root {
    BOOL matchesSubject = [self.subjectMatcher matchesView:view inTree:root];
    return matchesSubject;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root {
    return [self subjectMatcherMatchesView:view inTree:root] && [self branchTestMatchesARelativeOfView:view];
}

+ (BranchMatcher *)matcherWithSubjectMatcher:(id <SubjectMatcher>)subject
                                   combinator:(id <Combinator>)combinator
                              relativeMatcher:(id <SubjectMatcher>)relativeMatcher {
    return [[self alloc] initWithSubjectMatcher:subject combinator:combinator relativeMatcher:relativeMatcher];
}

@end
