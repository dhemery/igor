#import "DECombinator.h"
#import "DECombinatorMatcher.h"

// TODO Test
@implementation DECombinatorMatcher

@synthesize subjectMatcher = _subjectMatcher;
@synthesize combinator = _combinator;
@synthesize relativeMatcher = _relativeMatcher;

+ (id <DEChainMatcher>)matcherWithSubjectMatcher:(id <DEMatcher>)matcher {
    return [self matcherWithRelativeMatcher:nil combinator:nil subjectMatcher:matcher];
}

+ (id <DEChainMatcher>)matcherWithRelativeMatcher:(id <DEMatcher>)relativeMatcher combinator:(id <DECombinator>)combinator subjectMatcher:(id <DEMatcher>)subjectMatcher {
    return [[self alloc] initWithRelativeMatcher:relativeMatcher combinator:combinator subjectMatcher:subjectMatcher];
}

- (id <DEChainMatcher>)initWithRelativeMatcher:(id <DEMatcher>)relativeMatcher combinator:(id <DECombinator>)combinator subjectMatcher:(id <DEMatcher>)subjectMatcher {
    self = [super init];
    if (self) {
        _relativeMatcher = relativeMatcher;
        _combinator = combinator;
        _subjectMatcher = subjectMatcher;
    }
    return self;
}

- (void)appendCombinator:(id <DECombinator>)combinator matcher:(id <DEMatcher>)matcher {
    self.relativeMatcher = [DECombinatorMatcher matcherWithRelativeMatcher:self.relativeMatcher combinator:self.combinator subjectMatcher:self.subjectMatcher];
    self.combinator = combinator;
    self.subjectMatcher = matcher;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@%@",
                    self.relativeMatcher ? [self.relativeMatcher description]: @"",
                    self.combinator ? [self.combinator description] : @"",
                    self.subjectMatcher];
}

- (BOOL)subjectMatcherMatchesView:(UIView *)subject {
    return [self.subjectMatcher matchesView:subject];
}

- (BOOL)relativeMatcherMatchesAnInverseRelativeOfView:(UIView *)subject {
    if (!self.combinator) return YES;

    NSArray *inverseRelatives = [self.combinator inverseRelativesOfView:subject];
    for(id relative in inverseRelatives) {
        if([self.relativeMatcher matchesView:relative]) return YES;
    }
    return NO;
}

- (BOOL)matchesView:(UIView *)subject {
    return [self subjectMatcherMatchesView:subject]
            && [self relativeMatcherMatchesAnInverseRelativeOfView:subject];
}

@end
