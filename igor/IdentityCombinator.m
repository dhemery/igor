#import "IdentityCombinator.h"
#import "SimpleMatcher.h"

@implementation IdentityCombinator {
    id <SimpleMatcher> subjectMatcher;
}
- (id <Combinator>)initWithSubjectMatcher:(id <SimpleMatcher>)theSubjectMatcher {
    self = [super init];
    if (self) {
        subjectMatcher = theSubjectMatcher;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)tree {
    return [subjectMatcher matchesView:view];
}

+ (id <Combinator>)combinatorWithSubjectMatcher:(id <SimpleMatcher>)subjectMatcher {
    return [[self alloc] initWithSubjectMatcher:subjectMatcher];
}
@end
