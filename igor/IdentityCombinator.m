#import "IdentityCombinator.h"
#import "SubjectMatcher.h"

@implementation IdentityCombinator {
    id <SubjectMatcher> subjectMatcher;
}
- (id <Combinator>)initWithSubjectMatcher:(id <SubjectMatcher>)theSubjectMatcher {
    self = [super init];
    if (self) {
        subjectMatcher = theSubjectMatcher;
    }
    return self;
}

- (BOOL)collectMatchingRelativesOfViews:(NSArray *)targetViews inTree:(UIView *)tree intoArray:(NSMutableArray *)matchingRelatives {
    BOOL foundMatchingViews = NO;
    for(id view in targetViews) {
        if([subjectMatcher matchesView:view inTree:tree]) {
            foundMatchingViews = YES;
            [matchingRelatives addObject:view];
        }
    }
    return foundMatchingViews;
}

+ (id <Combinator>)combinatorThatAppliesMatcher:(id <SubjectMatcher>)subjectMatcher {
    return [[self alloc] initWithSubjectMatcher:subjectMatcher];
}
@end