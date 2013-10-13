#import "DEQueryScanner.h"
#import "DEClassParser.h"
#import "DEUniversalMatcher.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"
#import "_My_ClassName__WithUnder_Scores.h"
#import "My1ClassName2With3Digits.h"

@interface ClassParserTests : XCTestCase
@end

@implementation ClassParserTests {
    id <DEQueryScanner> scanner;
    id <DEPatternParser> parser;
}

- (void)setUp {
    parser = [DEClassParser new];
}

- (void)testParsesAsteriskAsUniversalMatcher {
    scanner = [DEQueryScanner scannerWithString:@"*"];

    assertThat([parser parseMatcherFromScanner:scanner], instanceOf([DEUniversalMatcher class]));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    scanner = [DEQueryScanner scannerWithString:@"UIButton"];

    assertThat([parser parseMatcherFromScanner:scanner], [IsMemberOfClassMatcher forExactClass:[UIButton class]]);
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    scanner = [DEQueryScanner scannerWithString:@"UILabel*"];

    assertThat([parser parseMatcherFromScanner:scanner], [IsKindOfClassMatcher forClass:[UILabel class]]);
}

- (void)testDeliversNoMatcherIfQueryDoesNotStartWithAClassPattern {
    scanner = [DEQueryScanner scannerWithString:@"[property='value']"];

    assertThat([parser parseMatcherFromScanner:scanner], is(nilValue()));
}

- (void)testClassNamesMayIncludeUnderscores {
    scanner = [DEQueryScanner scannerWithString:@"_My_ClassName__WithUnder_Scores"];

    assertThat([parser parseMatcherFromScanner:scanner], [IsMemberOfClassMatcher forExactClass:[_My_ClassName__WithUnder_Scores class]]);
}

- (void)testClassNamesMayIncludeDigits {
    scanner = [DEQueryScanner scannerWithString:@"My1ClassName2With3Digits"];

    assertThat([parser parseMatcherFromScanner:scanner], [IsMemberOfClassMatcher forExactClass:[My1ClassName2With3Digits class]]);
}

@end
