
#import "SubjectSubtreeMatcher.h"
#import "TreeWalker.h"

@implementation SubjectSubtreeMatcher

@synthesize subjectMatcher = _subjectMatcher, subtreeMatcher = _subtreeMatcher;

-(NSString*) description {
    return [NSString stringWithFormat:@"[SubjectTestMatcher:[subject:%@][subtree:%@]]", _subjectMatcher, _subtreeMatcher];
}

-(SubjectSubtreeMatcher*) initWithSubjectMatcher:(Matcher*)subjectMatcher subtreeMatcher:(Matcher*)subtreeMatcher {
    self = [super init];
    if(self) {
        _subjectMatcher = subjectMatcher;
        _subtreeMatcher = subtreeMatcher;
    }
    return self;
}

-(BOOL) matchesView:(UIView*)view {
    return [_subjectMatcher matchesView:view] && [self testMatcherMatchesASubviewOf:view];
}

-(BOOL) testMatcherMatchesASubviewOf:(UIView*)view {
    __block BOOL subtreeHasAMatch = NO;
    void (^noteMatch)(UIView*) = ^(UIView*target){
        if([_subtreeMatcher matchesView:target]) {
            subtreeHasAMatch = YES;
        }
    };
    for(id subview in [view subviews]) {
        [TreeWalker walkTree:subview withVisitor:noteMatch];
    }
    return subtreeHasAMatch;
}

+(SubjectSubtreeMatcher*) withSubjectMatcher:(Matcher*)subjectMatcher subtreeMatcher:(Matcher*)subtreeMatcher {
    return [[SubjectSubtreeMatcher alloc] initWithSubjectMatcher:subjectMatcher subtreeMatcher:subtreeMatcher];
}

@end
