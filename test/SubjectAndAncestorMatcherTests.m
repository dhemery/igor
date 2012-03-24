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
    expect([middleWithRootAncestor matchesView:middle withinTree:root]).toBeTruthy();
    expect([middleWithRootAncestor matchesView:leaf withinTree:root]).toBeFalsy();
}

- (void)testMatchesMatchingSubjectWithMatchingAncestor {
    SubjectAndAncestorMatcher *leafWithRootAncestor = [SubjectAndAncestorMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:root]];
    expect([leafWithRootAncestor matchesView:root withinTree:root]).toBeFalsy();
    expect([leafWithRootAncestor matchesView:middle withinTree:root]).toBeFalsy();
    expect([leafWithRootAncestor matchesView:leaf withinTree:root]).toBeTruthy();
}

- (void)testMismatchesMatchingSubjectWithNoMatchingAncestors {
    SubjectAndAncestorMatcher *leafWithLeafAncestor = [SubjectAndAncestorMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:leaf]];
    expect([leafWithLeafAncestor matchesView:leaf withinTree:root]).toBeFalsy();
}

- (void)testExaminesAncestorsUpToGivenRoot {
    SubjectAndAncestorMatcher *leafWithMiddleAncestor = [SubjectAndAncestorMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                      ancestorMatcher:[IdentityMatcher forView:middle]];
    expect([leafWithMiddleAncestor matchesView:leaf withinTree:middle]).toBeTruthy();
}

- (void)testExaminesAncestorsOnlyUpToGivenRoot {
    SubjectAndAncestorMatcher *leafWithRootAncestor = [SubjectAndAncestorMatcher withSubjectMatcher:[IdentityMatcher forView:leaf]
                                                                                    ancestorMatcher:[IdentityMatcher forView:root]];
    expect([leafWithRootAncestor matchesView:leaf withinTree:middle]).toBeFalsy();
}

- (void)testMatchesAcrossUniversalClassMatcher {
    NodeMatcher *rootMatcher = [IdentityMatcher forView:root];
    NodeMatcher *leafMatcher = [IdentityMatcher forView:leaf];
    NodeMatcher *anyViewMatcher = [AlwaysMatcher new];
    SubjectAndAncestorMatcher *anyViewInsideRootMatcher = [SubjectAndAncestorMatcher withSubjectMatcher:anyViewMatcher ancestorMatcher:rootMatcher];
    SubjectAndAncestorMatcher *leafInsideAnyViewInsideRootMatcher = [SubjectAndAncestorMatcher withSubjectMatcher:leafMatcher ancestorMatcher:anyViewInsideRootMatcher];
    expect([leafInsideAnyViewInsideRootMatcher matchesView:leaf withinTree:root]).toBeTruthy();
}
@end
