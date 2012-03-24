#import "Igor.h"
#import "ViewFactory.h"

@interface SubjectAndAncestorPatternTests : SenTestCase
@end

@implementation SubjectAndAncestorPatternTests {
    Igor *igor;
    UIView *root;
    UIView *middle;
    UIView *leaf;
}

- (void)setUp {
    igor = [Igor new];
    root = [ViewFactory buttonWithAccessibilityHint:@"root"];
    middle = [ViewFactory buttonWithAccessibilityHint:@"middle"];
    leaf = [ViewFactory buttonWithAccessibilityHint:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
}

- (void)testMatchesMatchingSubjectsWithMatchingParent {
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='root'] [accessibilityHint='middle']" fromRoot:root];
    expect(matchingViews).toContain(middle);
    expect(matchingViews.count).toEqual(1);
}

- (void)testMatchesMatchingSubjectsWithMatchingAncestors {
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='root'] [accessibilityHint='leaf']" fromRoot:root];
    expect(matchingViews).toContain(leaf);
    expect(matchingViews.count).toEqual(1);
}

- (void)testMatchesAcrossUniversalClassMatcher {
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='root'] * [accessibilityHint='leaf']" fromRoot:root];
    expect(matchingViews).toContain(leaf);
    expect(matchingViews.count).toEqual(1);
}

- (void)testRequiresMatchForEachUniversalClassMatcher {
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='root'] * * [accessibilityHint='leaf']" fromRoot:root];
    expect(matchingViews.count).toEqual(0);
}

@end
