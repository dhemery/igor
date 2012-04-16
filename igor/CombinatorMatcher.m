#import "CombinatorMatcher.h"
#import "Combinator.h"

// TODO Test
@implementation CombinatorMatcher

@synthesize subjectMatcher, combinator, relativeMatcher;

- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@%@", self.relativeMatcher, self.combinator, self.subjectMatcher];
}

- (id)initWithSubjectMatcher:(id <SubjectMatcher>)theSubjectMatcher combinator:(id <Combinator>)theCombinator relativeMatcher:(id <SubjectMatcher>)theRelativeMatcher {
    self = [super init];
    if (self) {
        subjectMatcher = theSubjectMatcher;
        combinator = theCombinator;
        relativeMatcher = theRelativeMatcher;
    }
    return self;
}

+ (id <SubjectMatcher>)matcherWithRelativeMatcher:(id <SubjectMatcher>)relativeMatcher combinator:(id <Combinator>)combinator subjectMatcher:(id <SubjectMatcher>)subjectMatcher {
    return [[self alloc] initWithSubjectMatcher:subjectMatcher combinator:combinator relativeMatcher:relativeMatcher];
}


- (BOOL)subjectMatcherMatchesView:(UIView *)subject {
    NSLog(@"CM %@ checking %@", self, subject);
    NSLog(@"CM %@ checking %@ against subject matcher %@", self, subject, self.subjectMatcher);
    if (![self.subjectMatcher matchesView:subject]) {
        NSLog(@"CM %@ Subject %@ mismatches subject matcher %@", self, subject, self.subjectMatcher);
        return NO;
    }
    NSLog(@"CM %@ Subject %@ matches subject matcher %@", self, subject, self.subjectMatcher);
    return YES;
}

- (BOOL)relativeMatcherMatchesAnInverseRelativeOfView:(UIView *)subject {
    NSLog(@"CM %@ Checking inverse relatives of %@ against relative matcher %@", self, subject, self.relativeMatcher);
    NSArray *inverseRelatives = [self.combinator inverseRelativesOfView:subject];
    NSLog(@"CM %@ Inverse relatives are %@", self, inverseRelatives);
    for(id relative in inverseRelatives) {
        NSLog(@"CM %@ Checking inverse relative %@ against relative matcher %@", self, relative, self.relativeMatcher);
        if([self.relativeMatcher matchesView:relative]) {
            NSLog(@"CM %@ Relative %@ matches relative matcher %@", self, relative, self.relativeMatcher);
            NSLog(@"CM %@ So subject %@ matches whole combinator matcher", self, subject);
            return YES;
        }
        NSLog(@"CM %@ Relative %@ mismatches relative matcher %@", self, relative, self.relativeMatcher);
    }
    NSLog(@"CM %@ No relatives match, so %@ mismatches whole combinator matcher", self, subject);
    return NO;
}

- (BOOL)matchesView:(UIView *)subject {
    return [self subjectMatcherMatchesView:subject]
            && [self relativeMatcherMatchesAnInverseRelativeOfView:subject];
}
@end