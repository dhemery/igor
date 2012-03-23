#import "DescendantCombinatorMatcher.h"
#import "IdentityMatcher.h"
#import "SubjectSubtreeMatcher.h"
#import "ViewFactory.h"

@interface SubjectSubtreeMatcherTests : SenTestCase
@end

@implementation SubjectSubtreeMatcherTests {
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
    SubjectSubtreeMatcher *rootWithLeafDescendant = [SubjectSubtreeMatcher
            withSubjectMatcher:[IdentityMatcher forView:root]
                subtreeMatcher:[IdentityMatcher forView:leaf]];

    expect([rootWithLeafDescendant matchesView:root withinTree:root]).toBeTruthy();
    expect([rootWithLeafDescendant matchesView:middle withinTree:root]).toBeFalsy();
    expect([rootWithLeafDescendant matchesView:leaf withinTree:root]).toBeFalsy();
}

- (void)testSubtreeMatcherExaminesOnlySubviewsOfTheSubject {
    id<RelationshipMatcher> leafWithMiddleAncestor = [DescendantCombinatorMatcher
            withAncestorMatcher:[IdentityMatcher forView:middle]
              descendantMatcher:[IdentityMatcher forView:leaf]];

    SubjectSubtreeMatcher *middleWithLeafInsideMiddleDescendant = [SubjectSubtreeMatcher
            withSubjectMatcher:[IdentityMatcher forView:middle]
                subtreeMatcher:leafWithMiddleAncestor];

    expect([middleWithLeafInsideMiddleDescendant matchesView:middle withinTree:root]).toBeFalsy();
}

@end
