#import "ScanningPredicateParser.h"
#import "IgorQueryStringScanner.h"
#import "IsPredicateMatcher.h"

@interface PredicateParserTests : SenTestCase
@end

@implementation PredicateParserTests {
    NSMutableArray *simpleMatchers;
    id<IgorQueryScanner> scanner;
    id<PredicateParser> parser;
}

- (void)setUp {
    simpleMatchers = [NSMutableArray array];
    scanner = [IgorQueryStringScanner scanner];
    parser = [ScanningPredicateParser parserWithScanner:scanner];
}

- (void)testParsesAPredicateBetweenBrackets {
    NSString *expression = @"pearlBailey='opreylady'";
    [scanner setQuery:[NSString stringWithFormat:@"[%@]", expression]];

    [parser parsePredicateMatcherIntoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testIgnoresBracketWithinStringsInPredicate {
    NSString *expression = @"myProperty='bracket: ]'";
    [scanner setQuery:[NSString stringWithFormat:@"[%@]", expression]];

    [parser parsePredicateMatcherIntoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testIgnoresConsecutiveBracketsWithinStringsInPredicate {
    NSString *expression = @"myProperty='brackets: ]]]]]'";
    [scanner setQuery:[NSString stringWithFormat:@"[%@]", expression]];

    [parser parsePredicateMatcherIntoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testDeliversNoMatcherIfNoLeftBracket {
    [scanner setQuery:@"no left bracket"];

    [parser parsePredicateMatcherIntoArray:simpleMatchers];

    assertThat(simpleMatchers, is(empty()));
}

- (void)testThrowsIfNoPredicateBetweenBrackets {
    [scanner setQuery:@"[]"];

    STAssertThrowsSpecificNamed([parser parsePredicateMatcherIntoArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testThrowsIfNoRightBracket {
    [scanner setQuery:@"[royClark='pickin'"];

    STAssertThrowsSpecificNamed([parser parsePredicateMatcherIntoArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
