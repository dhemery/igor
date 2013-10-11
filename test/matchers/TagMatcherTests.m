#import "ViewFactory.h"
#import "DEMatcher.h"
#import "DETagMatcher.h"
#import "MatchesView.h"

@interface TagMatcherTests : XCTestCase

@end

@implementation TagMatcherTests {
    NSInteger tag;
    UIView *view8765;
}

-(void) setUp {
    tag = 8765;
    view8765 = [ViewFactory viewWithName:@"view8765"];
    view8765.tag = tag;
}

- (void)testMatchesAViewIfItsAccessibilityIdentifierEqualsTheDesignatedIdentifier {
    id <DEMatcher> tag8765Matcher = [DETagMatcher matcherWithTag:tag];

    assertThat(tag8765Matcher, [MatchesView view:view8765]);
}

- (void)testMismatchesAViewIfItsAccessibilityIdentifierDoesNotEqualTheDesignatedIdentifier {
    id <DEMatcher> tag1234Matcher = [DETagMatcher matcherWithTag:1234];

    assertThat(tag1234Matcher, isNot([MatchesView view:view8765]));
}

@end
