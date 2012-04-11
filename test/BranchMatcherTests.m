#import "RelationshipMatcher.h"
#import "IdentityMatcher.h"
#import "BranchMatcher.h"
#import "ViewFactory.h"
#import "MatchesView.h"

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

    assertThat(rootWithLeafDescendant, [MatchesView view:root inTree:root]);
    assertThat(rootWithLeafDescendant, isNot([MatchesView view:middle inTree:root]));
    assertThat(rootWithLeafDescendant, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testSubtreeMatcherExaminesOnlySubviewsOfTheSubject {
    id <SubjectMatcher> leafWithMiddleAncestor = [RelationshipMatcher withSubjectMatcher:[IdentityMatcher forView:leaf] ancestorMatcher:[IdentityMatcher forView:middle]];

    BranchMatcher *middleWithLeafInsideMiddleDescendant = [BranchMatcher
            withSubjectMatcher:[IdentityMatcher forView:middle]
             descendantMatcher:leafWithMiddleAncestor];

    assertThat(middleWithLeafInsideMiddleDescendant, isNot([MatchesView view:middle inTree:root]));
}

@end
