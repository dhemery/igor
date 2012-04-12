#import "IgorQueryStringScanner.h"
#import "ClassParser.h"
#import "UniversalMatcher.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"

@interface ClassParserTests : SenTestCase
@end

@implementation ClassParserTests {
    NSMutableArray *simpleMatchers;
}

- (void)setUp {
    simpleMatchers = [NSMutableArray array];
}

- (void)testParsesAsteriskAsUniversalMatcher {
    [ClassParser addClassMatcherFromQuery:[IgorQueryStringScanner withQuery:@"*"] toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem(instanceOf([UniversalMatcher class])));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    [ClassParser addClassMatcherFromQuery:[IgorQueryStringScanner withQuery:@"UIButton"] toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    [ClassParser addClassMatcherFromQuery:[IgorQueryStringScanner withQuery:@"UILabel*"] toArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[UILabel class]]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testDeliversNoMatcherIfQueryDoesNotStartWithAClassPattern {
    [ClassParser addClassMatcherFromQuery:[IgorQueryStringScanner withQuery:@"[property='value']"] toArray:simpleMatchers];

    assertThat(simpleMatchers, is(empty()));
}
@end
