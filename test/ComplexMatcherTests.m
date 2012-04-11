#import "ViewFactory.h"
#import "ComplexMatcher.h"
#import "MatchesView.h"
#import "InstanceMatcher.h"
#import "IdentityMatcher.h"

@interface ComplexMatcherTests : SenTestCase
@end

@implementation ComplexMatcherTests {
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

- (void)testMatchingSubject {
    id<SubjectMatcher> subject = [IdentityMatcher forView:middle];

    ComplexMatcher *middleMatcher = [ComplexMatcher withSubject:subject];

    assertThat(middleMatcher, [MatchesView view:middle inTree:root]);
}

- (void)testMismatchingSubject {
    id<SubjectMatcher> subject = [IdentityMatcher forView:middle];

    ComplexMatcher *middleMatcher = [ComplexMatcher withSubject:subject];

    assertThat(middleMatcher, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testMatchingSubjectMatchingHead {
    id<SubjectMatcher> head = [IdentityMatcher forView:root];
    id<SubjectMatcher> subject = [IdentityMatcher forView:middle];

    ComplexMatcher *middleInRoot = [ComplexMatcher withHead:head subject:subject];

    assertThat(middleInRoot, [MatchesView view:middle inTree:root]);
}

- (void)testMatchingSubjectMismatchingHead {
    id<SubjectMatcher> head = [IdentityMatcher forView:leaf];
    id<SubjectMatcher> subject = [IdentityMatcher forView:middle];

    ComplexMatcher *middleInLeaf = [ComplexMatcher withHead:head subject:subject];

    assertThat(middleInLeaf, isNot([MatchesView view:middle inTree:root]));
}

@end
