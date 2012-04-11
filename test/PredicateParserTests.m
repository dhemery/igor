#import "PredicateParser.h"
#import "IgorQueryScanner.h"
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

    [PredicateParser addPredicateMatcherFromQuery:[IgorQueryScanner withQuery:query] toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testIgnoresBracketWithinStringsInPredicate {
    NSString *expression = @"myProperty='bracket: ]'";
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];

    [PredicateParser addPredicateMatcherFromQuery:[IgorQueryScanner withQuery:query] toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testIgnoresConsecutiveBracketsWithinStringsInPredicate {
    NSString *expression = @"myProperty='brackets: ]]]]]'";
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];

    [PredicateParser addPredicateMatcherFromQuery:[IgorQueryScanner withQuery:query] toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsPredicateMatcher forExpression:expression]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testDeliversNoMatcherIfNoLeftBracket {
    IgorQueryScanner* query = [IgorQueryScanner withQuery:@"no left bracket"];
    [PredicateParser addPredicateMatcherFromQuery:query toArray:simpleMatchers];
    assertThat(simpleMatchers, is(empty()));
}

- (void)testThrowsIfNoPredicateBetweenBrackets {
    IgorQueryScanner* query = [IgorQueryScanner withQuery:@"[]"];
    STAssertThrowsSpecificNamed([PredicateParser addPredicateMatcherFromQuery:query toArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testThrowsIfNoRightBracket {
    IgorQueryScanner* query = [IgorQueryScanner withQuery:@"[royClark='pickin'"];
    STAssertThrowsSpecificNamed([PredicateParser addPredicateMatcherFromQuery:query toArray:simpleMatchers], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
