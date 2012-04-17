#import "PatternParser.h"
#import "FakeSimpleParser.h"
#import "InstanceParser.h"
#import "Matcher.h"
#import "InstanceMatcher.h"
#import "UniversalMatcher.h"

@interface InstanceParserTests : SenTestCase
@end

@implementation InstanceParserTests {
    NSMutableArray *simpleParsers;
}

- (void)setUp {
    simpleParsers = [NSMutableArray array];
}

- (void)testYieldsNilIfSimpleParsersYieldNoMatchers {
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsNoSimpleMatchers]];
    id <PatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simpleParsers];

    assertThat([instanceParser parseMatcherFromScanner:nil], nilValue());
}

- (void)testYieldsInstanceMatcherWithSimpleMatcherFromSimpleParser {
    id <Matcher> simpleMatcher = [UniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:simpleMatcher]];
    id <PatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simpleParsers];

    InstanceMatcher *subjectMatcher = (InstanceMatcher *)[instanceParser parseMatcherFromScanner:nil];

    assertThat(subjectMatcher.simpleMatchers, contains(sameInstance(simpleMatcher), nil));
}

- (void)testYieldsInstanceMatcherWithAllSimpleMatchersFromAllSimpleParsers {
    id <Matcher> matcher1 = [UniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:matcher1]];

    id <Matcher> matcher21 = [UniversalMatcher new];
    id <Matcher> matcher22 = [UniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatchers:[NSArray arrayWithObjects:matcher21, matcher22, nil]]];

    id <Matcher> matcher31 = [UniversalMatcher new];
    id <Matcher> matcher32 = [UniversalMatcher new];
    id <Matcher> matcher33 = [UniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatchers:[NSArray arrayWithObjects:matcher31, matcher32, matcher33, nil]]];

    id <PatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simpleParsers];

    InstanceMatcher *subjectMatcher = (InstanceMatcher *)[instanceParser parseMatcherFromScanner:nil];

    assertThat(subjectMatcher.simpleMatchers,
        containsInAnyOrder(
                sameInstance(matcher1),
                sameInstance(matcher21),
                sameInstance(matcher22),
                sameInstance(matcher31),
                sameInstance(matcher32),
                sameInstance(matcher33),
                nil));
}

@end
