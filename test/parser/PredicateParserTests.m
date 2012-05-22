#import "DEPredicateParser.h"
#import "DEQueryScanner.h"
#import "IsPredicateMatcher.h"

@interface PredicateParserTests : SenTestCase
@end

@implementation PredicateParserTests {
    id <DEQueryScanner> scanner;
    id <DEPatternParser> parser;
}

- (void)setUp {
    parser = [DEPredicateParser new];
}

- (void)testParsesAPredicateBetweenBrackets {
    NSString *expression = @"pearlBailey='opreylady'";
    scanner = [DEQueryScanner scannerWithString:[NSString stringWithFormat:@"[%@]", expression]];

    assertThat([parser parseMatcherFromScanner:scanner], [IsPredicateMatcher forExpression:expression]);
}

- (void)testIgnoresBracketWithinStringsInPredicate {
    NSString *expression = @"myProperty='bracket: ]'";
    scanner = [DEQueryScanner scannerWithString:[NSString stringWithFormat:@"[%@]", expression]];

    assertThat([parser parseMatcherFromScanner:scanner], [IsPredicateMatcher forExpression:expression]);
}

- (void)testIgnoresConsecutiveBracketsWithinStringsInPredicate {
    NSString *expression = @"myProperty='brackets: ]]]]]'";
    scanner = [DEQueryScanner scannerWithString:[NSString stringWithFormat:@"[%@]", expression]];

    assertThat([parser parseMatcherFromScanner:scanner], [IsPredicateMatcher forExpression:expression]);
}

- (void)testDeliversNoMatcherIfNoLeftBracket {
    scanner = [DEQueryScanner scannerWithString:@"no left bracket"];

    assertThat([parser parseMatcherFromScanner:scanner], is(nilValue()));
}

- (void)testThrowsIfNoPredicateBetweenBrackets {
    scanner = [DEQueryScanner scannerWithString:@"[]"];

    STAssertThrowsSpecificNamed([parser parseMatcherFromScanner:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testThrowsIfNoRightBracket {
    scanner = [DEQueryScanner scannerWithString:@"[royClark='pickin'"];

    STAssertThrowsSpecificNamed([parser parseMatcherFromScanner:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
