#import "ViewFactory.h"
#import "MatchesView.h"
#import "DEMatcher.h"
#import "DEAccessibilityIdentifierMatcher.h"

@interface IdentifierMatcherTests : XCTestCase
@end

@implementation IdentifierMatcherTests

- (void)testMatchesAViewIfItsAccessibilityIdentifierEqualsTheDesignatedIdentifier {
    UIView *fred = [ViewFactory viewWithName:@"fred"];
    id <DEMatcher> fredMatcher = [DEAccessibilityIdentifierMatcher matcherWithAccessibilityIdentifier:@"fred"];

    assertThat(fredMatcher, [MatchesView view:fred]);
}

- (void)testMismatchesAViewIfItsAccessibilityIdentifierDoesNotEqualTheDesignatedIdentifier {
    UIView *fred = [ViewFactory viewWithName:@"fred"];
    id <DEMatcher> barneyMatcher = [DEAccessibilityIdentifierMatcher matcherWithAccessibilityIdentifier:@"barney"];

    assertThat(barneyMatcher, isNot([MatchesView view:fred]));
}

@end
