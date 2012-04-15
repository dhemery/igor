#import "InstanceParser.h"
#import "ChainParser.h"
#import "IgorQueryStringScanner.h"
#import "DescendantCombinator.h"
#import "SubjectMatcher.h"
#import "CombinatorMatcher.h"
#import "CombinatorParser.h"

@implementation ChainParser {
    id <IgorQueryScanner> scanner;
    NSArray *combinatorParsers;
}

@synthesize subjectParsers;

- (ChainParser *)initWithSubjectParsers:(NSArray *)theSubjectParsers combinatorParsers:(NSArray *)theCombinatorParsers {
    if (self = [super init]) {
        subjectParsers = theSubjectParsers;
        combinatorParsers = theCombinatorParsers;
    }
    return self;
}

- (id <SubjectMatcher>)parseSubjectMatcher {
    for (id <SubjectPatternParser>parser in subjectParsers) {
        id <SubjectMatcher> matcher = [parser parseSubjectMatcher];
        if (matcher) return matcher;
    }
    return nil;
}

- (id <Combinator>)parseCombinator {
    for (id <CombinatorParser>parser in combinatorParsers) {
        id <Combinator> combinator = [parser parseCombinator];
        if (combinator) return combinator;
    }
    return nil;
}

- (ChainParserState *)parseOne {
    id <SubjectMatcher> matcher = [self parseSubjectMatcher];
    id <Combinator> combinator = nil;
    if (matcher) {
        combinator = [self parseCombinator];
    }
    return [ChainParserState stateWithMatcher:matcher combinator:combinator];
}

- (ChainParserState *)parseChain {
    ChainParserState *collected = [self parseOne];
    ChainParserState *step = [self parseOne];
    while(step.started) {
        id <SubjectMatcher> matcher = [CombinatorMatcher matcherWithSubjectMatcher:step.matcher combinator:collected.combinator relativeMatcher:collected.matcher];
        collected = [ChainParserState stateWithMatcher:matcher combinator:step.combinator];
        if (step.done) return collected;
        step = [self parseOne];
    }
    return collected;
}

+ (ChainParser *)parserWithCombinatorParsers:(NSArray *)combinatorParsers {
    return [self parserWithSubjectParsers:[NSArray array] combinatorParsers:combinatorParsers];
}

+ (ChainParser *)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParsers:(NSArray *)combinatorParsers {
    return [[self alloc] initWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];
}
@end
