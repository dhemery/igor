#import "PredicateMatcher.h"
#import "PredicatePattern.h"
#import "PatternScanner.h"

@interface PredicatePatternParserTests : SenTestCase
@end

@implementation PredicatePatternParserTests

- (void)testParsesAPredicateBetweenBrackets {
    NSString *expression = @"pearlBailey='opreylady'";
    NSString *expectedExpression = [[NSPredicate predicateWithFormat:expression] predicateFormat];
    NSString *pattern = [NSString stringWithFormat:@"[%@]", expression];
    PredicatePattern *parser = [self parserForPattern:pattern];
    PredicateMatcher *matcher = [parser parse];
    assertThat(matcher, instanceOf([PredicateMatcher class]));
    assertThat(matcher.matchExpression, equalTo(expectedExpression));
}

- (void)testIgnoresBracketWithinStringsInPredicate {
    NSString *expression = @"myProperty='bracket: ]'";
    NSString *expectedExpression = [[NSPredicate predicateWithFormat:expression] predicateFormat];
    NSString *pattern = [NSString stringWithFormat:@"[%@]", expression];
    PredicatePattern *parser = [self parserForPattern:pattern];
    PredicateMatcher *matcher = [parser parse];
    assertThat(matcher, instanceOf([PredicateMatcher class]));
    assertThat([matcher matchExpression], equalTo(expectedExpression));
}

- (void)testIgnoresConsecutiveBracketsWithinStringsInPredicate {
    NSString *expression = @"myProperty='brackets: ]]]]]'";
    NSString *expectedExpression = [[NSPredicate predicateWithFormat:expression] predicateFormat];
    NSString *pattern = [NSString stringWithFormat:@"[%@]", expression];
    PredicatePattern *parser = [self parserForPattern:pattern];
    PredicateMatcher *matcher = [parser parse];
    assertThat(matcher, instanceOf([PredicateMatcher class]));
    assertThat([matcher matchExpression], equalTo(expectedExpression));
}

- (void)testReturnsTruePredicateIfNoLeftBracket {
    PredicatePattern *parser = [self parserForPattern:@""];
    PredicateMatcher *matcher = [parser parse];
    assertThat(matcher, instanceOf([PredicateMatcher class]));
    assertThat([matcher matchExpression], equalTo(@"TRUEPREDICATE"));
}

- (void)testThrowsIfNoPredicateBetweenBrackets {
    PredicatePattern *parser = [self parserForPattern:@"[]"];
    STAssertThrowsSpecificNamed([parser parse], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testThrowsIfNoRightBracket {
    PredicatePattern *parser = [self parserForPattern:@"[royClark='pickin'"];
    STAssertThrowsSpecificNamed([parser parse], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (PredicatePattern *)parserForPattern:(NSString *)pattern {
    return [PredicatePattern forScanner:[PatternScanner withPattern:pattern]];
}

@end
