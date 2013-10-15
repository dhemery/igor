#include "DEIgor.h"
#include "ViewFactory.h"

@interface MultiTreeTests : XCTestCase
@end

@implementation MultiTreeTests {
    CGRect frame;
    DEIgor *igor;
}

- (void)setUp {
    igor = [DEIgor igor];
}

- (void)testFindsViewsInMultpleTrees {
    UIView *tree1 = [ViewFactory view];
    UIView *child1 = [ViewFactory viewWithName:@"child 1"];
    [tree1 addSubview:child1];

    UIView *tree2 = [ViewFactory view];
    UIView *child2 = [ViewFactory viewWithName:@"child 2"];
    [tree2 addSubview:child2];
    
    UIView *tree3 = [ViewFactory view];
    UIView *child3 = [ViewFactory viewWithName:@"child 3"];
    [tree3 addSubview:child3];
    
    UIView *tree4 = [ViewFactory view];
    UIView *child4 = [ViewFactory viewWithName:@"child 4"];
    [tree4 addSubview:child4];

    NSArray *trees = @[tree1, tree2, tree3, tree4];
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"*[accessibilityIdentifier BEGINSWITH 'child']" inTrees:trees];

    assertThat(matchingViews, containsInAnyOrder(child1, child2, child3, child4, nil));
}

@end
