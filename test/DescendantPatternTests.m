#import "Igor.h"
#import "ViewFactory.h"

@interface DescendantPatternTests : SenTestCase
@end

@implementation DescendantPatternTests {
    Igor *igor;
}

- (void)setUp {
    igor = [Igor new];
}

- (void)testFindsMatchingChildren {
    UIView *top = [ViewFactory buttonWithAccessibilityHint:@"top"];
    UIView *matchingSubview = [ViewFactory buttonWithAccessibilityHint:@"matches"];
    UIView *nonMatchingSubview = [ViewFactory buttonWithAccessibilityHint:@"does not match"];
    [top addSubview:matchingSubview];
    [top addSubview:nonMatchingSubview];

    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='top'] [accessibilityHint='matches']" fromRoot:top];
    expect(matchingViews).toContain(matchingSubview);
    expect(matchingViews).Not.toContain(nonMatchingSubview);
}

- (void)testFindsMatchingDescendants {
    UIView *top = [ViewFactory buttonWithAccessibilityHint:@"top"];
    UIView *interveningView = [ViewFactory buttonWithAccessibilityHint:@"does not match"];
    UIView *matchingDescendant = [ViewFactory buttonWithAccessibilityHint:@"matches"];
    [top addSubview:interveningView];
    [interveningView addSubview:matchingDescendant];

    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='top'] [accessibilityHint='matches']" fromRoot:top];
    expect(matchingViews).toContain(matchingDescendant);
    expect(matchingViews).Not.toContain(interveningView);
}

- (void)testFindsAcrossUniversalClassMatcher {
    UIView *top = [ViewFactory buttonWithAccessibilityHint:@"top"];
    UIView *interveningView = [ViewFactory buttonWithAccessibilityHint:@"does not match"];
    UIView *matchingDescendant = [ViewFactory buttonWithAccessibilityHint:@"matches"];
    [top addSubview:interveningView];
    [interveningView addSubview:matchingDescendant];

    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='top'] * [accessibilityHint='matches']" fromRoot:top];
    expect(matchingViews).toContain(matchingDescendant);
    expect(matchingViews).Not.toContain(interveningView);
}

- (void)testRequiresMatchForEachUniversalClassMatcher {
    UIView *top = [ViewFactory buttonWithAccessibilityHint:@"top"];
    UIView *interveningView = [ViewFactory buttonWithAccessibilityHint:@"does not match"];
    UIView *matchingDescendant = [ViewFactory buttonWithAccessibilityHint:@"matches"];
    [top addSubview:interveningView];
    [interveningView addSubview:matchingDescendant];

    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='top'] * * [accessibilityHint='matches']" fromRoot:top];
    expect(matchingViews.count).toEqual(0);
}

@end
