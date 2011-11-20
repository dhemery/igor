#import "PropertyParser.h"
#import "PropertyExistsSelector.h"

@interface PropertyParserTests : SenTestCase
@end

@implementation PropertyParserTests {
    PropertyParser* parser;
}

-(void)setUp {
    parser = [PropertyParser new];
}    

-(void) testParsesAPropertyExistsSelector {
    NSString* validPropertySelector = @"[attributeName]";
    NSScanner* scanner = [NSScanner scannerWithString:validPropertySelector];
    id<Selector> result = [parser parse:scanner];
    assertThat(result, instanceOf([PropertyExistsSelector class]));
}

-(void) testReturnsNilIfNoLeftBracket {
    NSString* noLeadingLeftBracket = @"+notAnAttributeSelector+";
    NSScanner* scanner = [NSScanner scannerWithString:noLeadingLeftBracket];
    assertThat([parser parse:scanner], nilValue());
}

-(void) testThrowsIfNoPropertyName {
    NSString* noPropertyName = @"[]";
    NSScanner* scanner = [NSScanner scannerWithString:noPropertyName];
    STAssertThrowsSpecificNamed([parser parse:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

-(void) testThrowsIfNoRightBracket {
    NSString* noTrailingRightBracket = @"[attributeName)";
    NSScanner* scanner = [NSScanner scannerWithString:noTrailingRightBracket];
    STAssertThrowsSpecificNamed([parser parse:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}
@end
