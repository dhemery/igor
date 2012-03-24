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

    expect([rootWithLeafDescendant matchesView:root withinTree:root]).toBeTruthy();
    expect([rootWithLeafDescendant matchesView:middle withinTree:root]).toBeFalsy();
    expect([rootWithLeafDescendant matchesView:leaf withinTree:root]).toBeFalsy();
}

- (void)testSubtreeMatcherExaminesOnlySubviewsOfTheSubject {
    id <RelationshipMatcher> leafWithMiddleAncestor = [SubjectAndAncestorMatcher withSubjectMatcher:[IdentityMatcher forView:leaf] ancestorMatcher:[IdentityMatcher forView:middle]];

    SubjectAndDescendantMatcher *middleWithLeafInsideMiddleDescendant = [SubjectAndDescendantMatcher
            withSubjectMatcher:[IdentityMatcher forView:middle]
             descendantMatcher:leafWithMiddleAncestor];

    expect([middleWithLeafInsideMiddleDescendant matchesView:middle withinTree:root]).toBeFalsy();
}

@end
