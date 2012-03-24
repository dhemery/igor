#import "SubjectAndDescendantMatcher.h"
#import "TreeWalker.h"

@implementation SubjectAndDescendantMatcher

@synthesize subjectMatcher = _subjectMatcher, descendantMatcher = _descendantMatcher;

- (NSString *)description {
    return [NSString stringWithFormat:@"[SubjectAndDescendantMatcher:[subjectMatcher:%@][descendantMatcher:%@]]", _subjectMatcher, _descendantMatcher];
}

- (SubjectAndDescendantMatcher *)initWithSubjectMatcher:(id <RelationshipMatcher>)subjectMatcher descendantMatcher:(id <RelationshipMatcher>)descendantMatcher {
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

+ (SubjectAndDescendantMatcher *)withSubjectMatcher:(id <RelationshipMatcher>)subjectMatcher descendantMatcher:(id <RelationshipMatcher>)descendantMatcher {
    return [[SubjectAndDescendantMatcher alloc] initWithSubjectMatcher:subjectMatcher descendantMatcher:descendantMatcher];
}

@end
