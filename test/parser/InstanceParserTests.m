#import "PatternParser.h"
#import "FakeSimpleParser.h"
#import "InstanceParser.h"
#import "Matcher.h"
#import "InstanceMatcher.h"
#import "UniversalMatcher.h"
#import "KindOfClassMatcher.h"

@interface InstanceParserTests : SenTestCase
@end

@implementation InstanceParserTests {
    id <PatternParser> instanceParser;
    NSMutableArray *simpleParsers;
    id <PatternParser> classParser;
}

- (void)setUp {
    simpleParsers = [NSMutableArray array];
    classParser = [FakeSimpleParser parserThatYieldsNoSimpleMatchers];
}

- (void)testYieldsNilIfSimpleParsersYieldNoMatchers {
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsNoSimpleMatchers]];
    instanceParser = [InstanceParser parserWithClassParser:classParser simpleParsers:simpleParsers];

    assertThat([instanceParser parseMatcherFromScanner:nil], nilValue());
}

- (void)testYieldsInstanceMatcherWithSimpleMatcherFromSimpleParser {
    id <Matcher> simpleMatcher = [UniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:simpleMatcher]];
    instanceParser = [InstanceParser parserWithClassParser:classParser simpleParsers:simpleParsers];

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

    instanceParser = [InstanceParser parserWithClassParser:classParser simpleParsers:simpleParsers];

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

- (void)testRecognizesOnlyOneClassPatternPerInstancePattern {
    id <Matcher> classMatcher1 = [UniversalMatcher new];
    id <Matcher> classMatcher2 = [KindOfClassMatcher matcherForBaseClass:[UIButton class]];
    NSArray *classMatchers = [NSArray arrayWithObjects:classMatcher1, classMatcher2, nil];
    classParser = [FakeSimpleParser parserThatYieldsSimpleMatchers:classMatchers];

    instanceParser = [InstanceParser parserWithClassParser:classParser simpleParsers:[NSArray array]];

    InstanceMatcher *matcher = (InstanceMatcher *)[instanceParser parseMatcherFromScanner:nil];

    assertThat(matcher.simpleMatchers, hasItem(instanceOf([UniversalMatcher class])));
    assertThat(matcher.simpleMatchers, hasCountOf(1));
}

@end
