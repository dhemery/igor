#import "QueryScanner.h"
#import "ClassParser.h"
#import "UniversalMatcher.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"
#import "_My_ClassName__WithUnder_Scores.h"
#import "My1ClassName2With3Digits.h"

@interface ClassParserTests : SenTestCase
@end

@implementation ClassParserTests {
    id <QueryScanner> scanner;
    id <PatternParser> parser;
}

- (void)setUp {
    parser = [ClassParser new];
}

- (void)testParsesAsteriskAsUniversalMatcher {
    scanner = [QueryScanner scannerWithString:@"*"];

    assertThat([parser parseMatcherFromScanner:scanner], instanceOf([UniversalMatcher class]));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    scanner = [QueryScanner scannerWithString:@"UIButton"];

    assertThat([parser parseMatcherFromScanner:scanner], [IsMemberOfClassMatcher forExactClass:[UIButton class]]);
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    scanner = [QueryScanner scannerWithString:@"UILabel*"];

    assertThat([parser parseMatcherFromScanner:scanner], [IsKindOfClassMatcher forClass:[UILabel class]]);
}

- (void)testDeliversNoMatcherIfQueryDoesNotStartWithAClassPattern {
    scanner = [QueryScanner scannerWithString:@"[property='value']"];

    assertThat([parser parseMatcherFromScanner:scanner], is(nilValue()));
}

- (void)testClassNamesMayIncludeUnderscores {
    scanner = [QueryScanner scannerWithString:@"_My_ClassName__WithUnder_Scores"];

    assertThat([parser parseMatcherFromScanner:scanner], [IsMemberOfClassMatcher forExactClass:[_My_ClassName__WithUnder_Scores class]]);
}

- (void)testClassNamesMayIncludeDigits {
    scanner = [QueryScanner scannerWithString:@"My1ClassName2With3Digits"];

    assertThat([parser parseMatcherFromScanner:scanner], [IsMemberOfClassMatcher forExactClass:[My1ClassName2With3Digits class]]);
}

@end
