#import "StringQueryScanner.h"
#import "ClassParser.h"
#import "UniversalMatcher.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"

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
    scanner = [StringQueryScanner scannerWithString:@"*"];

    assertThat([parser parseMatcherFromScanner:scanner], instanceOf([UniversalMatcher class]));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    scanner = [StringQueryScanner scannerWithString:@"UIButton"];

    assertThat([parser parseMatcherFromScanner:scanner], [IsMemberOfClassMatcher forExactClass:[UIButton class]]);
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    scanner = [StringQueryScanner scannerWithString:@"UILabel*"];

    assertThat([parser parseMatcherFromScanner:scanner], [IsKindOfClassMatcher forClass:[UILabel class]]);
}

- (void)testDeliversNoMatcherIfQueryDoesNotStartWithAClassPattern {
    scanner = [StringQueryScanner scannerWithString:@"[property='value']"];

    assertThat([parser parseMatcherFromScanner:scanner], is(nilValue()));
}
@end
