#import "Combinator.h"
#import "CombinatorMatcher.h"

// TODO Test
@implementation CombinatorMatcher

@synthesize subjectMatcher = _subjectMatcher;
@synthesize combinator = _combinator;
@synthesize relativeMatcher = _relativeMatcher;

+ (id <ChainMatcher>)matcherWithSubjectMatcher:(id <Matcher>)matcher {
    return [self matcherWithRelativeMatcher:nil combinator:nil subjectMatcher:matcher];
}

+ (id <ChainMatcher>)matcherWithRelativeMatcher:(id <Matcher>)relativeMatcher combinator:(id <Combinator>)combinator subjectMatcher:(id <Matcher>)subjectMatcher {
    return [[self alloc] initWithRelativeMatcher:relativeMatcher combinator:combinator subjectMatcher:subjectMatcher];
}

- (id <ChainMatcher>)initWithRelativeMatcher:(id <Matcher>)relativeMatcher combinator:(id <Combinator>)combinator subjectMatcher:(id <Matcher>)subjectMatcher {
    self = [super init];
    if (self) {
        _relativeMatcher = relativeMatcher;
        _combinator = combinator;
        _subjectMatcher = subjectMatcher;
    }
    return self;
}

- (void)appendCombinator:(id <Combinator>)combinator matcher:(id <Matcher>)matcher {
    self.relativeMatcher = [CombinatorMatcher matcherWithRelativeMatcher:self.relativeMatcher combinator:self.combinator subjectMatcher:self.subjectMatcher];
    self.combinator = combinator;
    self.subjectMatcher = matcher;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@%@", self.relativeMatcher, self.combinator, self.subjectMatcher];
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