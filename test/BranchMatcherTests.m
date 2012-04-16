#import "ChainMatcher.h"
#import "IdentityMatcher.h"
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
    id <ChainMatcher> matchEverySubjectMatchEveryRelative = [BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]];
    [matchEverySubjectMatchEveryRelative appendCombinator:[DescendantCombinator new] matcher:[UniversalMatcher new]];

    assertThat(matchEverySubjectMatchEveryRelative, [MatchesView view:middle]);
}

- (void)testMismatchesIfSubjectMismatches {
    id <ChainMatcher> mismatchEverySubjectMatchEveryRelative = [BranchMatcher matcherWithSubjectMatcher:[FalseMatcher new]];
    [mismatchEverySubjectMatchEveryRelative appendCombinator:[DescendantCombinator new] matcher:[UniversalMatcher new]];

    assertThat(mismatchEverySubjectMatchEveryRelative, isNot([MatchesView view:leaf]));
}

- (void)testMismatchesIfRelativesMismatch {
    id <ChainMatcher> matchEverySubjectMismatchEveryRelative = [BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]];
    [matchEverySubjectMismatchEveryRelative appendCombinator:[DescendantCombinator new] matcher:[FalseMatcher new]];

    assertThat(matchEverySubjectMismatchEveryRelative, isNot([MatchesView view:middle]));
}

- (void)testMismatchesIfCombinatorYieldsNoRelatives {
    id <ChainMatcher> combinatorYieldsNoRelatives = [BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]];
    [combinatorYieldsNoRelatives appendCombinator:[EmptySetCombinator new] matcher:[UniversalMatcher new]];

    assertThat(combinatorYieldsNoRelatives, isNot([MatchesView view:middle]));
}

// TODO Write this test.
- (void)testRelativeMatcherMatchesOnlyWithinRelativesOfSubject {
//    assert(false);
}

- (void)testMatchesIfSubjectMatchesAndNoRelativeMatcher {
    BranchMatcher *branchMatcher = [BranchMatcher matcherWithSubjectMatcher:[IdentityMatcher matcherWithView:middle]];
    NSLog(@"Branch matcher is %@", branchMatcher);

    assertThat(branchMatcher, [MatchesView view:middle]);
}

- (void)testMismatchesIfSubjectMismatchesAndNoRelativeMatcher {
    BranchMatcher *branchMatcher = [BranchMatcher matcherWithSubjectMatcher:[IdentityMatcher matcherWithView:middle]];

    assertThat(branchMatcher, isNot([MatchesView view:root]));
}

- (void)testMatchesIfSubjectMatchesAndRelativeMatches {
    BranchMatcher *branchMatcher= [BranchMatcher matcherWithSubjectMatcher:[IdentityMatcher matcherWithView:middle]];
    [branchMatcher appendCombinator:[ChildCombinator new] matcher:[IdentityMatcher matcherWithView:leaf]];

    assertThat(branchMatcher, [MatchesView view:middle]);
}

- (void)testMismatchesIfSubjectMismatchesAndRelativeMatches {
    BranchMatcher *branchMatcher = [BranchMatcher matcherWithSubjectMatcher:[IdentityMatcher matcherWithView:middle]];
    [branchMatcher appendCombinator:[ChildCombinator new] matcher:[FalseMatcher new]];
    NSLog(@"Branch matcher is %@", branchMatcher);

    assertThat(branchMatcher, isNot([MatchesView view:middle]));
}

@end
