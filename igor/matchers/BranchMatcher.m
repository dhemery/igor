#import "BranchMatcher.h"
#import "Combinator.h"
#import "IdentityMatcher.h"
#import "CombinatorMatcher.h"

@implementation BranchMatcher

@synthesize subjectMatcher = _subjectMatcher;
@synthesize subjectCombinator = _subjectCombinator;
@synthesize relativeMatcher = _relativeMatcher;
@synthesize subjectIdentityMatcher = _subjectIdentityMatcher;

+ (BranchMatcher *)matcherWithSubjectMatcher:(id <Matcher>)subjectMatcher {
    return [[self alloc] initWithSubjectMatcher:subjectMatcher];
}

- (BranchMatcher *)initWithSubjectMatcher:(id <Matcher>)subjectMatcher {
    self = [super init];
    if (self) {
        _subjectMatcher = subjectMatcher;
        _subjectCombinator = nil;
        _subjectIdentityMatcher = [IdentityMatcher matcherWithView:nil description:@"$$"];
        _relativeMatcher = [CombinatorMatcher matcherWithSubjectMatcher:_subjectIdentityMatcher];
    }
    return self;
}

- (void)appendCombinator:(id <Combinator>)combinator matcher:(id <Matcher>)matcher {
    [self.relativeMatcher appendCombinator:combinator matcher:matcher];
    if (!self.subjectCombinator) self.subjectCombinator = combinator;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@%@)", self.subjectMatcher, self.relativeMatcher];
}








//================ NEW ==================

- (BOOL)matchesView:(UIView *)subject {
    if (![self.subjectMatcher matchesView:subject]) return NO;

    if (!self.subjectCombinator) return YES;

    NSArray *relatives = [self.subjectCombinator relativesOfView:subject];
    for (UIView *relative in relatives) {
        self.subjectIdentityMatcher.targetView = subject;
        if ([self.relativeMatcher matchesView:relative]) return YES;
    }
    return NO;
}

@end
