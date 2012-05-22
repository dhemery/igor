#import "DEQueryParser.h"
#import "DEQueryScanner.h"
#import "DEBranchMatcher.h"
#import "DECombinatorMatcher.h"
#import "DEChainParser.h"

@implementation DEQueryParser

@synthesize chainParser;

+ (id <DEPatternParser>)parserWithChainParser:(id <DEChainParser>)chainParser {
    return [[self alloc] initWithChainParser:chainParser];
}

- (id <DEPatternParser>)initWithChainParser:(id <DEChainParser>)theChainParser {
    self = [super init];
    if (self) {
        chainParser = theChainParser;
    }
    return self;
}

- (id <DEMatcher>)parseMatcherFromScanner:(id <DEQueryScanner>)scanner {
    id <DEMatcher> matcher = [self parseSubjectFromScanner:scanner];
    if (!chainParser.done) matcher = [self parseBranchMatcherWithSubject:matcher fromScanner:scanner];
    if (!chainParser.done) [scanner failBecause:@"Expected a subject pattern"];
    [scanner failIfNotAtEnd];
    return matcher;
}

- (id <DEMatcher>)parseSubjectFromScanner:(id <DEQueryScanner>)scanner {
    id <DEMatcher> subject = [chainParser parseStepFromScanner:scanner];
    if (chainParser.done) return subject;
    id <DEChainMatcher> compoundSubject = [DECombinatorMatcher matcherWithSubjectMatcher:subject];
    [chainParser parseSubjectChainFromScanner:scanner intoMatcher:compoundSubject];
    if (chainParser.done) return compoundSubject;
    if (![scanner skipString:@"$"]) [scanner failBecause:@"Expected a subject marker"];
    if (chainParser.started) {
        [self parseStepFromScanner:scanner intoMatcher:compoundSubject];
        return compoundSubject;
    }
    return [chainParser parseStepFromScanner:scanner];
}

- (void)parseStepFromScanner:(id <DEQueryScanner>)scanner intoMatcher:(id <DEChainMatcher>)subject {
    id <DECombinator> combinator = chainParser.combinator;
    id <DEMatcher> matcher = [chainParser parseStepFromScanner:scanner];
    [subject appendCombinator:combinator matcher:matcher];
}

- (id <DEMatcher>)parseBranchMatcherWithSubject:(id <DEMatcher>)subject fromScanner:(id <DEQueryScanner>)scanner {
    id <DEChainMatcher> branch = [DEBranchMatcher matcherWithSubjectMatcher:subject];
    [chainParser parseSubjectChainFromScanner:scanner intoMatcher:branch];
    return branch;
}

@end
