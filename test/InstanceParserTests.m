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
    id <SimpleMatcher> aMatcher = [UniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:aMatcher]];
    id <SubjectPatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simpleParsers];

    [instanceParser parseSubjectMatcherIntoArray:subjectMatchers];

    InstanceMatcher *subjectMatcher = (InstanceMatcher *)[subjectMatchers lastObject];
    assertThat(subjectMatcher.simpleMatchers, hasItem(sameInstance(aMatcher)));
    assertThat(subjectMatcher.simpleMatchers, hasCountOf(1));
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
    assertThat(subjectMatcher.simpleMatchers, hasItem(sameInstance(matcher1)));
    assertThat(subjectMatcher.simpleMatchers, hasItem(sameInstance(matcher21)));
    assertThat(subjectMatcher.simpleMatchers, hasItem(sameInstance(matcher22)));
    assertThat(subjectMatcher.simpleMatchers, hasItem(sameInstance(matcher31)));
    assertThat(subjectMatcher.simpleMatchers, hasItem(sameInstance(matcher32)));
    assertThat(subjectMatcher.simpleMatchers, hasItem(sameInstance(matcher33)));
    assertThat(subjectMatcher.simpleMatchers, hasCountOf(6));
}

- (void)testDeliversOneInstanceMatcherIfSimpleParsersYieldSimpleMatchers {
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:[UniversalMatcher new]]];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:[UniversalMatcher new]]];
    id <SubjectPatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simpleParsers];

    [instanceParser parseSubjectMatcherIntoArray:subjectMatchers];

    assertThat(subjectMatchers, hasCountOf(1));
    id <SubjectMatcher> subjectMatcher = (InstanceMatcher *)[subjectMatchers lastObject];
    assertThat(subjectMatcher, instanceOf([InstanceMatcher class]));
}

@end
