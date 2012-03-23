#import "PredicateMatcher.h"
#import "PredicatePattern.h"

@interface PredicateParserTests : SenTestCase
@end

@implementation PredicateParserTests

- (void)testReturnsTruePredicateIfNoLeftBracket {
    NSString *noLeadingLeftBracket = @"+notAPropertySelector+";
    NSScanner *scanner = [NSScanner scannerWithString:noLeadingLeftBracket];
    PredicatePattern *parser = [PredicatePattern forScanner:scanner];
    PredicateMatcher *matcher = [parser parse];
    expect([matcher matchExpression]).toEqual(@"TRUEPREDICATE");
}

- (void)testThrowsIfNoPredicate {
    NSString *noPropertyName = @"[]";
    NSScanner *scanner = [NSScanner scannerWithString:noPropertyName];
    PredicatePattern *parser = [PredicatePattern forScanner:scanner];
    STAssertThrowsSpecificNamed([parser parse], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testParsesAPredicate {
    NSString *propertyEqualsPattern = @"[pearlBailey='opreylady']";
    NSScanner *scanner = [NSScanner scannerWithString:propertyEqualsPattern];
    PredicatePattern *parser = [PredicatePattern forScanner:scanner];
    PredicateMatcher *matcher = [parser parse];
    expect(matcher).toBeInstanceOf([PredicateMatcher class]);
    expect(matcher.matchExpression).toEqual(@"pearlBailey == \"opreylady\"");
}

- (void)testThrowsIfNoRightBracket {
    NSString *noTrailingRightBracket = @"[royClark='pickin'";
    NSScanner *scanner = [NSScanner scannerWithString:noTrailingRightBracket];
    PredicatePattern *parser = [PredicatePattern forScanner:scanner];
    STAssertThrowsSpecificNamed([parser parse], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
