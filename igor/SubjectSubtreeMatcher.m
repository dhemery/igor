
#import "SubjectSubtreeMatcher.h"
#import "TreeWalker.h"

@implementation SubjectSubtreeMatcher

@synthesize subjectMatcher, subtreeMatcher;

-(NSString*) description {
    return [NSString stringWithFormat:@"[SubjectTestMatcher:[subject:%@][subtree:%@]]", subjectMatcher, subtreeMatcher];
}

-(SubjectSubtreeMatcher*) initWithSubjectMatcher:(id<Matcher>)theSubjectMatcher subtreeMatcher:(id<Matcher>)theSubtreeMatcher {
    if(self = [super init]) {
        subjectMatcher = theSubjectMatcher;
        subtreeMatcher = theSubtreeMatcher;
    }
    return self;
}

-(BOOL) matchesView:(UIView*)view {
    return [subjectMatcher matchesView:view] && [self testMatcherMatchesASubviewOf:view];
}

-(BOOL) testMatcherMatchesASubviewOf:(UIView*)view {
    __block BOOL subtreeHasAMatch = NO;
    void (^noteMatch)(UIView*view) = ^(UIView*view){
        if([subtreeMatcher matchesView:view]) {
            subtreeHasAMatch = YES;
        }
    };
    for(id subview in [view subviews]) {
        [TreeWalker walkTree:subview withVisitor:noteMatch];
    }
    return subtreeHasAMatch;
}

+(SubjectSubtreeMatcher*) withSubjectMatcher:(id<Matcher>)subjectMatcher subtreeMatcher:(id<Matcher>)subtreeMatcher {
    return [[SubjectSubtreeMatcher alloc] initWithSubjectMatcher:subjectMatcher subtreeMatcher:subtreeMatcher];
}

@end
