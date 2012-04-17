#import "QueryParser.h"
#import "InstanceMatcher.h"
#import "StringQueryScanner.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"
#import "UniversalMatcher.h"
#import "ChainParser.h"
#import "InstanceParser.h"
#import "PredicateParser.h"
#import "ClassParser.h"
#import "BranchParser.h"

@interface ScanningIgorQueryParserTests : SenTestCase
@end

// todo Use mocks to focus the test.
@implementation ScanningIgorQueryParserTests {
    id <IgorQueryParser> parser;

}

- (void)setUp {
    id <QueryScanner> scanner = [StringQueryScanner new];
    id <PatternParser> classParser = [ClassParser parserWithScanner:scanner];
    id <PatternParser> predicateParser = [PredicateParser parserWithScanner:scanner];
    NSArray *simplePatternParsers = [NSArray arrayWithObjects:classParser, predicateParser, nil];

    id <PatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simplePatternParsers];
    ChainParser *subjectChainParser = [ChainParser parserWithCombinatorParsers:nil];
    id <PatternParser> branchParser = [BranchParser parserWithScanner:scanner subjectChainParser:subjectChainParser];
    NSArray *subjectPatternParsers = [NSArray arrayWithObjects:instanceParser, branchParser, nil];
    subjectChainParser.subjectParsers = subjectPatternParsers;

    parser = [QueryParser parserWithScanner:scanner subjectChainParser:subjectChainParser];
}

- (void)testParsesAsteriskAsUniversalMatcher {
    id <Matcher> matcher = [parser parseMatcherFromQuery:@"*"];

    assertThat(matcher, instanceOf([InstanceMatcher class]));
    InstanceMatcher *instanceMatcher = (InstanceMatcher *)matcher;
    assertThat(instanceMatcher.simpleMatchers, contains(instanceOf([UniversalMatcher class]), nil));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    id <Matcher> matcher = [parser parseMatcherFromQuery:@"UIButton"];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *)matcher;

    assertThat(instanceMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    id <Matcher> matcher = [parser parseMatcherFromQuery:@"UILabel*"];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *) matcher;

    assertThat(instanceMatcher.simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[UILabel class]]));
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
}

@end

