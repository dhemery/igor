#import "DEChainParser.h"
#import "FakeSubjectParser.h"
#import "DEUniversalMatcher.h"
#import "FakeCombinatorParser.h"
#import "DEDescendantCombinator.h"

@interface ChainParserTests : SenTestCase
@end

// TODO Uncomment and fix tests.
@implementation ChainParserTests {
    NSMutableArray *subjectParsers;
    id <DEChainParser> parser;
}

- (void)setUp {
    subjectParsers = [NSMutableArray array];
}

- (void)testParseStepYieldsNoMatcherIfParsersYieldNoMatcher {
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsNoSubjectMatchers]];
    parser = [DEChainParser parserWithSubjectParsers:subjectParsers combinatorParser:[DECombinatorParser new]];

    id <DEMatcher> matcher = [parser parseStepFromScanner:nil];

    assertThat(matcher, nilValue());
}

- (void)testParseStepYieldsMatcherIfParsersYieldMatcherButNoCombinator {
    id <DEMatcher> subjectMatcher = [DEUniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    parser = [DEChainParser parserWithSubjectParsers:subjectParsers combinatorParser:[DECombinatorParser new]];

    id <DEMatcher> matcher =  [parser parseStepFromScanner:nil];

    assertThat(matcher, sameInstance(subjectMatcher));
}

- (void)testParseStepYieldsMatcherAndCombinatorIfParsersYieldMatcherAndCombinator {
    id <DEMatcher> subjectMatcher = [DEUniversalMatcher new];
    [subjectParsers addObject:[FakeSubjectParser parserThatYieldsSubjectMatcher:subjectMatcher]];
    id <DECombinator> combinator = [DEDescendantCombinator new];
    id <DECombinatorParser> combinatorParser = [FakeCombinatorParser parserThatYieldsCombinator:combinator];
    parser = [DEChainParser parserWithSubjectParsers:subjectParsers combinatorParser:combinatorParser];

    id <DEMatcher> matcher = [parser parseStepFromScanner:nil];

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
