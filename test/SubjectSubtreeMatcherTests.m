#import "DescendantCombinatorMatcher.h"
#import "IdentityMatcher.h"
#import "SubjectSubtreeMatcher.h"
#import "ViewFactory.h"

@interface SubjectSubtreeMatcherTests : SenTestCase
@end

@implementation SubjectSubtreeMatcherTests

- (void)testMatchesIfViewMatchesSubjectMatcherAndSubviewMatchesSubtreeMatcher {
    UIButton *root = [ViewFactory button];
    UIButton *middle = [ViewFactory button];
    UIButton *leaf = [ViewFactory button];
    [root addSubview:middle];
    [middle addSubview:leaf];

    SubjectSubtreeMatcher *matcher = [SubjectSubtreeMatcher
            withSubjectMatcher:[IdentityMatcher forView:root]
                subtreeMatcher:[IdentityMatcher forView:leaf]];

    expect([matcher matchesView:root]).toBeTruthy();
    expect([matcher matchesView:middle]).toBeFalsy();
    expect([matcher matchesView:leaf]).toBeFalsy();
}

- (void)testSubtreeMatcherExaminesOnlySubviewsOfTheSubject {
    UIButton *root = [ViewFactory button];
    UIButton *middle = [ViewFactory button];
    UIButton *leaf = [ViewFactory button];
    [root addSubview:middle];
    [middle addSubview:leaf];

    // This matcher matches if it examines ancestors above middle.
    // If it is limited to only subviews of middle, it does not match,
    // because root is above middle.
    Matcher *subtreeMatcher = [DescendantCombinatorMatcher
            withAncestorMatcher:[IdentityMatcher forView:middle]
              descendantMatcher:[IdentityMatcher forView:leaf]];

    SubjectSubtreeMatcher *matcher = [SubjectSubtreeMatcher
            withSubjectMatcher:[IdentityMatcher forView:middle]
                subtreeMatcher:subtreeMatcher];

    expect([matcher matchesView:middle]).toBeFalsy();
}

@end
