#import "InstanceParser.h"
#import "ChainParser.h"
#import "DescendantCombinator.h"
#import "ChainMatcher.h"
#import "CombinatorParser.h"
#import "QueryScanner.h"

@implementation ChainParser

@synthesize subjectParsers = _subjectParsers;
@synthesize combinatorParsers = _combinatorParsers;
@synthesize combinator = _combinator;
@synthesize matcher = _matcher;

- (BOOL)started {
    return self.matcher != nil;
}

- (BOOL) done {
    return self.started && (self.combinator == nil);
}

+ (ChainParser *)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParsers:(NSArray *)combinatorParsers {
    return [[self alloc] initWithSubjectParsers:subjectParsers combinatorParsers:combinatorParsers];
}

+ (ChainParser *)parserWithCombinatorParsers:(NSArray *)combinatorParsers {
    return [self parserWithSubjectParsers:[NSArray array] combinatorParsers:combinatorParsers];
}

- (ChainParser *)initWithSubjectParsers:(NSArray *)subjectParsers combinatorParsers:(NSArray *)combinatorParsers {
    self = [super init];
    if (self) {
        _subjectParsers = subjectParsers;
        _combinatorParsers = combinatorParsers;
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
    for (id <CombinatorParser>parser in self.combinatorParsers) {
        id <Combinator> combinator = [parser parseCombinatorFromScanner:scanner];
        if (combinator) return combinator;
    }
    return nil;
}

- (void)parseSubjectChainFromScanner:(id <QueryScanner>)scanner intoMatcher:(id <ChainMatcher>)destination {
    while (self.combinator) {
        id <Combinator> previousCombinator = self.combinator;
        [self parseStepFromScanner:scanner];
        if (self.matcher) [destination appendCombinator:previousCombinator matcher:self.matcher];
    };
}
@end
