#import "ViewFactory.h"
#import "ComplexMatcher.h"
#import "MatchesView.h"
#import "InstanceMatcher.h"
#import "IdentityMatcher.h"
#import "FalseMatcher.h"
#import "UniversalMatcher.h"

@interface ComplexMatcherTests : SenTestCase
@end

@implementation ComplexMatcherTests {
    UIButton *root;
    UIButton *middle;
    UIButton *leaf;
    id <SubjectMatcher> matchesRoot;
    id <SubjectMatcher> matchesMiddle;
    id <SubjectMatcher> matchesLeaf;
}

- (void)setUp {
    root = [ViewFactory buttonWithAccessibilityHint:@"root"];
    middle = [ViewFactory buttonWithAccessibilityHint:@"middle"];
    leaf = [ViewFactory buttonWithAccessibilityHint:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
    matchesRoot = [IdentityMatcher forView:root];
    matchesMiddle = [IdentityMatcher forView:middle];
    matchesLeaf = [IdentityMatcher forView:leaf];
}

- (void)testSubjectMatchesView {
    id <SubjectMatcher> middleAnywhere = [ComplexMatcher matcherWithSubject:matchesMiddle];

    assertThat(middleAnywhere, [MatchesView view:middle inTree:root]);
}

- (void)testSubjectMismatchesView {
    id <SubjectMatcher> middleAnywhere = [ComplexMatcher matcherWithSubject:matchesMiddle];

    assertThat(middleAnywhere, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testSubjectMatchesViewHeadMatchesParent {
    id <SubjectMatcher> middleInRoot = [ComplexMatcher matcherWithHead:matchesRoot subject:matchesMiddle];

    assertThat(middleInRoot, [MatchesView view:middle inTree:root]);
}

- (void)testSubjectMatchesViewHeadMatchesAncestor {
    id <SubjectMatcher> leafInRoot = [ComplexMatcher matcherWithHead:matchesRoot subject:matchesLeaf];

    assertThat(leafInRoot, [MatchesView view:leaf inTree:root]);
}

- (void)testSubjectMatchesViewHeadMismatchesAllAncestors {
    id <SubjectMatcher> neverMatches = [FalseMatcher new];
    id <SubjectMatcher> middleInNonExistent = [ComplexMatcher matcherWithHead:neverMatches subject:matchesMiddle];

    assertThat(middleInNonExistent, isNot([MatchesView view:middle inTree:root]));
}

- (void)testComparesHeadToViewsUpToGivenRoot {
    id <SubjectMatcher> leafInMiddle = [ComplexMatcher matcherWithHead:matchesMiddle subject:matchesLeaf];

    assertThat(leafInMiddle, [MatchesView view:leaf inTree:middle]);
}

- (void)testDoesNotCompareHeadToViewsAboveGivenRoot {
    id <SubjectMatcher> leafInRoot = [ComplexMatcher matcherWithHead:matchesRoot subject:matchesLeaf];

    assertThat(leafInRoot, isNot([MatchesView view:leaf inTree:middle]));
}

- (void)testMatchesAcrossUniversalMatcher {
    id <SubjectMatcher> universalMatcher = [UniversalMatcher new];
    id <SubjectMatcher> matchesAnyViewInRoot = [ComplexMatcher matcherWithHead:matchesRoot subject:universalMatcher];
    id <SubjectMatcher> leafInAnyViewInRoot = [ComplexMatcher matcherWithHead:matchesAnyViewInRoot subject:matchesLeaf];

    assertThat(leafInAnyViewInRoot, [MatchesView view:leaf inTree:root]);
}





- (void)testMatchesIfViewMatchesSubjectMatcherAndSubviewMatchesSubtreeMatcher {
    id <SubjectMatcher> rootWithInnerLeaf = [ComplexMatcher matcherWithSubject:matchesRoot tail:matchesLeaf];

    assertThat(rootWithInnerLeaf, [MatchesView view:root inTree:root]);
    assertThat(rootWithInnerLeaf, isNot([MatchesView view:middle inTree:root]));
    assertThat(rootWithInnerLeaf, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testSubtreeMatcherExaminesOnlySubviewsOfTheSubject {
    id <SubjectMatcher> leafInMiddle = [ComplexMatcher matcherWithHead:matchesMiddle subject:matchesLeaf];
    id <SubjectMatcher> middleWithLeafInsideMiddleDescendant = [ComplexMatcher matcherWithSubject:matchesMiddle tail:leafInMiddle];

    assertThat(middleWithLeafInsideMiddleDescendant, isNot([MatchesView view:middle inTree:root]));
}


@end
