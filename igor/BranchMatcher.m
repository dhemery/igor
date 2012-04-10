#import "BranchMatcher.h"
#import "TreeWalker.h"

@implementation BranchMatcher

@synthesize subjectMatcher = _subjectMatcher, descendantMatcher = _descendantMatcher;

- (NSString *)description {
    return [NSString stringWithFormat:@"[Branch:[subject:%@][descendant:%@]]", _subjectMatcher, _descendantMatcher];
}

- (BranchMatcher *)initWithSubjectMatcher:(id <SubjectMatcher>)subjectMatcher descendantMatcher:(id <SubjectMatcher>)descendantMatcher {
    self = [super init];
    if (self) {
        _subjectMatcher = subjectMatcher;
        _descendantMatcher = descendantMatcher;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view withinTree:(UIView *)root {
    return [_subjectMatcher matchesView:view withinTree:root] && [self testMatcherMatchesASubviewOf:view];
}

- (BOOL)testMatcherMatchesASubviewOf:(UIView *)view {
    __block BOOL subtreeHasAMatch = NO;
    for (id subview in [view subviews]) {
        void (^noteMatch)(UIView *) = ^(UIView *target) {
            if ([_descendantMatcher matchesView:target withinTree:subview]) {
                subtreeHasAMatch = YES;
            }
        };
        [TreeWalker walkTree:subview withVisitor:noteMatch];
    }
    return subtreeHasAMatch;
}

+ (BranchMatcher *)withSubjectMatcher:(id <SubjectMatcher>)subjectMatcher descendantMatcher:(id <SubjectMatcher>)descendantMatcher {
    return [[BranchMatcher alloc] initWithSubjectMatcher:subjectMatcher descendantMatcher:descendantMatcher];
}

@end
