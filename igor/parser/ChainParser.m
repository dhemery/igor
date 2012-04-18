#import "InstanceParser.h"
#import "ChainParser.h"
#import "ChainMatcher.h"
#import "QueryScanner.h"

@implementation ChainParser

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

+ (id <ChainParser>)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParser:(id <CombinatorParser>)combinatorParser {
    return [[self alloc] initWithSubjectParsers:subjectParsers combinatorParser:combinatorParser];
}

+ (id <ChainParser>)parserWithCombinatorParser:(id <CombinatorParser>)combinatorParser {
    return [self parserWithSubjectParsers:[NSArray array] combinatorParser:combinatorParser];
}

- (id <ChainParser>)initWithSubjectParsers:(NSArray *)subjectParsers combinatorParser:(id <CombinatorParser>)combinatorParser {
    self = [super init];
    if (self) {
        _subjectParsers = subjectParsers;
        _combinatorParser = combinatorParser;
        _combinator = nil;
        _matcher = nil;
    }
    return self;
}

- (id <Matcher>)parseStepFromScanner:(id <QueryScanner>)scanner {
    self.combinator = nil;
    self.matcher = [self parseSubjectFromScanner:scanner];
    if (self.matcher) {
        self.combinator = [self parseCombinatorFromScanner:scanner];
    }
    return self.matcher;
}

- (id <Matcher>)parseSubjectFromScanner:(id <QueryScanner>)scanner {
    for (id <PatternParser> parser in self.subjectParsers) {
        id <Matcher> matcher = [parser parseMatcherFromScanner:scanner];
        if (matcher) return matcher;
    }
    return nil;
}

- (id <Combinator>)parseCombinatorFromScanner:(id <QueryScanner>)scanner {
    return [self.combinatorParser parseCombinatorFromScanner:scanner];
}

- (void)parseSubjectChainFromScanner:(id <QueryScanner>)scanner intoMatcher:(id <ChainMatcher>)destination {
    while (self.combinator) {
        id <Combinator> previousCombinator = self.combinator;
        [self parseStepFromScanner:scanner];
        if (self.matcher) [destination appendCombinator:previousCombinator matcher:self.matcher];
    };
}
@end
