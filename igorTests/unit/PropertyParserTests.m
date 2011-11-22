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
    NSString* propertyExistsPattern = @"[freddieFender]";
    NSScanner* scanner = [NSScanner scannerWithString:propertyExistsPattern];
    id<PropertyMatcher> matcher = [parser parse:scanner];
    assertThat(matcher, instanceOf([PropertyExistsMatcher class]));
    assertThat(matcher.matchProperty, equalTo(@"freddieFender"));
}

-(void) testParsesAPropertyValueEqualsSelector {
    NSString* propertyEqualsPattern = @"[pearlBailey='opreylady']";
    NSScanner* scanner = [NSScanner scannerWithString:propertyEqualsPattern];
    id<PropertyValueMatcher> matcher = [parser parse:scanner];
    assertThat(matcher, instanceOf([PropertyValueEqualsMatcher class]));
    assertThat(matcher.matchProperty, equalTo(@"pearlBailey"));
    assertThat(matcher.matchValue, equalTo(@"opreylady"));
}

-(void) testThrowsIfNoRightBracket {
    NSString* noTrailingRightBracket = @"[propertyName)";
    NSScanner* scanner = [NSScanner scannerWithString:noTrailingRightBracket];
    STAssertThrowsSpecificNamed([parser parse:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
