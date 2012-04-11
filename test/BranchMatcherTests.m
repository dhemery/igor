#import "SubjectOnRightMatcher.h"
#import "IdentityMatcher.h"
#import "SubjectOnLeftMatcher.h"
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
    SubjectOnLeftMatcher *rootWithLeafDescendant = [SubjectOnLeftMatcher withSubject:[IdentityMatcher forView:root] tail:[IdentityMatcher forView:leaf]];

    assertThat(rootWithLeafDescendant, [MatchesView view:root inTree:root]);
    assertThat(rootWithLeafDescendant, isNot([MatchesView view:middle inTree:root]));
    assertThat(rootWithLeafDescendant, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testSubtreeMatcherExaminesOnlySubviewsOfTheSubject {
    id <SubjectMatcher> leafWithMiddleAncestor = [SubjectOnRightMatcher withSubject:[IdentityMatcher forView:leaf] head:[IdentityMatcher forView:middle]];

    SubjectOnLeftMatcher *middleWithLeafInsideMiddleDescendant = [SubjectOnLeftMatcher
            withSubject:[IdentityMatcher forView:middle]
             tail:leafWithMiddleAncestor];

    assertThat(middleWithLeafInsideMiddleDescendant, isNot([MatchesView view:middle inTree:root]));
}

@end
