#import "ViewFactory.h"
#import "MatchesView.h"
#import "Matcher.h"
#import "IdentifierMatcher.h"

@interface IdentifierMatcherTests : SenTestCase
@end

@implementation IdentifierMatcherTests

- (void)testMatchesAViewIfItsAccessibilityIdentifierEqualsTheDesignatedIdentifier {
    UIView *fred = [ViewFactory viewWithName:@"fred"];
    id <Matcher> fredMatcher = [IdentifierMatcher matcherWithAccessibilityIdentifier:@"fred"];

    assertThat(fredMatcher, [MatchesView view:fred]);
}

- (void)testMismatchesAViewIfItsAccessibilityIdentifierDoesNotEqualTheDesignatedIdentifier {
    UIView *fred = [ViewFactory viewWithName:@"fred"];
    id <Matcher> barneyMatcher = [IdentifierMatcher matcherWithAccessibilityIdentifier:@"barney"];

    assertThat(barneyMatcher, isNot([MatchesView view:fred]));
}

@end
