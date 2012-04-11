#import "SubjectOnLeftMatcher.h"
#import "TreeWalker.h"

@implementation SubjectOnLeftMatcher

@synthesize subject = _subject, tail = _tail;

- (NSString *)description {
    return [NSString stringWithFormat:@"[Branch:[subject:%@][descendant:%@]]", _subject, _tail];
}

- (SubjectOnLeftMatcher *)initWithSubject:(id <SubjectMatcher>)subject tail:(id <SubjectMatcher>)tail {
    self = [super init];
    if (self) {
        _subject = subject;
        _tail = tail;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root {
    return [_subject matchesView:view inTree:root] && [self testMatcherMatchesASubviewOf:view];
}

- (BOOL)testMatcherMatchesASubviewOf:(UIView *)view {
    __block BOOL subtreeHasAMatch = NO;
    for (id subview in [view subviews]) {
        void (^noteMatch)(UIView *) = ^(UIView *target) {
            if ([_tail matchesView:target inTree:subview]) {
                subtreeHasAMatch = YES;
            }
        };
        [TreeWalker walkTree:subview withVisitor:noteMatch];
    }
    return subtreeHasAMatch;
}

+ (SubjectOnLeftMatcher *)withSubject:(id <SubjectMatcher>)subject tail:(id <SubjectMatcher>)tail {
    return [[SubjectOnLeftMatcher alloc] initWithSubject:subject tail:tail];
}

@end
