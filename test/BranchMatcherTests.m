#import "IdentityMatcher.h"
#import "SubjectOnLeftMatcher.h"
#import "ViewFactory.h"
#import "MatchesView.h"
#import "ComplexMatcher.h"

@interface BranchMatcherTests : SenTestCase
@end

@implementation BranchMatcherTests {
    UIButton *root;
    UIButton *middle;
    UIButton *leaf;
    IdentityMatcher *_matchesRoot;
    IdentityMatcher *_matchesLeaf;
    IdentityMatcher *_matchesMiddle;
}

- (void)setUp {
    root = [ViewFactory button];
    middle = [ViewFactory button];
    leaf = [ViewFactory button];
    [root addSubview:middle];
    [middle addSubview:leaf];
    _matchesRoot = [IdentityMatcher forView:root];
    _matchesMiddle = [IdentityMatcher forView:middle];
    _matchesLeaf = [IdentityMatcher forView:leaf];
}

- (void)testMatchesIfViewMatchesSubjectMatcherAndSubviewMatchesSubtreeMatcher {
    id<SubjectMatcher> rootWithLeafDescendant = [SubjectOnLeftMatcher withSubject:_matchesRoot tail:_matchesLeaf];

    assertThat(rootWithLeafDescendant, [MatchesView view:root inTree:root]);
    assertThat(rootWithLeafDescendant, isNot([MatchesView view:middle inTree:root]));
    assertThat(rootWithLeafDescendant, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testSubtreeMatcherExaminesOnlySubviewsOfTheSubject {
    id<SubjectMatcher> leafInMiddle = [ComplexMatcher withHead:_matchesMiddle subject:_matchesLeaf];
    id<SubjectMatcher> middleWithLeafInsideMiddleDescendant = [SubjectOnLeftMatcher withSubject:_matchesMiddle tail:leafInMiddle];

    assertThat(middleWithLeafInsideMiddleDescendant, isNot([MatchesView view:middle inTree:root]));
}

@end
