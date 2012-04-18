#import "ChainMatcher.h"
#import "ViewFactory.h"
#import "BranchMatcher.h"
#import "FalseMatcher.h"
#import "DescendantCombinator.h"
#import "UniversalMatcher.h"
#import "MatchesView.h"
#import "EmptySetCombinator.h"
#import "ChildCombinator.h"
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
    id <ChainMatcher> matchAnySubject = [BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]];

    assertThat(matchAnySubject, [MatchesView view:middle]);
}

- (void)testMismatchesIfSubjectMismatchesAndBranchHasNoRelativeMatchers {
    id <ChainMatcher> mismatchEverySubject = [BranchMatcher matcherWithSubjectMatcher:[FalseMatcher new]];

    assertThat(mismatchEverySubject, isNot([MatchesView view:root]));
}

- (void)testMatchesIfSubjectMatchesAndRelativeMatches {
    id <ChainMatcher> matchAnySubjectThatHasAnyChild = [BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]];
    [matchAnySubjectThatHasAnyChild appendCombinator:[ChildCombinator new] matcher:[UniversalMatcher new]];

    assertThat(matchAnySubjectThatHasAnyChild, [MatchesView view:middle]);
}

- (void)testMismatchesIfSubjectMismatches {
    id <ChainMatcher> mismatchEverySubjectMatchEveryRelative = [BranchMatcher matcherWithSubjectMatcher:[FalseMatcher new]];
    [mismatchEverySubjectMatchEveryRelative appendCombinator:[DescendantCombinator new] matcher:[UniversalMatcher new]];

    assertThat(mismatchEverySubjectMatchEveryRelative, isNot([MatchesView view:root]));
}

- (void)testMismatchesIfRelativesMismatch {
    id <ChainMatcher> matchAnySubjectMismatchEveryRelative = [BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]];
    [matchAnySubjectMismatchEveryRelative appendCombinator:[DescendantCombinator new] matcher:[FalseMatcher new]];

    assertThat(matchAnySubjectMismatchEveryRelative, isNot([MatchesView view:middle]));
}

- (void)testMismatchesIfCombinatorYieldsNoRelatives {
    id <ChainMatcher> combinatorYieldsNoRelatives = [BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]];
    [combinatorYieldsNoRelatives appendCombinator:[EmptySetCombinator new] matcher:[UniversalMatcher new]];

    assertThat(combinatorYieldsNoRelatives, isNot([MatchesView view:middle]));
}

- (void)testChainOfRelatives {
    id <ChainMatcher> hasGrandchildren = [BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]];
    [hasGrandchildren appendCombinator:[ChildCombinator new] matcher:[UniversalMatcher new]];
    [hasGrandchildren appendCombinator:[ChildCombinator new] matcher:[UniversalMatcher new]];
    assertThat(hasGrandchildren, [MatchesView view:root]);
}

@end
