#import "DEChainMatcher.h"
#import "ViewFactory.h"
#import "DEBranchMatcher.h"
#import "FalseMatcher.h"
#import "DescendantCombinator.h"
#import "DEUniversalMatcher.h"
#import "MatchesView.h"
#import "EmptySetCombinator.h"
#import "DEChildCombinator.h"
@interface BranchMatcherTests : SenTestCase
@end

@implementation BranchMatcherTests {
    UIView *root;
    UIView *middle;
    UIView *leaf;
}

- (void)setUp {
    root = [ViewFactory viewWithName:@"root"];
    middle = [ViewFactory viewWithName:@"middle"];
    leaf = [ViewFactory viewWithName:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
}

- (void)testMatchesIfSubjectMatchesAndBranchHasNoRelativeMatchers {
    id <DEChainMatcher> matchAnySubject = [DEBranchMatcher matcherWithSubjectMatcher:[DEUniversalMatcher new]];

    assertThat(matchAnySubject, [MatchesView view:middle]);
}

- (void)testMismatchesIfSubjectMismatchesAndBranchHasNoRelativeMatchers {
    id <DEChainMatcher> mismatchEverySubject = [DEBranchMatcher matcherWithSubjectMatcher:[FalseMatcher new]];

    assertThat(mismatchEverySubject, isNot([MatchesView view:root]));
}

- (void)testMatchesIfSubjectMatchesAndRelativeMatches {
    id <DEChainMatcher> matchAnySubjectThatHasAnyChild = [DEBranchMatcher matcherWithSubjectMatcher:[DEUniversalMatcher new]];
    [matchAnySubjectThatHasAnyChild appendCombinator:[DEChildCombinator new] matcher:[DEUniversalMatcher new]];

    assertThat(matchAnySubjectThatHasAnyChild, [MatchesView view:middle]);
}

- (void)testMismatchesIfSubjectMismatches {
    id <DEChainMatcher> mismatchEverySubjectMatchEveryRelative = [DEBranchMatcher matcherWithSubjectMatcher:[FalseMatcher new]];
    [mismatchEverySubjectMatchEveryRelative appendCombinator:[DescendantCombinator new] matcher:[DEUniversalMatcher new]];

    assertThat(mismatchEverySubjectMatchEveryRelative, isNot([MatchesView view:root]));
}

- (void)testMismatchesIfRelativesMismatch {
    id <DEChainMatcher> matchAnySubjectMismatchEveryRelative = [DEBranchMatcher matcherWithSubjectMatcher:[DEUniversalMatcher new]];
    [matchAnySubjectMismatchEveryRelative appendCombinator:[DescendantCombinator new] matcher:[FalseMatcher new]];

    assertThat(matchAnySubjectMismatchEveryRelative, isNot([MatchesView view:middle]));
}

- (void)testMismatchesIfCombinatorYieldsNoRelatives {
    id <DEChainMatcher> combinatorYieldsNoRelatives = [DEBranchMatcher matcherWithSubjectMatcher:[DEUniversalMatcher new]];
    [combinatorYieldsNoRelatives appendCombinator:[EmptySetCombinator new] matcher:[DEUniversalMatcher new]];

    assertThat(combinatorYieldsNoRelatives, isNot([MatchesView view:middle]));
}

- (void)testChainOfRelatives {
    id <DEChainMatcher> hasGrandchildren = [DEBranchMatcher matcherWithSubjectMatcher:[DEUniversalMatcher new]];
    [hasGrandchildren appendCombinator:[DEChildCombinator new] matcher:[DEUniversalMatcher new]];
    [hasGrandchildren appendCombinator:[DEChildCombinator new] matcher:[DEUniversalMatcher new]];
    assertThat(hasGrandchildren, [MatchesView view:root]);
}

@end
