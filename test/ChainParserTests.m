#import "ChainParser.h"
#import "FakeSubjectParser.h"
#import "UniversalMatcher.h"
#import "FakeCombinatorParser.h"
#import "DescendantCombinator.h"
#import "CombinatorMatcher.h"

@interface ChainParserTests : SenTestCase
@end

@implementation ChainParserTests {
    NSMutableArray *combinatorParsers;
    NSMutableArray *subjectParsers;
    ChainParser *parser;
}

- (void)setUp {
    combinatorParsers = [NSMutableArray array];
    subjectParsers = [NSMutableArray array];
}

- (void)testParseOneYieldsNoMatcherIfParsersYieldNoMatcher {
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsNoSubjectMatchers]];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    ChainParserState *parsed = [parser parseOne];

    assertThat(parsed.matcher, nilValue());
}

- (void)testParseOneYieldsMatcherIfParsersYieldMatcherButNoCombinator {
    id <SubjectMatcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    ChainParserState *parsed = [parser parseOne];

    assertThat(parsed.matcher, sameInstance(subjectMatcher));
}

- (void)testParseOneYieldsMatcherAndCombinatorIfParsersYieldMatcherAndCombinator {
    id <SubjectMatcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    id <Combinator> combinator = [DescendantCombinator new];
    [combinatorParsers addObject:[FakeCombinatorParser parserThatYieldsCombinator:combinator]];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    ChainParserState *parsed = [parser parseOne];

    assertThat(parsed.matcher, sameInstance(subjectMatcher));
    assertThat(parsed.combinator, sameInstance(combinator));
}

- (void)testParseChainYieldsNoMatcherIfParsersYieldNoMatcher {
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsNoSubjectMatchers]];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    ChainParserState *parsed = [parser parseChain];

    assertThat(parsed.matcher, nilValue());
}

- (void)testParseChainYieldsMatcherIfParsersYieldMatcherButNoCombinator {
    id <SubjectMatcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    ChainParserState *parsed = [parser parseChain];

    assertThat(parsed.matcher, sameInstance(subjectMatcher));
}

- (void)testParseChainYieldsMatcherAndCombinatorIfParsersYieldMatcherAndCombinator {
    id <SubjectMatcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    id <Combinator> combinator = [DescendantCombinator new];
    [combinatorParsers addObject:[FakeCombinatorParser parserThatYieldsCombinator:combinator]];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    ChainParserState *parsed = [parser parseChain];

    assertThat(parsed.matcher, sameInstance(subjectMatcher));
    assertThat(parsed.combinator, sameInstance(combinator));
}

- (void)testParseChainYieldsCompoundMatcherAndNoCombinatorIfMultipleMatcherChainCompletes {
    UniversalMatcher *matcher1 = [UniversalMatcher new];
    UniversalMatcher *matcher2 = [UniversalMatcher new];
    NSArray *subjectMatchers = [NSArray arrayWithObjects:matcher1, matcher2, nil];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatchers:subjectMatchers]];
    id <Combinator> combinator = [DescendantCombinator new];
    [combinatorParsers addObject:[FakeCombinatorParser parserThatYieldsCombinator:combinator]];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    ChainParserState *parsed = [parser parseChain];

    assertThat(parsed.matcher, instanceOf([CombinatorMatcher class]));
    assertThat(parsed.combinator, nilValue());

    CombinatorMatcher *matcher = (CombinatorMatcher *)parsed.matcher;
    assertThat(matcher.subjectMatcher, sameInstance(matcher2));
    assertThat(matcher.combinator, sameInstance(combinator));
    assertThat(matcher.relativeMatcher, sameInstance(matcher1));
}









- (void)testYieldsNilIfSubjectParsersYieldNoMatchers {
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsNoSubjectMatchers]];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    assertThat([parser parseSubjectMatcher], nilValue());
}

- (void)testYieldsSubjectMatcherFromSubjectParser {
    id <SubjectMatcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    assertThat([parser parseSubjectMatcher], sameInstance(subjectMatcher));
}

- (void)testYieldsNilIfCombinatorParsersYieldNoCombinators {
    [combinatorParsers addObject:[FakeCombinatorParser parserThatYieldsNoCombinators]];
    parser = [ChainParser parserWithCombinatorParsers:combinatorParsers];

    assertThat([parser parseCombinator], nilValue());
}
@end
