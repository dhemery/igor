#import "Igor.h"
#import "ViewFactory.h"

@interface PredicatePatternTests : SenTestCase
@end

@implementation PredicatePatternTests {
    Igor *igor;
}

- (void)setUp {
    igor = [Igor new];
}

- (void)testPredicatePattern {
    UIView *view = [ViewFactory buttonWithAccessibilityHint:@"monkeymonkey"];

    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='monkeymonkey']" fromRoot:view];
    expect(matchingViews).toContain(view);

    matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='fiddlefaddle']" fromRoot:view];
    expect(matchingViews).Not.toContain(view);

    matchingViews = [igor findViewsThatMatchPattern:@"[nonExistentProperty='monkeymonkey']" fromRoot:view];
    expect(matchingViews).Not.toContain(view);
}

- (void)testPredicatePatternThrowsIfPatternIsUnparseable {
    id notUsed = nil;
    STAssertThrows([igor findViewsThatMatchPattern:@"[this is not a valid predicate]" fromRoot:notUsed], @"Expected predicate parsing exception");
}
@end
