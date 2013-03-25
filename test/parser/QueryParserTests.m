#import "DEQueryParser.h"
#import "DEInstanceMatcher.h"
#import "DEQueryScanner.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"
#import "DEUniversalMatcher.h"
#import "DEChainParser.h"
#import "DEInstanceParser.h"
#import "DEPredicateParser.h"
#import "DEClassParser.h"
#import "DEBranchParser.h"
#import "ViewFactory.h"

@interface QueryParserTests : SenTestCase
@end

// todo Use mocks to focus the test.
@implementation QueryParserTests {
    id <DEPatternParser> parser;

}

- (void)setUp {
    id <DEPatternParser> classParser = [DEClassParser new];
    id <DEPatternParser> predicateParser = [DEPredicateParser new];
    NSArray *simplePatternParsers = [NSArray arrayWithObject:predicateParser];
    id <DEPatternParser> instanceParser = [DEInstanceParser parserWithClassParser:classParser simpleParsers:simplePatternParsers];
    id <DEChainParser> chainParser = [DEChainParser parserWithCombinatorParser:nil];
    id <DEPatternParser> branchParser = [DEBranchParser parserWithChainParser:chainParser];
    NSArray *subjectPatternParsers = [NSArray arrayWithObjects:instanceParser, branchParser, nil];
    chainParser.subjectParsers = subjectPatternParsers;

    parser = [DEQueryParser parserWithChainParser:chainParser];
}

- (void)testParsesAsteriskAsUniversalMatcher {
    id <DEMatcher> matcher = [parser parseMatcherFromScanner:[DEQueryScanner scannerWithString:@"*"]];

    assertThat(matcher, instanceOf([DEInstanceMatcher class]));
    DEInstanceMatcher *instanceMatcher = (DEInstanceMatcher *)matcher;
    assertThat(instanceMatcher.simpleMatchers, contains(instanceOf([DEUniversalMatcher class]), nil));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    id <DEMatcher> matcher = [parser parseMatcherFromScanner:[DEQueryScanner scannerWithString:@"UIButton"]];
    DEInstanceMatcher *instanceMatcher = (DEInstanceMatcher *)matcher;

    assertThat(instanceMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[ViewFactory classForButton]]));
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    id <DEMatcher> matcher = [parser parseMatcherFromScanner:[DEQueryScanner scannerWithString:@"UILabel*"]];
    DEInstanceMatcher *instanceMatcher = (DEInstanceMatcher *) matcher;

    assertThat(instanceMatcher.simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[ViewFactory classForLabel]]));
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
}

@end

