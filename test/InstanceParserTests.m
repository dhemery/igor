#import "SimplePatternParser.h"
#import "FakeSimpleParser.h"
#import "InstanceParser.h"
#import "SimpleMatcher.h"
#import "InstanceMatcher.h"
#import "UniversalMatcher.h"

@interface InstanceParserTests : SenTestCase
@end

@implementation InstanceParserTests {
    NSMutableArray *subjectMatchers;
    NSMutableArray *simpleParsers;
}

- (void)setUp {
    subjectMatchers = [NSMutableArray array];
    simpleParsers = [NSMutableArray array];
}

- (void)testDeliversNoInstanceMatcherIfSimpleParsersYieldNoMatchers {
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsNoSimpleMatchers]];

    id <SubjectPatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simpleParsers];

    [instanceParser parseSubjectMatcherIntoArray:subjectMatchers];
    assertThat(subjectMatchers, is(empty()));
}

- (void)testReportsNoMatchersDeliveredIfNoMatchersDelivered {
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsNoSimpleMatchers]];

    id <SubjectPatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simpleParsers];

    assertThatBool([instanceParser parseSubjectMatcherIntoArray:subjectMatchers], equalToBool(NO));
}

- (void)testDeliversInstanceMatcherWithSimpleMatcherFromSimpleParser {
    id <SimpleMatcher> simpleMatcher = [UniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:simpleMatcher]];
    id <SubjectPatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simpleParsers];

    [instanceParser parseSubjectMatcherIntoArray:subjectMatchers];

    InstanceMatcher *subjectMatcher = (InstanceMatcher *)[subjectMatchers lastObject];
    assertThat(subjectMatcher.simpleMatchers, onlyContains(simpleMatcher, nil));
}

- (void)testReportsMatcherDeliveredIfMatcherDelivered {
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:[UniversalMatcher new]]];
    id <SubjectPatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simpleParsers];

    assertThatBool([instanceParser parseSubjectMatcherIntoArray:subjectMatchers], equalToBool(YES));
}

- (void)testDeliversInstanceMatcherWithAllSimpleMatchersFromAllSimpleParsers {
    id <SimpleMatcher> matcher1 = [UniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:matcher1]];

    id <SimpleMatcher> matcher21 = [UniversalMatcher new];
    id <SimpleMatcher> matcher22 = [UniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatchers:[NSArray arrayWithObjects:matcher21, matcher22, nil]]];

    id <SimpleMatcher> matcher31 = [UniversalMatcher new];
    id <SimpleMatcher> matcher32 = [UniversalMatcher new];
    id <SimpleMatcher> matcher33 = [UniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatchers:[NSArray arrayWithObjects:matcher31, matcher32, matcher33, nil]]];

    id <SubjectPatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simpleParsers];

    [instanceParser parseSubjectMatcherIntoArray:subjectMatchers];

    InstanceMatcher *subjectMatcher = (InstanceMatcher *)[subjectMatchers lastObject];
    assertThat(subjectMatcher.simpleMatchers,
        onlyContains(
                matcher1,
                matcher21,
                matcher22,
                matcher31,
                matcher32,
                matcher33,
                nil));
}

- (void)testDeliversOneInstanceMatcherIfSimpleParsersYieldSimpleMatchers {
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:[UniversalMatcher new]]];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:[UniversalMatcher new]]];
    id <SubjectPatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simpleParsers];

    [instanceParser parseSubjectMatcherIntoArray:subjectMatchers];

    assertThat([subjectMatchers objectAtIndex:0], instanceOf([InstanceMatcher class]));
    assertThat(subjectMatchers, hasCountOf(1));
}

@end
