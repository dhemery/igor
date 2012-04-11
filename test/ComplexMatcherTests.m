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
    UIButton *notInTree;
}

- (void)setUp {
    root = [ViewFactory buttonWithAccessibilityHint:@"root"];
    middle = [ViewFactory buttonWithAccessibilityHint:@"middle"];
    leaf = [ViewFactory buttonWithAccessibilityHint:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
    notInTree = [ViewFactory buttonWithAccessibilityHint:@"not in tree"];
}

- (void)testMatchingSubject {
    id<SubjectMatcher> subject = [IdentityMatcher forView:middle];

    ComplexMatcher *middleMatcher = [ComplexMatcher withSubject:subject];

    assertThat(middleMatcher, [MatchesView view:middle inTree:root]);
}

- (void)testMismatchingSubject {
    id<SubjectMatcher> subject = [IdentityMatcher forView:middle];

    ComplexMatcher *middleMatcher = [ComplexMatcher withSubject:subject];

    assertThat(middleMatcher, isNot([MatchesView view:notInTree inTree:root]));
}

- (void)testMatchingSubjectMatchingHead {
    NSArray *head = [NSArray arrayWithObject:[IdentityMatcher forView:root]];
    id <SubjectMatcher> subject = [IdentityMatcher forView:middle];

    ComplexMatcher *middleInRoot = [ComplexMatcher withHead:head subject:subject];

    assertThat(middleInRoot, [MatchesView view:middle inTree:root]);
}

- (void)testMatchingSubjectMismatchingHead {
    NSArray *head = [NSArray arrayWithObject:[IdentityMatcher forView:leaf]];
    id<SubjectMatcher> subject = [IdentityMatcher forView:middle];

    ComplexMatcher *middleInLeaf = [ComplexMatcher withHead:head subject:subject];

    assertThat(middleInLeaf, isNot([MatchesView view:middle inTree:root]));
}

@end
