#include "RelationshipMatcher.h"
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
    RelationshipMatcher *middleWithRootAncestor = [RelationshipMatcher withSubjectMatcher:[IdentityMatcher forView:middle]
                                                                                      ancestorMatcher:[IdentityMatcher forView:root]];
    assertThat(middleWithRootAncestor, [MatchesView view:middle inTree:root]);
    assertThat(middleWithRootAncestor, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testMatchesMatchingSubjectWithMatchingAncestor {
    RelationshipMatcher *leafWithRootAncestor = [RelationshipMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:root]];
    assertThat(leafWithRootAncestor, isNot([MatchesView view:root inTree:root]));
    assertThat(leafWithRootAncestor, isNot([MatchesView view:middle inTree:root]));
    assertThat(leafWithRootAncestor, [MatchesView view:leaf inTree:root]);
}

- (void)testMismatchesMatchingSubjectWithNoMatchingAncestors {
    RelationshipMatcher *leafWithLeafAncestor = [RelationshipMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:leaf]];
    assertThat(leafWithLeafAncestor, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testExaminesAncestorsUpToGivenRoot {
    RelationshipMatcher *leafWithMiddleAncestor = [RelationshipMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                      ancestorMatcher:[IdentityMatcher forView:middle]];
    assertThat(leafWithMiddleAncestor, [MatchesView view:leaf inTree:middle]);
}

- (void)testExaminesAncestorsOnlyUpToGivenRoot {
    RelationshipMatcher *leafWithRootAncestor = [RelationshipMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:root]];
    assertThat(leafWithRootAncestor, isNot([MatchesView view:leaf inTree:middle]));
}

- (void)testMatchesAcrossUniversalClassMatcher {
    id<SubjectMatcher> rootMatcher = [IdentityMatcher forView:root];
    id<SubjectMatcher> leafMatcher = [IdentityMatcher forView:leaf];
    id<SubjectMatcher> anyViewMatcher = [AlwaysMatcher new];
    RelationshipMatcher *anyViewInsideRootMatcher = [RelationshipMatcher withSubjectMatcher:anyViewMatcher ancestorMatcher:rootMatcher];
    RelationshipMatcher *leafInsideAnyViewInsideRootMatcher = [RelationshipMatcher withSubjectMatcher:leafMatcher ancestorMatcher:anyViewInsideRootMatcher];

    assertThat(leafInsideAnyViewInsideRootMatcher, [MatchesView view:leaf inTree:root]);
}
@end
