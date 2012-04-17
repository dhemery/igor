#import "PredicateParser.h"
#import "StringQueryScanner.h"
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
    scanner = [StringQueryScanner scannerWithString:[NSString stringWithFormat:@"[%@]", expression]];

    assertThat([parser parseMatcherFromScanner:scanner], [IsPredicateMatcher forExpression:expression]);
}

- (void)testIgnoresBracketWithinStringsInPredicate {
    NSString *expression = @"myProperty='bracket: ]'";
    scanner = [StringQueryScanner scannerWithString:[NSString stringWithFormat:@"[%@]", expression]];

    assertThat([parser parseMatcherFromScanner:scanner], [IsPredicateMatcher forExpression:expression]);
}

- (void)testIgnoresConsecutiveBracketsWithinStringsInPredicate {
    NSString *expression = @"myProperty='brackets: ]]]]]'";
    scanner = [StringQueryScanner scannerWithString:[NSString stringWithFormat:@"[%@]", expression]];

    assertThat([parser parseMatcherFromScanner:scanner], [IsPredicateMatcher forExpression:expression]);
}

- (void)testDeliversNoMatcherIfNoLeftBracket {
    scanner = [StringQueryScanner scannerWithString:@"no left bracket"];

    assertThat([parser parseMatcherFromScanner:scanner], is(nilValue()));
}

- (void)testThrowsIfNoPredicateBetweenBrackets {
    scanner = [StringQueryScanner scannerWithString:@"[]"];

    STAssertThrowsSpecificNamed([parser parseMatcherFromScanner:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testThrowsIfNoRightBracket {
    scanner = [StringQueryScanner scannerWithString:@"[royClark='pickin'"];

    STAssertThrowsSpecificNamed([parser parseMatcherFromScanner:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
