#import "RelationshipMatcher.h"
#import "IdentityMatcher.h"
#import "BranchMatcher.h"
#import "ViewFactory.h"

@interface BranchMatcherTests : SenTestCase
@end

@implementation BranchMatcherTests {
    UIButton *root;
    UIButton *middle;
    UIButton *leaf;
}

- (void)setUp {
    root = [ViewFactory button];
    middle = [ViewFactory button];
    leaf = [ViewFactory button];
    [root addSubview:middle];
    [middle addSubview:leaf];
}

- (void)testMatchesIfViewMatchesSubjectMatcherAndSubviewMatchesSubtreeMatcher {
    BranchMatcher *rootWithLeafDescendant = [BranchMatcher
            withSubjectMatcher:[IdentityMatcher forView:root]
             descendantMatcher:[IdentityMatcher forView:leaf]];

    assertThatBool([rootWithLeafDescendant matchesView:root withinTree:root], equalToBool(YES));
    assertThatBool([rootWithLeafDescendant matchesView:middle withinTree:root], equalToBool(NO));
    assertThatBool([rootWithLeafDescendant matchesView:leaf withinTree:root], equalToBool(NO));
}

- (void)testSubtreeMatcherExaminesOnlySubviewsOfTheSubject {
    id <SubjectMatcher> leafWithMiddleAncestor = [RelationshipMatcher withSubjectMatcher:[IdentityMatcher forView:leaf] ancestorMatcher:[IdentityMatcher forView:middle]];

    BranchMatcher *middleWithLeafInsideMiddleDescendant = [BranchMatcher
            withSubjectMatcher:[IdentityMatcher forView:middle]
             descendantMatcher:leafWithMiddleAncestor];

    assertThatBool([middleWithLeafInsideMiddleDescendant matchesView:middle withinTree:root], equalToBool(NO));
}

@end
