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
    NSLog(@"Checking subject %@ against branch matcher %@", subject, self);
    if (![self.subjectMatcher matchesView:subject]) {
        NSLog(@"Subject %@ mismatched %@", subject, self.subjectMatcher);
        return NO;
    }
    NSLog(@"Subject %@ matched subject matcher %@", subject, self.subjectMatcher);
    if (!self.subjectCombinator) {
        NSLog(@"No relative matcher. Subject match suffices.");
        return YES;
    }
    NSLog(@"Scope of relative matchers is %@%@*", subject, self.subjectCombinator);
    NSArray *relatives = [self.subjectCombinator relativesOfView:subject];
    NSLog(@"Checking relatives %@", relatives);
    for (UIView *relative in relatives) {
        self.subjectIdentityMatcher.targetView = subject;
        if ([self.relativeMatcher matchesView:relative]) {
            NSLog(@"Relative %@ matched %@", relative, self.relativeMatcher);
            return YES;
        }
        NSLog(@"Relative %@ mismatched %@", relative, self.relativeMatcher);
    }
    NSLog(@"No relatives matched %@", self.relativeMatcher);
    return NO;
}

@end
