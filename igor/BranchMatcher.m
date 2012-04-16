#import "BranchMatcher.h"
#import "Combinator.h"
#import "CombinatorMatcher.h"
#import "IdentityMatcher.h"

// TODO Test
@implementation BranchMatcher

@synthesize subjectMatcher, subjectCombinator, relativeMatcher, subjectIdentityMatcher;

+ (BranchMatcher *)matcherWithSubjectMatcher:(id <SubjectMatcher>)subjectMatcher {
    return [[self alloc]  initWithSubjectMatcher:subjectMatcher];
}

- (BranchMatcher *)initWithSubjectMatcher:(id <SubjectMatcher>)theSubjectMatcher {
    self = [super init];
    if (self) {
        subjectMatcher = theSubjectMatcher;
        subjectCombinator = nil;
        subjectIdentityMatcher = [IdentityMatcher matcherWithView:nil description:@"$$"];
        relativeMatcher = subjectIdentityMatcher;
    }
    return self;
}

- (BranchMatcher *)appendCombinator:(id <Combinator>)newCombinator matcher:(id <SubjectMatcher>)newSubjectMatcher {
    relativeMatcher = [CombinatorMatcher matcherWithRelativeMatcher:self.relativeMatcher combinator:newCombinator subjectMatcher:newSubjectMatcher];
    if (!self.subjectCombinator) subjectCombinator = newCombinator;
    return self;
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
