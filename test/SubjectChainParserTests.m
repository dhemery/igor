#import "SubjectChainParser.h"
#import "FakeSubjectParser.h"
#import "UniversalMatcher.h"
#import "FakeCombinatorParser.h"
#import "DescendantCombinator.h"
#import "CombinatorMatcher.h"

@interface SubjectChainParserTests : SenTestCase
@end

@implementation SubjectChainParserTests {
    NSMutableArray *combinatorParsers;
    NSMutableArray *subjectParsers;
    SubjectChainParser *parser;
}

- (void)setUp {
    combinatorParsers = [NSMutableArray array];
    subjectParsers = [NSMutableArray array];
}

- (void)testParseOneYieldsNoMatcherIfParsersYieldNoMatcher {
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsNoSubjectMatchers]];
    parser = [SubjectChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    SubjectChain *chain = [parser parseOneSubject];

    assertThat(chain.matcher, nilValue());
}

- (void)testParseOneYieldsMatcherIfParsersYieldMatcherButNoCombinator {
    id <SubjectMatcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    parser = [SubjectChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    SubjectChain *chain = [parser parseOneSubject];

    assertThat(chain.matcher, sameInstance(subjectMatcher));
}

- (void)testParseOneYieldsMatcherAndCombinatorIfParsersYieldMatcherAndCombinator {
    id <SubjectMatcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    id <Combinator> combinator = [DescendantCombinator new];
    [combinatorParsers addObject:[FakeCombinatorParser parserThatYieldsCombinator:combinator]];
    parser = [SubjectChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    SubjectChain *chain = [parser parseOneSubject];

    assertThat(chain.matcher, sameInstance(subjectMatcher));
    assertThat(chain.combinator, sameInstance(combinator));
}

- (void)testParseChainYieldsNoMatcherIfParsersYieldNoMatcher {
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsNoSubjectMatchers]];
    parser = [SubjectChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    SubjectChain *chain = [parser parseSubjectChain];

    assertThat(chain.matcher, nilValue());
}

- (void)testParseChainYieldsMatcherIfParsersYieldMatcherButNoCombinator {
    id <SubjectMatcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    parser = [SubjectChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    SubjectChain *chain = [parser parseSubjectChain];

    assertThat(chain.matcher, sameInstance(subjectMatcher));
}

- (void)testParseChainYieldsMatcherAndCombinatorIfParsersYieldMatcherAndCombinator {
    id <SubjectMatcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    id <Combinator> combinator = [DescendantCombinator new];
    [combinatorParsers addObject:[FakeCombinatorParser parserThatYieldsCombinator:combinator]];
    parser = [SubjectChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    SubjectChain *parsed = [parser parseSubjectChain];

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
    parser = [SubjectChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];

    SubjectChain *chain = [parser parseSubjectChain];

    assertThat(chain.matcher, instanceOf([CombinatorMatcher class]));
    assertThat(chain.combinator, nilValue());

    CombinatorMatcher *matcher = (CombinatorMatcher *) chain.matcher;
    assertThat(matcher.subjectMatcher, sameInstance(matcher2));
    assertThat(matcher.combinator, sameInstance(combinator));
    assertThat(matcher.relativeMatcher, sameInstance(matcher1));
}

@end
