#import "DEPatternParser.h"
#import "FakeSimpleParser.h"
#import "DEInstanceParser.h"
#import "DEMatcher.h"
#import "DEInstanceMatcher.h"
#import "DEUniversalMatcher.h"
#import "DEKindOfClassMatcher.h"

@interface InstanceParserTests : SenTestCase
@end

@implementation InstanceParserTests {
    id <DEPatternParser> instanceParser;
    NSMutableArray *simpleParsers;
    id <DEPatternParser> classParser;
}

- (void)setUp {
    simpleParsers = [NSMutableArray array];
    classParser = [FakeSimpleParser parserThatYieldsNoSimpleMatchers];
}

- (void)testYieldsNilIfSimpleParsersYieldNoMatchers {
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsNoSimpleMatchers]];
    instanceParser = [DEInstanceParser parserWithClassParser:classParser simpleParsers:simpleParsers];

    assertThat([instanceParser parseMatcherFromScanner:nil], nilValue());
}

- (void)testYieldsInstanceMatcherWithSimpleMatcherFromSimpleParser {
    id <DEMatcher> simpleMatcher = [DEUniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:simpleMatcher]];
    instanceParser = [DEInstanceParser parserWithClassParser:classParser simpleParsers:simpleParsers];

    DEInstanceMatcher *subjectMatcher = (DEInstanceMatcher *)[instanceParser parseMatcherFromScanner:nil];

    assertThat(subjectMatcher.simpleMatchers, contains(sameInstance(simpleMatcher), nil));
}

- (void)testYieldsInstanceMatcherWithAllSimpleMatchersFromAllSimpleParsers {
    id <DEMatcher> matcher1 = [DEUniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatcher:matcher1]];

    id <DEMatcher> matcher21 = [DEUniversalMatcher new];
    id <DEMatcher> matcher22 = [DEUniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatchers:[NSArray arrayWithObjects:matcher21, matcher22, nil]]];

    id <DEMatcher> matcher31 = [DEUniversalMatcher new];
    id <DEMatcher> matcher32 = [DEUniversalMatcher new];
    id <DEMatcher> matcher33 = [DEUniversalMatcher new];
    [simpleParsers addObject:[FakeSimpleParser parserThatYieldsSimpleMatchers:[NSArray arrayWithObjects:matcher31, matcher32, matcher33, nil]]];

    instanceParser = [DEInstanceParser parserWithClassParser:classParser simpleParsers:simpleParsers];

    DEInstanceMatcher *subjectMatcher = (DEInstanceMatcher *)[instanceParser parseMatcherFromScanner:nil];

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
    id <DEMatcher> classMatcher1 = [DEUniversalMatcher new];
    id <DEMatcher> classMatcher2 = [DEKindOfClassMatcher matcherForBaseClass:[UIButton class]];
    NSArray *classMatchers = [NSArray arrayWithObjects:classMatcher1, classMatcher2, nil];
    classParser = [FakeSimpleParser parserThatYieldsSimpleMatchers:classMatchers];

    instanceParser = [DEInstanceParser parserWithClassParser:classParser simpleParsers:[NSArray array]];

    DEInstanceMatcher *matcher = (DEInstanceMatcher *)[instanceParser parseMatcherFromScanner:nil];

    assertThat(matcher.simpleMatchers, hasItem(instanceOf([DEUniversalMatcher class])));
    assertThat(matcher.simpleMatchers, hasCountOf(1));
}

@end
