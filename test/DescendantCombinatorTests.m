#import "ViewFactory.h"
#import "DescendantCombinator.h"

@interface DescendantCombinatorTests : SenTestCase
@end

@implementation DescendantCombinatorTests {
    id <Combinator> descendantCombinator;
    UIView *subject;
}

- (void)setUp {
    descendantCombinator = [DescendantCombinator new];
    subject = [ViewFactory buttonWithAccessibilityHint:@"subject"];
}

- (void)testNoRelativesIfNoDescendants {
    NSArray *relatives = [descendantCombinator relativesOfView:subject];

    assertThat(relatives, is(empty()));
}

- (void)testChildIsRelativeIfOneChild {
    UIView *child = [ViewFactory buttonWithAccessibilityHint:@"child"];
    [subject addSubview:child];

    NSArray *relatives = [descendantCombinator relativesOfView:subject];

    assertThat(relatives, contains(sameInstance(child), nil));
}

- (void)testAllChildrenAreRelatives {
    UIView *child1 = [ViewFactory buttonWithAccessibilityHint:@"child 1"];
    UIView *child2 = [ViewFactory buttonWithAccessibilityHint:@"child 2"];
    UIView *child3 = [ViewFactory buttonWithAccessibilityHint:@"child 3"];
    UIView *child4 = [ViewFactory buttonWithAccessibilityHint:@"child 4"];
    UIView *child5 = [ViewFactory buttonWithAccessibilityHint:@"child 5"];
    [subject addSubview:child1];
    [subject addSubview:child2];
    [subject addSubview:child3];
    [subject addSubview:child4];
    [subject addSubview:child5];

    NSArray *relatives = [descendantCombinator relativesOfView:subject];

    assertThat(relatives, contains(
            sameInstance(child1),
            sameInstance(child2),
            sameInstance(child3),
            sameInstance(child4),
            sameInstance(child5),
            nil));
}

- (void)testGrandchildrenAreRelatives {
    UIView *child = [ViewFactory buttonWithAccessibilityHint:@"child"];
    UIView *grandchild = [ViewFactory buttonWithAccessibilityHint:@"grandchild"];
    [subject addSubview:child];
    [child addSubview:grandchild];

    NSArray *relatives = [descendantCombinator relativesOfView:subject];

    assertThat(relatives, hasItem(sameInstance(grandchild)));
}

- (void)testNoInverseRelativesIfNoParent {
    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject];

    assertThat(relatives, is(empty()));
}

- (void)testParentIsInverseRelative {
    UIView *parent = [ViewFactory buttonWithAccessibilityHint:@"parent"];
    [parent addSubview:subject];

    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject];

    assertThat(relatives, contains(sameInstance(parent), nil));
}

- (void)testGrandParentIsInverseRelative {
    UIView *parent = [ViewFactory buttonWithAccessibilityHint:@"parent"];
    UIView *grandparent = [ViewFactory buttonWithAccessibilityHint:@"grandparent"];
    [grandparent addSubview:parent];
    [parent addSubview:subject];

    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject];

    assertThat(relatives, hasItem(grandparent));
}

- (void)testAllAncestorsAreInverseRelatives {
    UIView *parent = [ViewFactory buttonWithAccessibilityHint:@"parent"];
    UIView *grandparent = [ViewFactory buttonWithAccessibilityHint:@"grandparent"];
    UIView *greatGrandparent = [ViewFactory buttonWithAccessibilityHint:@"great grandparent"];
    UIView *greatGreatGrandparent = [ViewFactory buttonWithAccessibilityHint:@"great great grandparent"];
    UIView *greatGreatGreatGrandparent = [ViewFactory buttonWithAccessibilityHint:@"great great great grandparent"];
    [greatGreatGreatGrandparent addSubview:greatGreatGrandparent];
    [greatGreatGrandparent addSubview:greatGrandparent];
    [greatGrandparent addSubview:grandparent];
    [grandparent addSubview:parent];
    [parent addSubview:subject];

    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject];

    assertThat(relatives, containsInAnyOrder(
                    sameInstance(greatGreatGreatGrandparent),
                    sameInstance(greatGreatGrandparent),
                    sameInstance(greatGrandparent),
                    sameInstance(grandparent),
                    sameInstance(parent),
                    nil));
}

- (void)testAnAncestorIsARelativeInATreeRootedAtThatAncestor {
    UIView *parent = [ViewFactory buttonWithAccessibilityHint:@"parent"];
    UIView *grandparent = [ViewFactory buttonWithAccessibilityHint:@"grandparent"];
    [grandparent addSubview:parent];
    [parent addSubview:subject];

    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject
                                                               inTree:grandparent];

    assertThat(relatives, hasItem(sameInstance(grandparent)));
}

- (void)testAncestorsAreRelativesInTreesRootedAboveThem {
    UIView *parent = [ViewFactory buttonWithAccessibilityHint:@"parent"];
    UIView *grandparent = [ViewFactory buttonWithAccessibilityHint:@"grandparent"];
    UIView *greatGrandparent = [ViewFactory buttonWithAccessibilityHint:@"great grandparent"];
    [greatGrandparent addSubview:grandparent];
    [grandparent addSubview:parent];
    [parent addSubview:subject];

    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject
                                                               inTree:greatGrandparent];

    assertThat(relatives, hasItem(sameInstance(parent)));
    assertThat(relatives, hasItem(sameInstance(grandparent)));
}

- (void)testAncestorsAreNotRelativesInTreesRootedBelowThem {
    UIView *parent = [ViewFactory buttonWithAccessibilityHint:@"parent"];
    UIView *grandparent = [ViewFactory buttonWithAccessibilityHint:@"grandparent"];
    [grandparent addSubview:parent];
    [parent addSubview:subject];

    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject
                                                               inTree:parent];

    assertThat(relatives, isNot(hasItem(grandparent)));
}

@end
