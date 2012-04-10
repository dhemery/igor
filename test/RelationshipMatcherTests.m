#include "RelationshipMatcher.h"
#include "IdentityMatcher.h"
#include "ViewFactory.h"
#import "AlwaysMatcher.h"

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
    assertThatBool([middleWithRootAncestor matchesView:middle withinTree:root], equalToBool(YES));
    assertThatBool([middleWithRootAncestor matchesView:leaf withinTree:root], equalToBool(NO));
}

- (void)testMatchesMatchingSubjectWithMatchingAncestor {
    RelationshipMatcher *leafWithRootAncestor = [RelationshipMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:root]];
    assertThatBool([leafWithRootAncestor matchesView:root withinTree:root], equalToBool(NO));
    assertThatBool([leafWithRootAncestor matchesView:middle withinTree:root], equalToBool(NO));
    assertThatBool([leafWithRootAncestor matchesView:leaf withinTree:root], equalToBool(YES));
}

- (void)testMismatchesMatchingSubjectWithNoMatchingAncestors {
    RelationshipMatcher *leafWithLeafAncestor = [RelationshipMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:leaf]];
    assertThatBool([leafWithLeafAncestor matchesView:leaf withinTree:root], equalToBool(NO));
}

- (void)testExaminesAncestorsUpToGivenRoot {
    RelationshipMatcher *leafWithMiddleAncestor = [RelationshipMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                      ancestorMatcher:[IdentityMatcher forView:middle]];
    assertThatBool([leafWithMiddleAncestor matchesView:leaf withinTree:middle], equalToBool(YES));
}

- (void)testExaminesAncestorsOnlyUpToGivenRoot {
    RelationshipMatcher *leafWithRootAncestor = [RelationshipMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:root]];
    assertThatBool([leafWithRootAncestor matchesView:leaf withinTree:middle], equalToBool(NO));
}

- (void)testMatchesAcrossUniversalClassMatcher {
    id<SubjectMatcher> rootMatcher = [IdentityMatcher forView:root];
    id<SubjectMatcher> leafMatcher = [IdentityMatcher forView:leaf];
    id<SubjectMatcher> anyViewMatcher = [AlwaysMatcher new];
    RelationshipMatcher *anyViewInsideRootMatcher = [RelationshipMatcher withSubjectMatcher:anyViewMatcher ancestorMatcher:rootMatcher];
    RelationshipMatcher *leafInsideAnyViewInsideRootMatcher = [RelationshipMatcher withSubjectMatcher:leafMatcher ancestorMatcher:anyViewInsideRootMatcher];
    assertThatBool([leafInsideAnyViewInsideRootMatcher matchesView:leaf withinTree:root], equalToBool(YES));
}
@end
