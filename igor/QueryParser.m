#import "QueryParser.h"
#import "QueryScanner.h"
#import "BranchMatcher.h"
#import "CombinatorMatcher.h"
#import "ChainParser.h"

@implementation QueryParser {
    id <ChainParser>chainParser;
}

+ (id <PatternParser>)parserWithChainParser:(id <ChainParser>)chainParser {
    return [[self alloc] initWithChainParser:chainParser];
}

- (id <PatternParser>)initWithChainParser:(id <ChainParser>)theChainParser {
    self = [super init];
    if (self) {
        chainParser = theChainParser;
    }
    return self;
}

- (id <Matcher>)parseMatcherFromScanner:(id <QueryScanner>)scanner {
    id <Matcher> matcher = [self parseSubjectFromScanner:scanner];
    if (!chainParser.done) matcher = [self parseBranchMatcherWithSubject:matcher fromScanner:scanner];
    if (!chainParser.done) [scanner failBecause:@"Expected a subject pattern"];
    [scanner failIfNotAtEnd];
    return matcher;
}

- (id <Matcher>)parseSubjectFromScanner:(id <QueryScanner>)scanner {
    id <Matcher> subject = [chainParser parseStepFromScanner:scanner];
    if (chainParser.done) return subject;
    id <ChainMatcher> compoundSubject = [CombinatorMatcher matcherWithSubjectMatcher:subject];
    [chainParser parseSubjectChainFromScanner:scanner intoMatcher:compoundSubject];
    if (chainParser.done) return compoundSubject;
    if (![scanner skipString:@"$"]) [scanner failBecause:@"Expected a subject marker"];
    if (chainParser.started) {
        [self parseStepFromScanner:scanner intoMatcher:compoundSubject];
        return compoundSubject;
    }
    return [chainParser parseStepFromScanner:scanner];
}

- (void)parseStepFromScanner:(id <QueryScanner>)scanner intoMatcher:(id <ChainMatcher>)subject {
    id <Combinator> combinator = chainParser.combinator;
    id <Matcher> matcher = [chainParser parseStepFromScanner:scanner];
    [subject appendCombinator:combinator matcher:matcher];
}

- (id <Matcher>)parseBranchMatcherWithSubject:(id <Matcher>)subject fromScanner:(id <QueryScanner>)scanner {
    id <ChainMatcher> branch = [BranchMatcher matcherWithSubjectMatcher:subject];
    [chainParser parseSubjectChainFromScanner:scanner intoMatcher:branch];
    return branch;
}

@end
