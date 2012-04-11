#import "ViewFactory.h"
#import "PredicateMatcher.h"
#import "ComplexMatcher.h"
#import "MatchesView.h"

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

- (void)testSubject {
    ComplexMatcher *matcher = [ComplexMatcher withSubject:[PredicateMatcher withPredicateExpression:@"accessibilityHint='middle'"]];

    assertThat(matcher, [MatchesView view:middle inTree:root]);
}

@end
