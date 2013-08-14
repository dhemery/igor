#import "ViewFactory.h"
#import "MatchesView.h"
#import "DEMatcher.h"
#import "DEIdentifierMatcher.h"
#import "DEPositionMatcher.h"

@interface PositionMatcherTests : SenTestCase

@end

@implementation PositionMatcherTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
    UIView *root = [ViewFactory viewWithName:@"root"];
    UIView *subview1 = [ViewFactory viewWithName:@"subview1"];
    UIView *subview2 = [ViewFactory viewWithName:@"subview2"];
    UIView *subview3 = [ViewFactory viewWithName:@"subview3"];
    UIView *subview31 = [ViewFactory viewWithName:@"subview31"];
    [root addSubview:subview1];
    [root addSubview:subview2];
    [root addSubview:subview3];
    [subview3 addSubview:subview31];

    id <DEMatcher> emptyMatcher = [DEPositionMatcher matcherForPosition:@"empty"];
    assertThat(emptyMatcher, [MatchesView view:subview1]);
    assertThat(emptyMatcher, isNot([MatchesView view:subview3]));

    id <DEMatcher> firstChildMatcher = [DEPositionMatcher matcherForPosition:@"first-child"];
    assertThat(firstChildMatcher, [MatchesView view:subview1]);
    assertThat(firstChildMatcher, isNot([MatchesView view:subview3]));

    id <DEMatcher> lastChildMatcher = [DEPositionMatcher matcherForPosition:@"last-child"];
    assertThat(lastChildMatcher, [MatchesView view:subview3]);
    assertThat(lastChildMatcher, isNot([MatchesView view:subview1]));
    
    id <DEMatcher> onlyChildMatcher = [DEPositionMatcher matcherForPosition:@"only-child"];
    assertThat(onlyChildMatcher, [MatchesView view:subview31]);
    assertThat(onlyChildMatcher, isNot([MatchesView view:subview3]));
}

@end
