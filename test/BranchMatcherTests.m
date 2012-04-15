#import "SubjectMatcher.h"
#import "IdentityMatcher.h"
#import "ViewFactory.h"
#import "BranchMatcher.h"
#import "FalseMatcher.h"
#import "DescendantCombinator.h"
#import "UniversalMatcher.h"
#import "MatchesView.h"
#import "EmptySetCombinator.h"

@interface BranchMatcherTests : SenTestCase
@end

// todo Write these tests
@implementation BranchMatcherTests {
    UIButton *root;
    UIButton *middle;
    UIButton *leaf;
}

- (void)setUp {
    root = [ViewFactory buttonWithAccessibilityHint:@"root"];
    middle = [ViewFactory buttonWithAccessibilityHint:@"middle"];
    leaf = [ViewFactory buttonWithAccessibilityHint:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
}

- (void)testMatchesIfSubjectMatchesAndRelativesMatch {
    id <SubjectMatcher> matchEverySubjectMatchEveryRelative =
            [BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]
                                          combinator:[DescendantCombinator new]
                                     relativeMatcher:[UniversalMatcher new]];

    assertThat(matchEverySubjectMatchEveryRelative, [MatchesView view:middle inTree:root]);
}

- (void)testMismatchesIfSubjectMismatches {
    id <SubjectMatcher> mismatchEverySubjectMatchEveryRelative =
            [BranchMatcher matcherWithSubjectMatcher:[FalseMatcher new]
                                          combinator:[DescendantCombinator new]
                                     relativeMatcher:[UniversalMatcher new]];

    assertThat(mismatchEverySubjectMatchEveryRelative, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testMismatchesIfRelativesMismatch {
    id <SubjectMatcher> matchEverySubjectMismatchEveryRelative =
            [BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]
                                          combinator:[DescendantCombinator new]
                                     relativeMatcher:[FalseMatcher new]];

    assertThat(matchEverySubjectMismatchEveryRelative, isNot([MatchesView view:middle inTree:root]));
}

- (void)testMismatchesIfCombinatorYieldsNoRelatives {
    id <SubjectMatcher> combinatorYieldsNoRelatives =
            [BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]
                                          combinator:[EmptySetCombinator new]
                                     relativeMatcher:[UniversalMatcher new]];

    assertThat(combinatorYieldsNoRelatives, isNot([MatchesView view:middle inTree:root]));
}

@end
