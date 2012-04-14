#import "ViewFactory.h"
#import "DescendantCombinator.h"

@interface DescendantCombinatorTests : SenTestCase
@end

@implementation DescendantCombinatorTests {
    UIView *subject;
    UIView *parent;
    UIView *grandParent;
    UIView *greatGrandParent;
    UIView *greatGreatGrandParent;
    UIView *greatGreatGreatGrandParent;
}

- (void)setUp {
    subject = [ViewFactory buttonWithAccessibilityHint:@"subject"];
    parent = [ViewFactory buttonWithAccessibilityHint:@"parent"];
    grandParent = [ViewFactory buttonWithAccessibilityHint:@"grandparent"];
    greatGrandParent = [ViewFactory buttonWithAccessibilityHint:@"great grandparent"];
    greatGreatGrandParent = [ViewFactory buttonWithAccessibilityHint:@"great great grandparent"];
    greatGreatGreatGrandParent = [ViewFactory buttonWithAccessibilityHint:@"great great great grandparent"];
    [parent addSubview:subject];
    [grandParent addSubview:parent];
    [greatGrandParent addSubview:grandParent];
    [greatGreatGrandParent addSubview:greatGrandParent];
    [greatGreatGreatGrandParent addSubview:greatGreatGrandParent];
}

- (void)testYieldsAllAncestorsIncludingTreeRoot {
    id <Combinator> combinator = [DescendantCombinator new];

    NSArray *relatives = [combinator inverseRelativesOfView:subject inTree:greatGreatGreatGrandParent];
    assertThat(relatives, contains(
            sameInstance(parent),
            sameInstance(grandParent),
            sameInstance(greatGrandParent),
            sameInstance(greatGreatGrandParent),
            sameInstance(greatGreatGreatGrandParent),
            nil));
}

- (void)testYieldsNoAncestorsAboveTreeRoot {
    id <Combinator> combinator = [DescendantCombinator new];

    NSArray *relatives = [combinator inverseRelativesOfView:subject inTree:grandParent];
    assertThat(relatives, contains(
            sameInstance(parent),
            sameInstance(grandParent),
            nil));
}

@end


