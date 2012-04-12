#import "PredicateParser.h"
#import "IgorQueryStringScanner.h"
#import "IsPredicateMatcher.h"

@interface PredicateParserTests : SenTestCase
@end

@implementation PredicateParserTests {
    NSMutableArray *simpleMatchers;
    id<IgorQueryScanner> scanner;
}

- (void)setUp {
    simpleMatchers = [NSMutableArray array];
    scanner = [IgorQueryStringScanner scanner];
}

- (void)testParsesAPredicateBetweenBrackets {
    NSString *expression = @"pearlBailey='opreylady'";
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];
    [scanner setQuery:query];
    [PredicateParser parsePredicateMatcherFromQuery:scanner intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testIgnoresBracketWithinStringsInPredicate {
    NSString *expression = @"myProperty='bracket: ]'";
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];
    [scanner setQuery:query];
    [PredicateParser parsePredicateMatcherFromQuery:scanner intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testIgnoresConsecutiveBracketsWithinStringsInPredicate {
    NSString *expression = @"myProperty='brackets: ]]]]]'";
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];
    [scanner setQuery:query];
    [PredicateParser parsePredicateMatcherFromQuery:scanner intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testDeliversNoMatcherIfNoLeftBracket {
    [scanner setQuery:@"no left bracket"];
    [PredicateParser parsePredicateMatcherFromQuery:scanner intoArray:simpleMatchers];
    assertThat(simpleMatchers, is(empty()));
}

- (void)testThrowsIfNoPredicateBetweenBrackets {
    [scanner setQuery:@"[]"];
    STAssertThrowsSpecificNamed([PredicateParser parsePredicateMatcherFromQuery:scanner intoArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testThrowsIfNoRightBracket {
    [scanner setQuery:@"[royClark='pickin'"];
    STAssertThrowsSpecificNamed([PredicateParser parsePredicateMatcherFromQuery:scanner intoArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
