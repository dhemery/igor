#include "SubjectAndAncestorMatcher.h"
#include "IdentityMatcher.h"
#include "ViewFactory.h"
#import "AlwaysMatcher.h"

@interface SubjectAndAncestorMatcherTests : SenTestCase
@end

@implementation SubjectAndAncestorMatcherTests {
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
    SubjectAndAncestorMatcher *middleWithRootAncestor = [SubjectAndAncestorMatcher withSubjectMatcher:[IdentityMatcher forView:middle]
                                                                                      ancestorMatcher:[IdentityMatcher forView:root]];
    assertThatBool([middleWithRootAncestor matchesView:middle withinTree:root], equalToBool(YES));
    assertThatBool([middleWithRootAncestor matchesView:leaf withinTree:root], equalToBool(NO));
}

- (void)testMatchesMatchingSubjectWithMatchingAncestor {
    SubjectAndAncestorMatcher *leafWithRootAncestor = [SubjectAndAncestorMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:root]];
    assertThatBool([leafWithRootAncestor matchesView:root withinTree:root], equalToBool(NO));
    assertThatBool([leafWithRootAncestor matchesView:middle withinTree:root], equalToBool(NO));
    assertThatBool([leafWithRootAncestor matchesView:leaf withinTree:root], equalToBool(YES));
}

- (void)testMismatchesMatchingSubjectWithNoMatchingAncestors {
    SubjectAndAncestorMatcher *leafWithLeafAncestor = [SubjectAndAncestorMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:leaf]];
    assertThatBool([leafWithLeafAncestor matchesView:leaf withinTree:root], equalToBool(NO));
}

- (void)testExaminesAncestorsUpToGivenRoot {
    SubjectAndAncestorMatcher *leafWithMiddleAncestor = [SubjectAndAncestorMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                      ancestorMatcher:[IdentityMatcher forView:middle]];
    assertThatBool([leafWithMiddleAncestor matchesView:leaf withinTree:middle], equalToBool(YES));
}

- (void)testExaminesAncestorsOnlyUpToGivenRoot {
    SubjectAndAncestorMatcher *leafWithRootAncestor = [SubjectAndAncestorMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:root]];
    assertThatBool([leafWithRootAncestor matchesView:leaf withinTree:middle], equalToBool(NO));
}

- (void)testMatchesAcrossUniversalClassMatcher {
    NodeMatcher *rootMatcher = [IdentityMatcher forView:root];
    NodeMatcher *leafMatcher = [IdentityMatcher forView:leaf];
    NodeMatcher *anyViewMatcher = [AlwaysMatcher new];
    SubjectAndAncestorMatcher *anyViewInsideRootMatcher = [SubjectAndAncestorMatcher withSubjectMatcher:anyViewMatcher ancestorMatcher:rootMatcher];
    SubjectAndAncestorMatcher *leafInsideAnyViewInsideRootMatcher = [SubjectAndAncestorMatcher withSubjectMatcher:leafMatcher ancestorMatcher:anyViewInsideRootMatcher];
    assertThatBool([leafInsideAnyViewInsideRootMatcher matchesView:leaf withinTree:root], equalToBool(YES));
}
@end
