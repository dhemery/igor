#import "PredicateParser.h"
#import "IgorQueryStringScanner.h"
#import "IsPredicateMatcher.h"

@interface PredicateParserTests : SenTestCase
@end

@implementation PredicateParserTests {
    NSMutableArray *simpleMatchers;
    id<IgorQueryScanner> scanner;
    id<SimplePatternParser> parser;
}

- (void)setUp {
    simpleMatchers = [NSMutableArray array];
    scanner = [IgorQueryStringScanner scanner];
    parser = [PredicateParser parserWithScanner:scanner];
}

- (void)testParsesAPredicateBetweenBrackets {
    NSString *expression = @"pearlBailey='opreylady'";
    [scanner setQuery:[NSString stringWithFormat:@"[%@]", expression]];

    [parser parseSimpleMatcherIntoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testIgnoresBracketWithinStringsInPredicate {
    NSString *expression = @"myProperty='bracket: ]'";
    [scanner setQuery:[NSString stringWithFormat:@"[%@]", expression]];

    [parser parseSimpleMatcherIntoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testIgnoresConsecutiveBracketsWithinStringsInPredicate {
    NSString *expression = @"myProperty='brackets: ]]]]]'";
    [scanner setQuery:[NSString stringWithFormat:@"[%@]", expression]];

    [parser parseSimpleMatcherIntoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testDeliversNoMatcherIfNoLeftBracket {
    [scanner setQuery:@"no left bracket"];

    [parser parseSimpleMatcherIntoArray:simpleMatchers];

    assertThat(simpleMatchers, is(empty()));
}

- (void)testThrowsIfNoPredicateBetweenBrackets {
    [scanner setQuery:@"[]"];

    STAssertThrowsSpecificNamed([parser parseSimpleMatcherIntoArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testThrowsIfNoRightBracket {
    [scanner setQuery:@"[royClark='pickin'"];

    STAssertThrowsSpecificNamed([parser parseSimpleMatcherIntoArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
