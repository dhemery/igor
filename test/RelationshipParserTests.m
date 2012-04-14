#import "RelationshipParser.h"
#import "FakeSubjectParser.h"
#import "UniversalMatcher.h"
#import "FakeCombinatorParser.h"

@interface RelationshipParserTests : SenTestCase
@end

@implementation RelationshipParserTests {
    NSMutableArray *combinatorParsers;
    NSMutableArray *subjectParsers;
    RelationshipParser *parser;
}

- (void)setUp {
    combinatorParsers = [NSMutableArray array];
    subjectParsers = [NSMutableArray array];
}

- (void)testYieldsNilIfSubjectParsersYieldNoMatchers {
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsNoSubjectMatchers]];
    parser = [RelationshipParser parserWithCombinatorParsers:combinatorParsers];
    [parser setSubjectPatternParsers:subjectParsers];

    assertThat([parser parseSubjectMatcher], nilValue());
}

- (void)testYieldsSubjectMatcherFromSubjectParser {
    id <SubjectMatcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    parser = [RelationshipParser parserWithCombinatorParsers:combinatorParsers];
    [parser setSubjectPatternParsers:subjectParsers];

    assertThat([parser parseSubjectMatcher], sameInstance(subjectMatcher));
}

- (void)testYieldsNilIfCombinatorParsersYieldNoCombinators {
    [combinatorParsers addObject:[FakeCombinatorParser parserThatYieldsNoCombinators]];
    parser = [RelationshipParser parserWithCombinatorParsers:combinatorParsers];

    assertThat([parser parseCombinator], nilValue());
}
@end
