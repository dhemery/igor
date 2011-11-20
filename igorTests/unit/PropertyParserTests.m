#import "PropertyParser.h"
#import "PropertyExistsSelector.h"
#import "PropertyValueEqualsSelector.h"

@interface PropertyParserTests : SenTestCase
@end

@implementation PropertyParserTests {
    PropertyParser* parser;
}

-(void)setUp {
    parser = [PropertyParser new];
}    

-(void) testReturnsNilIfNoLeftBracket {
    NSString* noLeadingLeftBracket = @"+notAPropertySelector+";
    NSScanner* scanner = [NSScanner scannerWithString:noLeadingLeftBracket];
    assertThat([parser parse:scanner], nilValue());
}

-(void) testThrowsIfNoPropertyName {
    NSString* noPropertyName = @"[]";
    NSScanner* scanner = [NSScanner scannerWithString:noPropertyName];
    STAssertThrowsSpecificNamed([parser parse:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

-(void) testParsesAPropertyExistsSelector {
    NSString* propertyExistsSelectorString = @"[freddieFender]";
    NSScanner* scanner = [NSScanner scannerWithString:propertyExistsSelectorString];
    id<Selector> result = [parser parse:scanner];
    assertThat(result, instanceOf([PropertyExistsSelector class]));
    PropertyExistsSelector* selector = (PropertyExistsSelector*)result;
    assertThat([selector propertyName], equalTo(@"freddieFender"));
}

-(void) testParsesAPropertyValueEqualsSelector {
    NSString* propertyEqualsSelectorString = @"[pearlBailey='opreylady']";
    NSScanner* scanner = [NSScanner scannerWithString:propertyEqualsSelectorString];
    id<Selector> result = [parser parse:scanner];
    assertThat(result, instanceOf([PropertyValueEqualsSelector class]));
    PropertyValueEqualsSelector* selector = (PropertyValueEqualsSelector*)result;
    assertThat([selector propertyName], equalTo(@"pearlBailey"));
    assertThat([selector desiredValue], equalTo(@"opreylady"));
}

-(void) testThrowsIfNoRightBracket {
    NSString* noTrailingRightBracket = @"[propertyName)";
    NSScanner* scanner = [NSScanner scannerWithString:noTrailingRightBracket];
    STAssertThrowsSpecificNamed([parser parse:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
