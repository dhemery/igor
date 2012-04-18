#import "PredicateParser.h"
#import "QueryScanner.h"
#import "IsPredicateMatcher.h"

@interface PredicateParserTests : SenTestCase
@end

@implementation PredicateParserTests {
    id <QueryScanner> scanner;
    id <PatternParser> parser;
}

- (void)setUp {
    parser = [PredicateParser new];
}

- (void)testParsesAPredicateBetweenBrackets {
    NSString *expression = @"pearlBailey='opreylady'";
    scanner = [QueryScanner scannerWithString:[NSString stringWithFormat:@"[%@]", expression]];

    assertThat([parser parseMatcherFromScanner:scanner], [IsPredicateMatcher forExpression:expression]);
}

- (void)testIgnoresBracketWithinStringsInPredicate {
    NSString *expression = @"myProperty='bracket: ]'";
    scanner = [QueryScanner scannerWithString:[NSString stringWithFormat:@"[%@]", expression]];

    assertThat([parser parseMatcherFromScanner:scanner], [IsPredicateMatcher forExpression:expression]);
}

- (void)testIgnoresConsecutiveBracketsWithinStringsInPredicate {
    NSString *expression = @"myProperty='brackets: ]]]]]'";
    scanner = [QueryScanner scannerWithString:[NSString stringWithFormat:@"[%@]", expression]];

    assertThat([parser parseMatcherFromScanner:scanner], [IsPredicateMatcher forExpression:expression]);
}

- (void)testDeliversNoMatcherIfNoLeftBracket {
    scanner = [QueryScanner scannerWithString:@"no left bracket"];

    assertThat([parser parseMatcherFromScanner:scanner], is(nilValue()));
}

- (void)testThrowsIfNoPredicateBetweenBrackets {
    scanner = [QueryScanner scannerWithString:@"[]"];

    STAssertThrowsSpecificNamed([parser parseMatcherFromScanner:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testThrowsIfNoRightBracket {
    scanner = [QueryScanner scannerWithString:@"[royClark='pickin'"];

    STAssertThrowsSpecificNamed([parser parseMatcherFromScanner:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
