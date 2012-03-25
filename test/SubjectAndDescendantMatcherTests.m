#import "SubjectAndAncestorMatcher.h"
#import "IdentityMatcher.h"
#import "SubjectAndDescendantMatcher.h"
#import "ViewFactory.h"

@interface SubjectAndDescendantMatcherTests : SenTestCase
@end

@implementation SubjectAndDescendantMatcherTests {
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
    SubjectAndDescendantMatcher *rootWithLeafDescendant = [SubjectAndDescendantMatcher
            withSubjectMatcher:[IdentityMatcher forView:root]
             descendantMatcher:[IdentityMatcher forView:leaf]];

    assertThatBool([rootWithLeafDescendant matchesView:root withinTree:root], equalToBool(YES));
    assertThatBool([rootWithLeafDescendant matchesView:middle withinTree:root], equalToBool(NO));
    assertThatBool([rootWithLeafDescendant matchesView:leaf withinTree:root], equalToBool(NO));
}

- (void)testSubtreeMatcherExaminesOnlySubviewsOfTheSubject {
    id <RelationshipMatcher> leafWithMiddleAncestor = [SubjectAndAncestorMatcher withSubjectMatcher:[IdentityMatcher forView:leaf] ancestorMatcher:[IdentityMatcher forView:middle]];

    SubjectAndDescendantMatcher *middleWithLeafInsideMiddleDescendant = [SubjectAndDescendantMatcher
            withSubjectMatcher:[IdentityMatcher forView:middle]
             descendantMatcher:leafWithMiddleAncestor];

    assertThatBool([middleWithLeafInsideMiddleDescendant matchesView:middle withinTree:root], equalToBool(NO));
}

@end
