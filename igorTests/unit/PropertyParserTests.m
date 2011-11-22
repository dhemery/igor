#import "PropertyPattern.h"
#import "PropertyExistsMatcher.h"
#import "PropertyValueEqualsMatcher.h"

@interface PropertyParserTests : SenTestCase
@end

@implementation PropertyParserTests {
    PropertyPattern* parser;
}

-(void)setUp {
    parser = [PropertyPattern new];
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
    id<Matcher> result = [parser parse:scanner];
    assertThat(result, instanceOf([PropertyExistsMatcher class]));
    PropertyExistsMatcher* matcher = (PropertyExistsMatcher*)result;
    assertThat([matcher propertyName], equalTo(@"freddieFender"));
}

-(void) testParsesAPropertyValueEqualsSelector {
    NSString* propertyEqualsSelectorString = @"[pearlBailey='opreylady']";
    NSScanner* scanner = [NSScanner scannerWithString:propertyEqualsSelectorString];
    id<Matcher> result = [parser parse:scanner];
    assertThat(result, instanceOf([PropertyValueEqualsMatcher class]));
    PropertyValueEqualsMatcher* matcher = (PropertyValueEqualsMatcher*)result;
    assertThat([matcher propertyName], equalTo(@"pearlBailey"));
    assertThat([matcher desiredValue], equalTo(@"opreylady"));
}

-(void) testThrowsIfNoRightBracket {
    NSString* noTrailingRightBracket = @"[propertyName)";
    NSScanner* scanner = [NSScanner scannerWithString:noTrailingRightBracket];
    STAssertThrowsSpecificNamed([parser parse:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
