#import "ViewFactory.h"
#import "DEDescendantCombinator.h"

@interface DescendantCombinatorTests : SenTestCase
@end

@implementation DescendantCombinatorTests {
    id <DECombinator> descendantCombinator;
    UIView *subject;
}

- (void)setUp {
    descendantCombinator = [DEDescendantCombinator new];
    subject = [ViewFactory viewWithName:@"subject"];
}

- (void)testNoRelativesIfNoDescendants {
    NSArray *relatives = [descendantCombinator relativesOfView:subject];

    assertThat(relatives, is(empty()));
}

- (void)testChildIsRelativeIfOneChild {
    UIView *child = [ViewFactory viewWithName:@"child"];
    [subject addSubview:child];

    NSArray *relatives = [descendantCombinator relativesOfView:subject];

    assertThat(relatives, contains(sameInstance(child), nil));
}

- (void)testAllChildrenAreRelatives {
    UIView *child1 = [ViewFactory viewWithName:@"child 1"];
    UIView *child2 = [ViewFactory viewWithName:@"child 2"];
    UIView *child3 = [ViewFactory viewWithName:@"child 3"];
    UIView *child4 = [ViewFactory viewWithName:@"child 4"];
    UIView *child5 = [ViewFactory viewWithName:@"child 5"];
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
    UIView *child = [ViewFactory viewWithName:@"child"];
    UIView *grandchild = [ViewFactory viewWithName:@"grandchild"];
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
    UIView *parent = [ViewFactory viewWithName:@"parent"];
    [parent addSubview:subject];

    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject];

    assertThat(relatives, contains(sameInstance(parent), nil));
}

- (void)testGrandParentIsInverseRelative {
    UIView *parent = [ViewFactory viewWithName:@"parent"];
    UIView *grandparent = [ViewFactory viewWithName:@"grandparent"];
    [grandparent addSubview:parent];
    [parent addSubview:subject];

    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject];

    assertThat(relatives, hasItem(grandparent));
}

- (void)testAllAncestorsAreInverseRelatives {
    UIView *parent = [ViewFactory viewWithName:@"parent"];
    UIView *grandparent = [ViewFactory viewWithName:@"grandparent"];
    UIView *greatGrandparent = [ViewFactory viewWithName:@"great grandparent"];
    UIView *greatGreatGrandparent = [ViewFactory viewWithName:@"great great grandparent"];
    UIView *greatGreatGreatGrandparent = [ViewFactory viewWithName:@"great great great grandparent"];
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

@end
