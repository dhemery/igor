#include "IdentityMatcher.h"
#include "ViewFactory.h"
#import "TrueMatcher.h"
#import "MatchesView.h"
#import "ComplexMatcher.h"

@interface RelationshipMatcherTests : SenTestCase
@end

@implementation RelationshipMatcherTests {
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

- (void)testMatchesMatchingSubjectWithMatchingParent {
    IdentityMatcher *const matchesRoot = [IdentityMatcher forView:root];
    IdentityMatcher *const matchesMiddle = [IdentityMatcher forView:middle];
    ComplexMatcher *middleWithRootAncestor = [ComplexMatcher withHead:matchesRoot subject:matchesMiddle];
    assertThat(middleWithRootAncestor, [MatchesView view:middle inTree:root]);
    assertThat(middleWithRootAncestor, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testMatchesMatchingSubjectWithMatchingAncestor {
    IdentityMatcher *const matchesLeaf = [IdentityMatcher forView:leaf];
    IdentityMatcher *const matchesRoot = [IdentityMatcher forView:root];
    ComplexMatcher *leafWithRootAncestor = [ComplexMatcher withHead:matchesRoot subject:matchesLeaf];

    assertThat(leafWithRootAncestor, isNot([MatchesView view:root inTree:root]));
    assertThat(leafWithRootAncestor, isNot([MatchesView view:middle inTree:root]));
    assertThat(leafWithRootAncestor, [MatchesView view:leaf inTree:root]);
}

- (void)testMismatchesMatchingSubjectWithNoMatchingAncestors {
    IdentityMatcher *const matchesLeaf = [IdentityMatcher forView:leaf];
    ComplexMatcher *leafWithLeafAncestor = [ComplexMatcher withHead:matchesLeaf subject:matchesLeaf];
    assertThat(leafWithLeafAncestor, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testExaminesAncestorsUpToGivenRoot {
    IdentityMatcher *const matchesLeaf = [IdentityMatcher forView:leaf];
    IdentityMatcher *const matchesMiddle = [IdentityMatcher forView:middle];
    ComplexMatcher *leafWithMiddleAncestor = [ComplexMatcher withHead:matchesMiddle subject:matchesLeaf];
    assertThat(leafWithMiddleAncestor, [MatchesView view:leaf inTree:middle]);
}

- (void)testExaminesAncestorsOnlyUpToGivenRoot {
    IdentityMatcher *const matchesLeaf = [IdentityMatcher forView:leaf];
    IdentityMatcher *const matchesRoot = [IdentityMatcher forView:root];
    ComplexMatcher *leafWithRootAncestor = [ComplexMatcher withHead:matchesRoot subject:matchesLeaf];
    assertThat(leafWithRootAncestor, isNot([MatchesView view:leaf inTree:middle]));
}

- (void)testMatchesAcrossUniversalClassMatcher {
    id<SubjectMatcher> matchesRoot = [IdentityMatcher forView:root];
    id<SubjectMatcher> matchesLeaf = [IdentityMatcher forView:leaf];
    id<SubjectMatcher> matchesAny = [TrueMatcher new];
    ComplexMatcher *matchesAnyViewInRoot = [ComplexMatcher withHead:matchesRoot subject:matchesAny];
    ComplexMatcher *leafInsideAnyViewInsideRootMatcher = [ComplexMatcher withHead:matchesAnyViewInRoot subject:matchesLeaf ];

    assertThat(leafInsideAnyViewInsideRootMatcher, [MatchesView view:leaf inTree:root]);
}
@end
