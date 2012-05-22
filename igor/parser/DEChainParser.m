#import "DEInstanceParser.h"
#import "DEChainParser.h"
#import "DEChainMatcher.h"
#import "DEQueryScanner.h"

@implementation DEChainParser

@synthesize subjectParsers = _subjectParsers;
@synthesize combinatorParser = _combinatorParser;
@synthesize combinator = _combinator;
@synthesize matcher = _matcher;

- (BOOL)started {
    return self.matcher != nil;
}

- (BOOL) done {
    return self.started && (self.combinator == nil);
}

+ (id <DEChainParser>)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParser:(id <DECombinatorParser>)combinatorParser {
    return [[self alloc] initWithSubjectParsers:subjectParsers combinatorParser:combinatorParser];
}

+ (id <DEChainParser>)parserWithCombinatorParser:(id <DECombinatorParser>)combinatorParser {
    return [self parserWithSubjectParsers:[NSArray array] combinatorParser:combinatorParser];
}

- (id <DEChainParser>)initWithSubjectParsers:(NSArray *)subjectParsers combinatorParser:(id <DECombinatorParser>)combinatorParser {
    self = [super init];
    if (self) {
        _subjectParsers = subjectParsers;
        _combinatorParser = combinatorParser;
        _combinator = nil;
        _matcher = nil;
    }
    return self;
}

- (id <DEMatcher>)parseStepFromScanner:(id <DEQueryScanner>)scanner {
    self.combinator = nil;
    self.matcher = [self parseSubjectFromScanner:scanner];
    if (self.matcher) {
        self.combinator = [self parseCombinatorFromScanner:scanner];
    }
    return self.matcher;
}

- (id <DEMatcher>)parseSubjectFromScanner:(id <DEQueryScanner>)scanner {
    for (id <DEPatternParser> parser in self.subjectParsers) {
        id <DEMatcher> matcher = [parser parseMatcherFromScanner:scanner];
        if (matcher) return matcher;
    }
    return nil;
}

- (id <DECombinator>)parseCombinatorFromScanner:(id <DEQueryScanner>)scanner {
    return [self.combinatorParser parseCombinatorFromScanner:scanner];
}

- (void)parseSubjectChainFromScanner:(id <DEQueryScanner>)scanner intoMatcher:(id <DEChainMatcher>)destination {
    while (self.combinator) {
        id <DECombinator> previousCombinator = self.combinator;
        [self parseStepFromScanner:scanner];
        if (self.matcher) [destination appendCombinator:previousCombinator matcher:self.matcher];
    };
}
@end
