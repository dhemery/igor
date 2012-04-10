#import "PredicateMatcher.h"
#import "PredicateParser.h"
#import "IgorQueryScanner.h"

@interface PredicatePatternParserTests : SenTestCase
@end

@implementation PredicatePatternParserTests

- (void)testParsesAPredicateBetweenBrackets {
    NSString *expression = @"pearlBailey='opreylady'";
    NSString *expectedExpression = [[NSPredicate predicateWithFormat:expression] predicateFormat];
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];
    PredicateMatcher *matcher = [PredicateParser parse:[IgorQueryScanner withQuery:query]];
    assertThat(matcher, instanceOf([PredicateMatcher class]));
    assertThat(matcher.matchExpression, equalTo(expectedExpression));
}

- (void)testIgnoresBracketWithinStringsInPredicate {
    NSString *expression = @"myProperty='bracket: ]'";
    NSString *expectedExpression = [[NSPredicate predicateWithFormat:expression] predicateFormat];
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];
    PredicateMatcher *matcher = [PredicateParser parse:[IgorQueryScanner withQuery:query]];
    assertThat(matcher, instanceOf([PredicateMatcher class]));
    assertThat([matcher matchExpression], equalTo(expectedExpression));
}

- (void)testIgnoresConsecutiveBracketsWithinStringsInPredicate {
    NSString *expression = @"myProperty='brackets: ]]]]]'";
    NSString *expectedExpression = [[NSPredicate predicateWithFormat:expression] predicateFormat];
    NSString *query = [NSString stringWithFormat:@"[%@]", expression];
    PredicateMatcher *matcher = [PredicateParser parse:[IgorQueryScanner withQuery:query]];
    assertThat(matcher, instanceOf([PredicateMatcher class]));
    assertThat([matcher matchExpression], equalTo(expectedExpression));
}

- (void)testReturnsTruePredicateIfNoLeftBracket {
    PredicateMatcher *matcher = [PredicateParser parse:[IgorQueryScanner withQuery:@""]];
    assertThat(matcher, instanceOf([PredicateMatcher class]));
    assertThat([matcher matchExpression], equalTo(@"TRUEPREDICATE"));
}

- (void)testThrowsIfNoPredicateBetweenBrackets {
    STAssertThrowsSpecificNamed([PredicateParser parse:[IgorQueryScanner withQuery:@"[]"]], NSException, @"IgorParserException", @"Expected IgorParserException");
}

- (void)testThrowsIfNoRightBracket {
    STAssertThrowsSpecificNamed([PredicateParser parse:[IgorQueryScanner withQuery:@"[royClark='pickin'"]], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
