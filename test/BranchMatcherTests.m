#import "SubjectMatcher.h"
#import "IdentityMatcher.h"
#import "ViewFactory.h"
#import "BranchMatcher.h"
#import "FalseMatcher.h"
#import "DescendantCombinator.h"
#import "UniversalMatcher.h"
#import "MatchesView.h"
#import "EmptySetCombinator.h"
#import "ChildCombinator.h"
#import "CombinatorMatcher.h"
#import "PredicateMatcher.h"

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
            [[BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]]
                                          appendCombinator:[DescendantCombinator new]
                                     matcher:[UniversalMatcher new]];

    assertThat(matchEverySubjectMatchEveryRelative, [MatchesView view:middle]);
}

- (void)testMismatchesIfSubjectMismatches {
    id <SubjectMatcher> mismatchEverySubjectMatchEveryRelative =
            [[BranchMatcher matcherWithSubjectMatcher:[FalseMatcher new]]
                    appendCombinator:[DescendantCombinator new]
                                     matcher:[UniversalMatcher new]];

    assertThat(mismatchEverySubjectMatchEveryRelative, isNot([MatchesView view:leaf]));
}

- (void)testMismatchesIfRelativesMismatch {
    id <SubjectMatcher> matchEverySubjectMismatchEveryRelative =
            [[BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]]
                    appendCombinator:[DescendantCombinator new]
                                  matcher:[FalseMatcher new]];

    assertThat(matchEverySubjectMismatchEveryRelative, isNot([MatchesView view:middle]));
}

- (void)testMismatchesIfCombinatorYieldsNoRelatives {
    id <SubjectMatcher> combinatorYieldsNoRelatives =
            [[BranchMatcher matcherWithSubjectMatcher:[UniversalMatcher new]]
                    appendCombinator:[EmptySetCombinator new]
                                  matcher:[UniversalMatcher new]];

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
    BranchMatcher *subjectOnly = [BranchMatcher matcherWithSubjectMatcher:[IdentityMatcher matcherWithView:middle]];
    BranchMatcher *branchMatcher = [subjectOnly appendCombinator:[ChildCombinator new] matcher:[FalseMatcher new]];
    NSLog(@"Branch matcher is %@", branchMatcher);

    assertThat(branchMatcher, isNot([MatchesView view:middle]));
}

- (void)testCombinatorMatcherProblem {
    // $[accessibilityHint='middle'] [accessibilityHint='middle'] [accessibilityHint='leaf']
    id <SimpleMatcher> leafMatcher =  [PredicateMatcher matcherForPredicateExpression:@"accessibilityHint='leaf'"];
    id <SimpleMatcher> innerMiddleMatcher = [PredicateMatcher matcherForPredicateExpression:@"accessibilityHint='middle'"];
    id <SimpleMatcher> outerMiddleMatcher = [IdentityMatcher matcherWithView:middle];
    id <SubjectMatcher> middleInMiddle = [CombinatorMatcher matcherWithRelativeMatcher:outerMiddleMatcher combinator:[DescendantCombinator new] subjectMatcher:innerMiddleMatcher];
    id <SubjectMatcher> leafInMiddleInMiddle = [CombinatorMatcher matcherWithRelativeMatcher:middleInMiddle combinator:[DescendantCombinator new] subjectMatcher:leafMatcher];

    NSLog(@"Combinator matcher is %@", leafInMiddleInMiddle);
    assertThat(leafInMiddleInMiddle, isNot([MatchesView view:leaf]));
}

@end
