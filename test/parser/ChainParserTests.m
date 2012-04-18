#import "ChainParser.h"
#import "FakeSubjectParser.h"
#import "UniversalMatcher.h"
#import "FakeCombinatorParser.h"
#import "DescendantCombinator.h"

@interface ChainParserTests : SenTestCase
@end

// TODO Uncomment and fix tests.
@implementation ChainParserTests {
    NSMutableArray *subjectParsers;
    id <ChainParser> parser;
}

- (void)setUp {
    subjectParsers = [NSMutableArray array];
}

- (void)testParseStepYieldsNoMatcherIfParsersYieldNoMatcher {
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsNoSubjectMatchers]];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParser:[CombinatorParser new]];

    id <Matcher> matcher = [parser parseStepFromScanner:nil];

    assertThat(matcher, nilValue());
}

- (void)testParseStepYieldsMatcherIfParsersYieldMatcherButNoCombinator {
    id <Matcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParser:[CombinatorParser new]];

    id <Matcher> matcher =  [parser parseStepFromScanner:nil];

    assertThat(matcher, sameInstance(subjectMatcher));
}

- (void)testParseStepYieldsMatcherAndCombinatorIfParsersYieldMatcherAndCombinator {
    id <Matcher> subjectMatcher = [UniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    id <Combinator> combinator = [DescendantCombinator new];
    id <CombinatorParser> combinatorParser = [FakeCombinatorParser parserThatYieldsCombinator:combinator];
    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParser:combinatorParser];

    id <Matcher> matcher = [parser parseStepFromScanner:nil];

    assertThat(matcher, sameInstance(subjectMatcher));
    assertThat(parser.combinator, sameInstance(combinator));
}

//- (void)testParseChainYieldsMatcherIfParsersYieldMatcherButNoCombinator {
//    id <Matcher> subjectMatcher = [UniversalMatcher new];
//    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
//    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];
//
//    [parser parseSubjectChainFromScanner:nil intoMatcher:nil];
//
//    assert(false);
//}

//- (void)testParseChainYieldsMatcherAndCombinatorIfParsersYieldMatcherAndCombinator {
//    id <Matcher> subjectMatcher = [UniversalMatcher new];
//    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
//    id <Combinator> combinator = [DescendantCombinator new];
//    [combinatorParsers addObject:[FakeCombinatorParser parserThatYieldsCombinator:combinator]];
//    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];
//
//    [parser parseSubjectChainFromScanner:nil intoMatcher:nil];
//
//    assert(false); // What about the matcher?
//    assertThat(parser.combinator, sameInstance(combinator));
//}

//- (void)testParseChainYieldsCompoundMatcherAndNoCombinatorIfMultipleMatcherChainCompletes {
//    UniversalMatcher *matcher1 = [UniversalMatcher new];
//    UniversalMatcher *matcher2 = [UniversalMatcher new];
//    NSArray *subjectMatchers = [NSArray arrayWithObjects:matcher1, matcher2, nil];
//    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatchers:subjectMatchers]];
//    id <Combinator> combinator = [DescendantCombinator new];
//    [combinatorParsers addObject:[FakeCombinatorParser parserThatYieldsCombinator:combinator]];
//    parser = [ChainParser parserWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];
//
//    [parser parseSubjectChainFromScanner:nil intoMatcher:nil];
//
//    assert(false); // What about the matcher?
//    assertThat(parser.combinator, nilValue());
//
//    CombinatorMatcher *matcher = (CombinatorMatcher *) parser.matcher;
//    assertThat(matcher.subjectMatcher, sameInstance(matcher2));
//    assertThat(matcher.combinator, sameInstance(combinator));
//    assertThat(matcher.relativeMatcher, sameInstance(matcher1));
//}

@end
