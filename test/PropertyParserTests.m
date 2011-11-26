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
    expect([parser parse:scanner]).toBeNil();
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
    expect(matcher).toBeInstanceOf([PropertyExistsMatcher class]);
    expect(matcher.matchProperty).toEqual(@"freddieFender");
}

-(void) testParsesAPropertyValueEqualsSelector {
    NSString* propertyEqualsPattern = @"[pearlBailey='opreylady']";
    NSScanner* scanner = [NSScanner scannerWithString:propertyEqualsPattern];
    id<PropertyValueMatcher> matcher = [parser parse:scanner];
    expect(matcher).toBeInstanceOf([PropertyValueEqualsMatcher class]);
    expect(matcher.matchProperty).toEqual(@"pearlBailey");
    expect(matcher.matchValue).toEqual(@"opreylady");
}

-(void) testThrowsIfNoRightBracket {
    NSString* noTrailingRightBracket = @"[propertyName)";
    NSScanner* scanner = [NSScanner scannerWithString:noTrailingRightBracket];
    STAssertThrowsSpecificNamed([parser parse:scanner], NSException, @"IgorParserException", @"Expected IgorParserException");
}

@end
