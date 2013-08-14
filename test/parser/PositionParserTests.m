#import <SenTestingKit/SenTestingKit.h>
#import "DEChainParser.h"
#import "DEUniversalMatcher.h"
#import "DEPositionParser.h"
#import "DEMatcher.h"
#import "DEPositionMatcher.h"
#import "DEQueryScanner.h"

@interface PositionParserTests : SenTestCase
@end

@implementation PositionParserTests {
    DEQueryScanner* scanner;
    DEPositionParser* parser;
}

- (void)setUp {
    parser = [DEPositionParser new];
}

- (void)testParsesPositionPatterns {
    NSArray* patterns = @[@":empty", @":first-child", @":last-child", @":only-child"];
    NSArray* position = @[@"empty", @"first-child", @"last-child", @"only-child"];
    [patterns enumerateObjectsUsingBlock:^(NSString *expression, NSUInteger idx, BOOL *stop) {
        scanner = [DEQueryScanner scannerWithString:expression];
        DEPositionMatcher* matcher = (DEPositionMatcher*) [parser parseMatcherFromScanner:scanner];
        assertThat(matcher, instanceOf([DEPositionMatcher class]));
        assertThat(matcher.position, equalTo(position[idx]));
    }];

    scanner = [DEQueryScanner scannerWithString:@":invalid"];
    STAssertThrows([parser parseMatcherFromScanner:scanner], @"should failed with invalid pattern");
}

@end
