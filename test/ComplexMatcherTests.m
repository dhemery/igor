#import "ViewFactory.h"
#import "ComplexMatcher.h"
#import "MatchesView.h"
#import "InstanceMatcher.h"
#import "IdentityMatcher.h"
#import "FalseMatcher.h"

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
    id<SubjectMatcher> matchesMiddle = [IdentityMatcher forView:middle];

    ComplexMatcher *middleAnywhere = [ComplexMatcher withSubject:matchesMiddle];

    assertThat(middleAnywhere, [MatchesView view:middle inTree:root]);
}

- (void)testMismatchingSubject {
    id<SubjectMatcher> matchesMiddle = [IdentityMatcher forView:middle];

    ComplexMatcher *middleAnywhere = [ComplexMatcher withSubject:matchesMiddle];

    assertThat(middleAnywhere, isNot([MatchesView view:leaf inTree:root]));
}

- (void)testMatchingSubjectMatchingHead {
    id<SubjectMatcher> matchesRoot = [IdentityMatcher forView:root];
    id<SubjectMatcher> matchesMiddle = [IdentityMatcher forView:middle];

    ComplexMatcher *middleInRoot = [ComplexMatcher withHead:matchesRoot subject:matchesMiddle];

    assertThat(middleInRoot, [MatchesView view:middle inTree:root]);
}

- (void)testMatchingSubjectMismatchingHead {
    id<SubjectMatcher> neverMatches = [FalseMatcher new];
    id<SubjectMatcher> matchesMiddle = [IdentityMatcher forView:middle];

    ComplexMatcher *middleInNonExistent = [ComplexMatcher withHead:neverMatches subject:matchesMiddle];

    assertThat(middleInNonExistent, isNot([MatchesView view:middle inTree:root]));
}

@end
