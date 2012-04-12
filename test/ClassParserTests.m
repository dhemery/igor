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
}

- (void)setUp {
    simpleMatchers = [NSMutableArray array];
    scanner = [IgorQueryStringScanner scanner];
}

- (void)testParsesAsteriskAsUniversalMatcher {
    [scanner setQuery:@"*"];
    [ClassParser addClassMatcherFromQuery:scanner toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem(instanceOf([UniversalMatcher class])));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    [scanner setQuery:@"UIButton"];
    [ClassParser addClassMatcherFromQuery:scanner toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    [scanner setQuery:@"UILabel*"];
    [ClassParser addClassMatcherFromQuery:scanner toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[UILabel class]]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testDeliversNoMatcherIfQueryDoesNotStartWithAClassPattern {
    [scanner setQuery:@"[property='value']"];
    [ClassParser addClassMatcherFromQuery:scanner toArray:simpleMatchers];

    assertThat(simpleMatchers, is(empty()));
}
@end
