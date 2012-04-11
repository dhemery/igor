#import "PredicateParser.h"
#import "IgorQueryScanner.h"
#import "IsPredicateMatcher.h"

@interface PredicatePatternParserTests : SenTestCase
@end

@implementation PredicatePatternParserTests {
    NSMutableArray *simpleMatchers;
}

- (void)setUp {
    simpleMatchers = [NSMutableArray array];
}

- (void)testParsesAPredicateBetweenBrackets {
    NSString *expression = @"pearlBailey='opreylady'";
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];

    [PredicateParser parse:[IgorQueryScanner withQuery:query] intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasCountOf(1));
    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
}

- (void)testIgnoresBracketWithinStringsInPredicate {
    NSString *expression = @"myProperty='bracket: ]'";
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];

    [PredicateParser parse:[IgorQueryScanner withQuery:query] intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasCountOf(1));
    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
}

- (void)testIgnoresConsecutiveBracketsWithinStringsInPredicate {
    NSString *expression = @"myProperty='brackets: ]]]]]'";
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];

    [PredicateParser parse:[IgorQueryScanner withQuery:query] intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasCountOf(1));
    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
}

- (void)testDeliversNoMatcherIfNoLeftBracket {
    IgorQueryScanner* query = [IgorQueryScanner withQuery:@"no left bracket"];
    [PredicateParser parse:query intoArray:simpleMatchers];
    assertThat(simpleMatchers, is(empty()));
}

- (void)testThrowsIfNoPredicateBetweenBrackets {
    IgorQueryScanner* query = [IgorQueryScanner withQuery:@"[]"];
    STAssertThrowsSpecificNamed([PredicateParser parse:query intoArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testThrowsIfNoRightBracket {
    IgorQueryScanner* query = [IgorQueryScanner withQuery:@"[royClark='pickin'"];
    STAssertThrowsSpecificNamed([PredicateParser parse:query intoArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
