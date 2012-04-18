#import "QueryParser.h"
#import "InstanceMatcher.h"
#import "QueryScanner.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"
#import "UniversalMatcher.h"
#import "ChainParser.h"
#import "InstanceParser.h"
#import "PredicateParser.h"
#import "ClassParser.h"
#import "BranchParser.h"

@interface QueryParserTests : SenTestCase
@end

// todo Use mocks to focus the test.
@implementation QueryParserTests {
    id <PatternParser> parser;

}

- (void)setUp {
    id <PatternParser> classParser = [ClassParser new];
    id <PatternParser> predicateParser = [PredicateParser new];
    NSArray *simplePatternParsers = [NSArray arrayWithObjects:classParser, predicateParser, nil];

    id <PatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simplePatternParsers];
    id <ChainParser> chainParser = [ChainParser parserWithCombinatorParsers:nil];
    id <PatternParser> branchParser = [BranchParser parserWithChainParser:chainParser];
    NSArray *subjectPatternParsers = [NSArray arrayWithObjects:instanceParser, branchParser, nil];
    chainParser.subjectParsers = subjectPatternParsers;

    parser = [QueryParser parserWithChainParser:chainParser];
}

- (void)testParsesAsteriskAsUniversalMatcher {
    id <Matcher> matcher = [parser parseMatcherFromScanner:[QueryScanner scannerWithString:@"*"]];

    assertThat(matcher, instanceOf([InstanceMatcher class]));
    InstanceMatcher *instanceMatcher = (InstanceMatcher *)matcher;
    assertThat(instanceMatcher.simpleMatchers, contains(instanceOf([UniversalMatcher class]), nil));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    id <Matcher> matcher = [parser parseMatcherFromScanner:[QueryScanner scannerWithString:@"UIButton"]];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *)matcher;

    assertThat(instanceMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    id <Matcher> matcher = [parser parseMatcherFromScanner:[QueryScanner scannerWithString:@"UILabel*"]];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *) matcher;

    assertThat(instanceMatcher.simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[UILabel class]]));
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
}

@end

