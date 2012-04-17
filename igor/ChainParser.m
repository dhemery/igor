#import "InstanceParser.h"
#import "ChainParser.h"
#import "DescendantCombinator.h"
#import "ChainMatcher.h"
#import "CombinatorParser.h"

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

- (id <Matcher>)parseStep {
    self.combinator = nil;
    self.matcher = [self parseSubject];
    if (self.matcher) {
        self.combinator = [self parseCombinator];
    }
    return self.matcher;
}

- (id <Matcher>)parseSubject {
    for (id <SubjectPatternParser> parser in self.subjectParsers) {
        id <Matcher> matcher = [parser parseMatcher];
        if (matcher) return matcher;
    }
    return nil;
}

- (id <Combinator>)parseCombinator {
    for (id <CombinatorParser>parser in self.combinatorParsers) {
        id <Combinator> combinator = [parser parseCombinator];
        if (combinator) return combinator;
    }
    return nil;
}

- (void)parseSubjectChainIntoMatcher:(id <ChainMatcher>)destination {
    while (self.combinator) {
        id <Combinator> previousCombinator = self.combinator;
        [self parseStep];
        if (self.matcher) [destination appendCombinator:previousCombinator matcher:self.matcher];
    };
}
@end
