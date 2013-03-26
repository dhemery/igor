#import "ViewFactory.h"
#import "MatchesView.h"
#import "DEMatcher.h"
#import "DEIdentifierMatcher.h"

@interface IdentifierMatcherTests : SenTestCase
@end

@implementation IdentifierMatcherTests

- (void)testMatchesAViewIfItsAccessibilityIdentifierEqualsTheDesignatedIdentifier {
    id fred = [ViewFactory viewWithName:@"fred"];
    id <DEMatcher> fredMatcher = [DEIdentifierMatcher matcherWithAccessibilityIdentifier:@"fred"];

    assertThat(fredMatcher, [MatchesView view:fred]);
}

- (void)testMismatchesAViewIfItsAccessibilityIdentifierDoesNotEqualTheDesignatedIdentifier {
    id fred = [ViewFactory viewWithName:@"fred"];
    id <DEMatcher> barneyMatcher = [DEIdentifierMatcher matcherWithAccessibilityIdentifier:@"barney"];

    assertThat(barneyMatcher, isNot([MatchesView view:fred]));
}

@end
