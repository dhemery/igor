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
    IdentityMatcher *_matchesRoot;
    IdentityMatcher *_matchesMiddle;
    IdentityMatcher *_matchesLeaf;
}

- (void)setUp {
    root = [ViewFactory buttonWithAccessibilityHint:@"root"];
    middle = [ViewFactory buttonWithAccessibilityHint:@"middle"];
    leaf = [ViewFactory buttonWithAccessibilityHint:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
    _matchesRoot = [IdentityMatcher forView:root];
    _matchesMiddle = [IdentityMatcher forView:middle];
    _matchesLeaf = [IdentityMatcher forView:leaf];
}

- (void)testSubjectMatchesView {
    ComplexMatcher *middleAnywhere = [ComplexMatcher withSubject:_matchesMiddle];

    assertThat(middleAnywhere, [MatchesView view:middle inTree:root]);
}

- (void)testSubjectMismatchesView {
    ComplexMatcher *middleAnywhere = [ComplexMatcher withSubject:_matchesMiddle];

    assertThat(middleAnywhere, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testSubjectMatchesViewHeadMatchesParent {
    ComplexMatcher *middleInRoot = [ComplexMatcher withHead:_matchesRoot subject:_matchesMiddle];

    assertThat(middleInRoot, [MatchesView view:middle inTree:root]);
}

- (void)testSubjectMatchesViewHeadMatchesAncestor {
    ComplexMatcher *leafInRoot = [ComplexMatcher withHead:_matchesRoot subject:_matchesLeaf];

    assertThat(leafInRoot, [MatchesView view:leaf inTree:root]);
}

- (void)testSubjectMatchesViewHeadMismatchesAllAncestors {
    id<SubjectMatcher> neverMatches = [FalseMatcher new];

    ComplexMatcher *middleInNonExistent = [ComplexMatcher withHead:neverMatches subject:_matchesMiddle];

    assertThat(middleInNonExistent, isNot([MatchesView view:middle inTree:root]));
}

- (void)testComparesHeadToViewsUpToGivenRoot {
    ComplexMatcher *leafInMiddle = [ComplexMatcher withHead:_matchesMiddle subject:_matchesLeaf];

    assertThat(leafInMiddle, [MatchesView view:leaf inTree:middle]);
}

- (void)testDoesNotCompareHeadToViewsAboveGivenRoot {
    ComplexMatcher *leafInRoot = [ComplexMatcher withHead:_matchesRoot subject:_matchesLeaf];

    assertThat(leafInRoot, isNot([MatchesView view:leaf inTree:middle]));
}

- (void)testMatchesAcrossUniversalMatcher {
    id<SubjectMatcher> universalMatcher = [UniversalMatcher new];
    id<SubjectMatcher> matchesAnyViewInRoot = [ComplexMatcher withHead:_matchesRoot subject:universalMatcher];
    id<SubjectMatcher> leafInAnyViewInRoot = [ComplexMatcher withHead:matchesAnyViewInRoot subject:_matchesLeaf ];

    assertThat(leafInAnyViewInRoot, [MatchesView view:leaf inTree:root]);
}

@end
