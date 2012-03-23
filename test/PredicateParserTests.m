
#import "PredicateMatcher.h"
#import "PredicatePattern.h"

@interface PredicateParserTests : SenTestCase
@end

@implementation PredicateParserTests {
    PredicatePattern* parser;
}

-(void)setUp {
    parser = [PredicatePattern new];
}    

-(void) testReturnsTruePredicateIfNoLeftBracket {
    NSString* noLeadingLeftBracket = @"+notAPropertySelector+";
    NSScanner* scanner = [NSScanner scannerWithString:noLeadingLeftBracket];
    PredicateMatcher* matcher = [parser parse:scanner];
    expect([matcher matchExpression]).toEqual(@"TRUEPREDICATE");
}

-(void) testThrowsIfNoPredicate {
    NSString* noPropertyName = @"[]";
    NSScanner* scanner = [NSScanner scannerWithString:noPropertyName];
    STAssertThrowsSpecificNamed([parser parse:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

-(void) testParsesAPredicate {
    NSString* propertyEqualsPattern = @"[pearlBailey='opreylady']";
    NSScanner* scanner = [NSScanner scannerWithString:propertyEqualsPattern];
    PredicateMatcher* matcher = (id)[parser parse:scanner];
    expect(matcher).toBeInstanceOf([PredicateMatcher class]);
    expect(matcher.matchExpression).toEqual(@"pearlBailey == \"opreylady\"");
}

-(void) testThrowsIfNoRightBracket {
    NSString* noTrailingRightBracket = @"[royClark='pickin'";
    NSScanner* scanner = [NSScanner scannerWithString:noTrailingRightBracket];
    STAssertThrowsSpecificNamed([parser parse:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
