#include "SubjectOnRightMatcher.h"
#include "IdentityMatcher.h"
#include "ViewFactory.h"
#import "AlwaysMatcher.h"
#import "MatchesView.h"

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
    SubjectOnRightMatcher *middleWithRootAncestor = [SubjectOnRightMatcher withSubject:[IdentityMatcher forView:middle]
                                                                                      head:[IdentityMatcher forView:root]];
    assertThat(middleWithRootAncestor, [MatchesView view:middle inTree:root]);
    assertThat(middleWithRootAncestor, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testMatchesMatchingSubjectWithMatchingAncestor {
    SubjectOnRightMatcher *leafWithRootAncestor = [SubjectOnRightMatcher withSubject:[IdentityMatcher forView:leaf]
                                                                                    head:[IdentityMatcher forView:root]];
    assertThat(leafWithRootAncestor, isNot([MatchesView view:root inTree:root]));
    assertThat(leafWithRootAncestor, isNot([MatchesView view:middle inTree:root]));
    assertThat(leafWithRootAncestor, [MatchesView view:leaf inTree:root]);
}

- (void)testMismatchesMatchingSubjectWithNoMatchingAncestors {
    SubjectOnRightMatcher *leafWithLeafAncestor = [SubjectOnRightMatcher withSubject:[IdentityMatcher forView:leaf]
                                                                                    head:[IdentityMatcher forView:leaf]];
    assertThat(leafWithLeafAncestor, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testExaminesAncestorsUpToGivenRoot {
    SubjectOnRightMatcher *leafWithMiddleAncestor = [SubjectOnRightMatcher withSubject:[IdentityMatcher forView:leaf]
                                                                                      head:[IdentityMatcher forView:middle]];
    assertThat(leafWithMiddleAncestor, [MatchesView view:leaf inTree:middle]);
}

- (void)testExaminesAncestorsOnlyUpToGivenRoot {
    SubjectOnRightMatcher *leafWithRootAncestor = [SubjectOnRightMatcher withSubject:[IdentityMatcher forView:leaf]
                                                                                    head:[IdentityMatcher forView:root]];
    assertThat(leafWithRootAncestor, isNot([MatchesView view:leaf inTree:middle]));
}

- (void)testMatchesAcrossUniversalClassMatcher {
    id<SubjectMatcher> rootMatcher = [IdentityMatcher forView:root];
    id<SubjectMatcher> leafMatcher = [IdentityMatcher forView:leaf];
    id<SubjectMatcher> anyViewMatcher = [AlwaysMatcher new];
    SubjectOnRightMatcher *anyViewInsideRootMatcher = [SubjectOnRightMatcher withSubject:anyViewMatcher head:rootMatcher];
    SubjectOnRightMatcher *leafInsideAnyViewInsideRootMatcher = [SubjectOnRightMatcher withSubject:leafMatcher head:anyViewInsideRootMatcher];

    assertThat(leafInsideAnyViewInsideRootMatcher, [MatchesView view:leaf inTree:root]);
}
@end
