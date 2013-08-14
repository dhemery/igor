#import "DEIgor.h"
#import "ViewFactory.h"

@interface PositionPatternTests : SenTestCase

@end

@implementation PositionPatternTests {
    DEIgor *igor;
    UIView *view;
    UIView* header;
    UIView* footer;
    UIView* form;
    UIButton* button;
}

- (void)setUp
{
    [super setUp];

    igor = [DEIgor igor];
    view = [ViewFactory viewWithName:@"root"];

    header = [ViewFactory viewWithName:@"header"];
    [header addSubview:[ViewFactory viewWithName:@"subview11"]];
    [header addSubview:[ViewFactory viewWithName:@"subview12"]];
    [header addSubview:[ViewFactory viewWithName:@"subview13"]];
    [view addSubview:header];
    
    form = [ViewFactory viewWithName:@"form"];
    [form addSubview:[ViewFactory viewWithName:@"subview21"]];
    [form addSubview:[ViewFactory viewWithName:@"subview22"]];
    [form addSubview:[ViewFactory viewWithName:@"subview23"]];
    [view addSubview:form];

    footer = [ViewFactory viewWithName:@"footer"];
    [footer addSubview:[ViewFactory viewWithName:@"subview31"]];
    [view addSubview:footer];

    button = [ViewFactory button];
    [view addSubview:button];
    
}

- (void)testFirstChild
{
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#header :first-child" inTree:view];
    assertThat(matchingViews, equalTo(@[header.subviews[0]]));
    
    matchingViews = [igor findViewsThatMatchQuery:@"#root > :first-child" inTree:view];
    assertThat(matchingViews, equalTo(@[header]));
    
    matchingViews = [igor findViewsThatMatchQuery:@"#root > UIView > :first-child" inTree:view];
    assertThat(matchingViews, equalTo(@[header.subviews[0], form.subviews[0], footer.subviews[0]]));
}

- (void)testLastChild
{
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#header :last-child" inTree:view];
    assertThat(matchingViews, equalTo(@[header.subviews[2]]));
    
    matchingViews = [igor findViewsThatMatchQuery:@"#root > :last-child" inTree:view];
    assertThat(matchingViews, equalTo(@[button]));
    
    matchingViews = [igor findViewsThatMatchQuery:@"#root > UIView > :last-child" inTree:view];
    assertThat(matchingViews, equalTo(@[header.subviews[2], form.subviews[2], footer.subviews[0]]));
}

- (void)testEmpty
{
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root > :empty" inTree:view];
    assertThat(matchingViews, equalTo(@[button]));
    
    matchingViews = [igor findViewsThatMatchQuery:@"*:empty" inTree:view];
    assertThat(matchingViews, containsInAnyOrder(header.subviews[0], header.subviews[1], header.subviews[2],
                                                 form.subviews[0], form.subviews[1], form.subviews[2],
                                                 footer.subviews[0], button, nil));

    matchingViews = [igor findViewsThatMatchQuery:@"UIView > :first-child > UIView:empty" inTree:view];
    assertThat(matchingViews, containsInAnyOrder(header.subviews[0], header.subviews[1], header.subviews[2], nil));
}

- (void)testOnlyChild
{
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#header > :only-child" inTree:view];
    assertThat(matchingViews, empty());
    
    matchingViews = [igor findViewsThatMatchQuery:@"#form > :only-child" inTree:view];
    assertThat(matchingViews, empty());
    
    matchingViews = [igor findViewsThatMatchQuery:@"#footer > :only-child" inTree:view];
    assertThat(matchingViews, equalTo(@[footer.subviews[0]]));
}

@end
