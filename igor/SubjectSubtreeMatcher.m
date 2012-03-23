#import "SubjectSubtreeMatcher.h"
#import "TreeWalker.h"

@implementation SubjectSubtreeMatcher

@synthesize subjectMatcher = _subjectMatcher, subtreeMatcher = _subtreeMatcher;

- (NSString *)description {
    return [NSString stringWithFormat:@"[SubjectTestMatcher:[subject:%@][subtree:%@]]", _subjectMatcher, _subtreeMatcher];
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
    return [_subjectMatcher matchesView:view withinTree:root] && [self testMatcherMatchesASubviewOf:view withinTree:root];
}

- (BOOL)testMatcherMatchesASubviewOf:(UIView *)view withinTree:(UIView *)root {
    __block BOOL subtreeHasAMatch = NO;
    void (^noteMatch)(UIView *) = ^(UIView *target) {
        if ([_subtreeMatcher matchesView:target withinTree:root]) {
            subtreeHasAMatch = YES;
        }
    };
    for (id subview in [view subviews]) {
        [TreeWalker walkTree:subview withVisitor:noteMatch];
    }
    return subtreeHasAMatch;
}

+ (SubjectSubtreeMatcher *)withSubjectMatcher:(id<RelationshipMatcher>)subjectMatcher subtreeMatcher:(id<RelationshipMatcher>)subtreeMatcher {
    return [[SubjectSubtreeMatcher alloc] initWithSubjectMatcher:subjectMatcher subtreeMatcher:subtreeMatcher];
}

@end
