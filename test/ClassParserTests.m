#import "IgorQueryStringScanner.h"
#import "ClassParser.h"
#import "UniversalMatcher.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"

@interface ClassParserTests : SenTestCase
@end

@implementation ClassParserTests {
    id <IgorQueryScanner> scanner;
    id <SimplePatternParser> parser;
}

- (void)setUp {
    scanner = [IgorQueryStringScanner scanner];
    parser = [ClassParser parserWithScanner:scanner];
}

- (void)testParsesAsteriskAsUniversalMatcher {
    [scanner setQuery:@"*"];

    assertThat([parser parseMatcher], instanceOf([UniversalMatcher class]));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    [scanner setQuery:@"UIButton"];

    assertThat([parser parseMatcher], [IsMemberOfClassMatcher forExactClass:[UIButton class]]);
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    [scanner setQuery:@"UILabel*"];

    assertThat([parser parseMatcher], [IsKindOfClassMatcher forClass:[UILabel class]]);
}

- (void)testDeliversNoMatcherIfQueryDoesNotStartWithAClassPattern {
    [scanner setQuery:@"[property='value']"];

    assertThat([parser parseMatcher], is(nilValue()));
}
@end
