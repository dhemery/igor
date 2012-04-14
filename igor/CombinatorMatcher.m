#import "CombinatorMatcher.h"
#import "Combinator.h"

// TODO Test
@implementation CombinatorMatcher

@synthesize subjectMatcher, combinator, relativeMatcher;

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ %@", self.subjectMatcher, self.combinator, self.relativeMatcher];
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

+ (id <SubjectMatcher>)matcherWithSubjectMatcher:(id <SubjectMatcher>)subjectMatcher
                                      combinator:(id <Combinator>)combinator
                                 relativeMatcher:(id <SubjectMatcher>)relativeMatcher {
    return [[self alloc] initWithSubjectMatcher:subjectMatcher combinator:combinator relativeMatcher:relativeMatcher];
}


- (BOOL)matchesView:(UIView *)subject inTree:(UIView *)tree {
    if (![self.subjectMatcher matchesView:subject inTree:tree]) {
        return NO;
    }
    for(id relative in [self.combinator inverseRelativesOfView:subject inTree:tree]) {
        if([self.relativeMatcher matchesView:relative inTree:tree]) {
            return YES;
        }
    }
    return NO;
}

@end