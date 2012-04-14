#import "ScanningIgorQueryParser.h"
#import "InstanceMatcher.h"
#import "IgorQueryStringScanner.h"
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
    id <IgorQueryScanner> scanner = [IgorQueryStringScanner new];
    id <SimplePatternParser> classParser = [ClassParser parserWithScanner:scanner];
    id <SimplePatternParser> predicateParser = [PredicateParser parserWithScanner:scanner];
    NSArray *simplePatternParsers = [NSArray arrayWithObjects:classParser, predicateParser, nil];

    id <SubjectPatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simplePatternParsers];
    ChainParser *chainParser = [ChainParser parserWithCombinatorParsers:nil];
    id <SubjectPatternParser> branchParser = [BranchParser parserWithScanner:scanner chainParser:chainParser];
    NSArray *subjectPatternParsers = [NSArray arrayWithObjects:instanceParser, branchParser, nil];
    chainParser.subjectParsers = subjectPatternParsers;

    parser = [ScanningIgorQueryParser parserWithScanner:scanner relationshipParser:chainParser];
}

- (void)testParsesAsteriskAsUniversalMatcher {
    id <SubjectMatcher> matcher = [parser parseMatcherFromQuery:@"*"];

    assertThat(matcher, instanceOf([InstanceMatcher class]));
    InstanceMatcher *instanceMatcher = (InstanceMatcher *)matcher;
    assertThat(instanceMatcher.simpleMatchers, contains(instanceOf([UniversalMatcher class]), nil));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    id <SubjectMatcher> matcher = [parser parseMatcherFromQuery:@"UIButton"];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *)matcher;

    assertThat(instanceMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    id <SubjectMatcher> matcher = [parser parseMatcherFromQuery:@"UILabel*"];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *) matcher;

    assertThat(instanceMatcher.simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[UILabel class]]));
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
}

@end

