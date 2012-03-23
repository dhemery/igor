#import "SubjectSubtreeMatcher.h"
#import "TreeWalker.h"

@implementation SubjectSubtreeMatcher

@synthesize subjectMatcher = _subjectMatcher, subtreeMatcher = _subtreeMatcher;

- (NSString *)description {
    return [NSString stringWithFormat:@"[SubjectSubtreeMatcher:[subject:%@][subtree:%@]]", _subjectMatcher, _subtreeMatcher];
}

- (SubjectSubtreeMatcher *)initWithSubjectMatcher:(id<RelationshipMatcher>)subjectMatcher subtreeMatcher:(id<RelationshipMatcher>)subtreeMatcher {
    self = [super init];
    if (self) {
        _subjectMatcher = subjectMatcher;
        _subtreeMatcher = subtreeMatcher;
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
            if ([_subtreeMatcher matchesView:target withinTree:subview]) {
                subtreeHasAMatch = YES;
            }
        };
        [TreeWalker walkTree:subview withVisitor:noteMatch];
    }
    return subtreeHasAMatch;
}

+ (SubjectSubtreeMatcher *)withSubjectMatcher:(id<RelationshipMatcher>)subjectMatcher subtreeMatcher:(id<RelationshipMatcher>)subtreeMatcher {
    return [[SubjectSubtreeMatcher alloc] initWithSubjectMatcher:subjectMatcher subtreeMatcher:subtreeMatcher];
}

@end
