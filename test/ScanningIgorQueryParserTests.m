#import "ScanningIgorQueryParser.h"
#import "InstanceMatcher.h"
#import "IgorQueryStringScanner.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"
#import "UniversalMatcher.h"
#import "RelationshipParser.h"
#import "InstanceParser.h"
#import "PredicateParser.h"
#import "ClassParser.h"
#import "BranchParser.h"

@interface ScanningIgorQueryParserTests : SenTestCase
@end

@implementation ScanningIgorQueryParserTests {
    id <IgorQueryParser> parser;
}

- (void)setUp {
    id <IgorQueryScanner> scanner = [IgorQueryStringScanner new];
    id <SimplePatternParser> classParser = [ClassParser parserWithScanner:scanner];
    id <SimplePatternParser> predicateParser = [PredicateParser parserWithScanner:scanner];
    NSArray *simplePatternParsers = [NSArray arrayWithObjects:classParser, predicateParser, nil];

    id <SubjectPatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simplePatternParsers];
    RelationshipParser *relationshipParser = [RelationshipParser parserWithCombinatorParsers:nil];
    id <SubjectPatternParser> branchParser = [BranchParser parserWithScanner:scanner relationshipParser:relationshipParser];
    NSArray *subjectPatternParsers = [NSArray arrayWithObjects:instanceParser, branchParser, nil];

    [relationshipParser setSubjectPatternParsers:subjectPatternParsers];

    parser = [ScanningIgorQueryParser parserWithScanner:scanner relationshipParser:relationshipParser];
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

