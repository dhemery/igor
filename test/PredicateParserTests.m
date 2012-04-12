#import "PredicateParser.h"
#import "IgorQueryStringScanner.h"
#import "IsPredicateMatcher.h"

@interface PredicateParserTests : SenTestCase
@end

@implementation PredicateParserTests {
    NSMutableArray *simpleMatchers;
}

- (void)setUp {
    simpleMatchers = [NSMutableArray array];
}

- (void)testParsesAPredicateBetweenBrackets {
    NSString *expression = @"pearlBailey='opreylady'";
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];

    [PredicateParser addPredicateMatcherFromQuery:[IgorQueryStringScanner withQueryString:query] toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testIgnoresBracketWithinStringsInPredicate {
    NSString *expression = @"myProperty='bracket: ]'";
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];

    [PredicateParser addPredicateMatcherFromQuery:[IgorQueryStringScanner withQueryString:query] toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testIgnoresConsecutiveBracketsWithinStringsInPredicate {
    NSString *expression = @"myProperty='brackets: ]]]]]'";
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];

    [PredicateParser addPredicateMatcherFromQuery:[IgorQueryStringScanner withQueryString:query] toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testDeliversNoMatcherIfNoLeftBracket {
    id<IgorQueryScanner>  query = [IgorQueryStringScanner withQueryString:@"no left bracket"];
    [PredicateParser addPredicateMatcherFromQuery:query toArray:simpleMatchers];
    assertThat(simpleMatchers, is(empty()));
}

- (void)testThrowsIfNoPredicateBetweenBrackets {
    id<IgorQueryScanner> query = [IgorQueryStringScanner withQueryString:@"[]"];
    STAssertThrowsSpecificNamed([PredicateParser addPredicateMatcherFromQuery:query toArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testThrowsIfNoRightBracket {
    id<IgorQueryScanner> query = [IgorQueryStringScanner withQueryString:@"[royClark='pickin'"];
    STAssertThrowsSpecificNamed([PredicateParser addPredicateMatcherFromQuery:query toArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
