#import "DEIgor.h"
#import "ViewFactory.h"

@interface ClassPatternTests : SenTestCase
@end

@implementation ClassPatternTests {
    CGRect frame;
    DEIgor *igor;
}

- (void)setUp {
    igor = [DEIgor igor];
}

- (void)testAnyClassPattern {
    NSString *query = @"*";

    id root = [ViewFactory viewWithName:@"root"];
    id view1 = [ViewFactory viewWithName:@"view1"];
    id view11 = [ViewFactory viewWithName:@"view11"];
    id view12 = [ViewFactory viewWithName:@"view12"];
    id view2 = [ViewFactory viewWithName:@"view2"];
    id view21 = [ViewFactory viewWithName:@"view21"];
    id view211 = [ViewFactory viewWithName:@"view211"];
    id view212 = [ViewFactory viewWithName:@"view212"];
    id view213 = [ViewFactory viewWithName:@"view213"];
    id view22 = [ViewFactory viewWithName:@"view22"];
    id view23 = [ViewFactory viewWithName:@"view23"];

    [root addSubview:view1];
    [view1 addSubview:view11];
    [view1 addSubview:view12];
    [root addSubview:view2];
    [view2 addSubview:view21];
    [view21 addSubview:view211];
    [view21 addSubview:view212];
    [view21 addSubview:view213];
    [view2 addSubview:view22];
    [view2 addSubview:view23];

    NSArray *matchingViews = [igor findViewsThatMatchQuery:query inTree:root];

    assertThat(matchingViews, containsInAnyOrder(root, view1, view11, view12, view2, view21, view211, view212, view213, view22, view23, nil));
}

- (void)testMemberOfClassPattern {
    NSString *query = @"UIButton";

    id view = [ViewFactory view];
    id button = [ViewFactory button];
    id imageView = [ViewFactory view];
    id root = view;
    [root addSubview:button];
    [button addSubview:imageView];

    NSArray *matchingViews = [igor findViewsThatMatchQuery:query inTree:root];

    assertThat(matchingViews, hasItem(button));
    assertThat(matchingViews, hasCountOf(1));
}

- (void)testKindOfClassPattern {
    NSString *query = @"UIControl*";

    id viewOfBaseClassOfTargetClass = [ViewFactory view];
    id viewOfTargetClass = [ViewFactory control];
    id viewOfClassDerivedFromTargetClass = [ViewFactory button];
    id viewOfUnrelatedClass = [ViewFactory window];

    id root = viewOfBaseClassOfTargetClass;
    [root addSubview:viewOfTargetClass];
    [root addSubview:viewOfClassDerivedFromTargetClass];
    [root addSubview:viewOfUnrelatedClass];

    NSArray *matchingViews = [igor findViewsThatMatchQuery:query inTree:root];

    assertThat(matchingViews, hasItem(viewOfTargetClass));
    assertThat(matchingViews, hasItem(viewOfClassDerivedFromTargetClass));
    assertThat(matchingViews, isNot(hasItem(viewOfBaseClassOfTargetClass)));
    assertThat(matchingViews, isNot(hasItem(viewOfUnrelatedClass)));
}

@end
