#import "ViewFactory.h"
#import "DescendantCombinator.h"
#import "ChildCombinator.h"

@interface ChildCombinatorTests : SenTestCase
@end

@implementation ChildCombinatorTests

- (void)testNoRelativesIfNoChildren {
    UIView *subject = [ViewFactory buttonWithAccessibilityHint:@"subject with no children"];
    id <Combinator> combinator = [ChildCombinator new];

    NSArray *relatives = [combinator relativesOfView:subject];

    assertThat(relatives, is(empty()));
}

- (void)testChildIsRelativeIfOneChild {
    UIView *subject = [ViewFactory buttonWithAccessibilityHint:@"subject with one child"];
    UIView *onlyChild = [ViewFactory buttonWithAccessibilityHint:@"only child of subject"];
    [subject addSubview:onlyChild];
    id <Combinator> combinator = [ChildCombinator new];

    NSArray *relatives = [combinator relativesOfView:subject];

    assertThat(relatives, contains(sameInstance(onlyChild), nil));
}

- (void)testAllChildrenAreRelatives {
    UIView *subject = [ViewFactory buttonWithAccessibilityHint:@"subject with many children"];
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
    id <Combinator> combinator = [ChildCombinator new];

    NSArray *relatives = [combinator relativesOfView:subject];

    assertThat(relatives, contains(
            sameInstance(child1),
            sameInstance(child2),
            sameInstance(child3),
            sameInstance(child4),
            sameInstance(child5),
            nil));
}

- (void)testGrandchildrenAreNotRelatives {
    UIView *subject = [ViewFactory buttonWithAccessibilityHint:@"subject"];
    UIView *child = [ViewFactory buttonWithAccessibilityHint:@"child"];
    UIView *grandchild = [ViewFactory buttonWithAccessibilityHint:@"grandchild"];
    [subject addSubview:child];
    [child addSubview:grandchild];
    id <Combinator> combinator = [ChildCombinator new];

    NSArray *relatives = [combinator relativesOfView:subject];

    assertThat(relatives, isNot(hasItem(grandchild)));
}

- (void)testNoInverseRelativesIfNoParent {
    UIView *subject = [ViewFactory buttonWithAccessibilityHint:@"subject with no parent"];
    id <Combinator> combinator = [ChildCombinator new];

    NSArray *relatives = [combinator inverseRelativesOfView:subject];

    assertThat(relatives, is(empty()));
}

- (void)testParentIsInverseRelative {
    UIView *subject = [ViewFactory buttonWithAccessibilityHint:@"subject with parent"];
    UIView *parent = [ViewFactory buttonWithAccessibilityHint:@"parent of subject"];
    [parent addSubview:subject];
    id <Combinator> combinator = [ChildCombinator new];

    NSArray *relatives = [combinator inverseRelativesOfView:subject];

    assertThat(relatives, contains(sameInstance(parent), nil));
}

- (void)testGrandParentIsNotInverseRelative {
    UIView *subject = [ViewFactory buttonWithAccessibilityHint:@"subject with grandparent"];
    UIView *parent = [ViewFactory buttonWithAccessibilityHint:@"parent of subject"];
    UIView *grandparent = [ViewFactory buttonWithAccessibilityHint:@"grandparent of subject"];
    [grandparent addSubview:parent];
    [parent addSubview:subject];
    id <Combinator> combinator = [ChildCombinator new];

    NSArray *relatives = [combinator inverseRelativesOfView:subject];

    assertThat(relatives, isNot(hasItem(grandparent)));
}

- (void)testParentIsInverseRelativeInTreeRootedAtParent {
    UIView *subject = [ViewFactory buttonWithAccessibilityHint:@"subject"];
    UIView *parent = [ViewFactory buttonWithAccessibilityHint:@"parent"];
    [parent addSubview:subject];
    id <Combinator> combinator = [ChildCombinator new];

    NSArray *relatives = [combinator inverseRelativesOfView:subject inTree:parent];

    assertThat(relatives, hasItem(parent));
}

- (void)testParentIsInverseRelativeInTreeRootedAboveParent {
    UIView *subject = [ViewFactory buttonWithAccessibilityHint:@"subject"];
    UIView *parent = [ViewFactory buttonWithAccessibilityHint:@"parent"];
    UIView *grandparent = [ViewFactory buttonWithAccessibilityHint:@"grandparent"];
    [grandparent addSubview:parent];
    [parent addSubview:subject];
    id <Combinator> combinator = [ChildCombinator new];

    NSArray *relatives = [combinator inverseRelativesOfView:subject inTree:grandparent];

    assertThat(relatives, hasItem(parent));
}

- (void)testParentIsNotInverseRelativeInTreeRootedBelowParent {
    UIView *subject = [ViewFactory buttonWithAccessibilityHint:@"subject"];
    UIView *parent = [ViewFactory buttonWithAccessibilityHint:@"parent"];
    UIView *grandparent = [ViewFactory buttonWithAccessibilityHint:@"grandparent"];
    [grandparent addSubview:parent];
    [parent addSubview:subject];
    id <Combinator> combinator = [ChildCombinator new];

    NSArray *relatives = [combinator inverseRelativesOfView:subject inTree:subject];

    assertThat(relatives, isNot(hasItem(parent)));
}

@end

