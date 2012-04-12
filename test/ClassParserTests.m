#import "IgorQueryStringScanner.h"
#import "ClassParser.h"
#import "UniversalMatcher.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"

@interface ClassParserTests : SenTestCase
@end

@implementation ClassParserTests {
    NSMutableArray *simpleMatchers;
    id<IgorQueryScanner> scanner;
    ClassParser *parser;
}

- (void)setUp {
    simpleMatchers = [NSMutableArray array];
    scanner = [IgorQueryStringScanner scanner];
    parser = [ClassParser parser];
}

- (void)testParsesAsteriskAsUniversalMatcher {
    [scanner setQuery:@"*"];
    [parser parseClassMatcherFromQuery:scanner intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem(instanceOf([UniversalMatcher class])));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    [scanner setQuery:@"UIButton"];
    [parser parseClassMatcherFromQuery:scanner intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    [scanner setQuery:@"UILabel*"];
    [parser parseClassMatcherFromQuery:scanner intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[UILabel class]]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testDeliversNoMatcherIfQueryDoesNotStartWithAClassPattern {
    [scanner setQuery:@"[property='value']"];
    [parser parseClassMatcherFromQuery:scanner intoArray:simpleMatchers];

    assertThat(simpleMatchers, is(empty()));
}
@end
