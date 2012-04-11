#import "IgorQueryScanner.h"
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
    [ClassParser parse:[IgorQueryScanner withQuery:@"*"] intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem(instanceOf([UniversalMatcher class])));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    [ClassParser parse:[IgorQueryScanner withQuery:@"UIButton"] intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIButton class]]));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    [ClassParser parse:[IgorQueryScanner withQuery:@"UILabel*"] intoArray:simpleMatchers];

    assertThat(simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[UILabel class]]));
    assertThat(simpleMatchers, hasCountOf(1));
}

- (void)testDeliversNoMatcherIfQueryDoesNotStartWithAClassPattern {
    [ClassParser parse:[IgorQueryScanner withQuery:@"[property='value']"] intoArray:simpleMatchers];

    assertThat(simpleMatchers, is(empty()));
}
@end
