#import "InstanceParser.h"
#import "RelationshipParser.h"
#import "IgorQueryStringScanner.h"
#import "DescendantCombinator.h"

@implementation RelationshipParser {
    id <IgorQueryScanner> scanner;
    NSArray *combinatorParsers;
}

@synthesize subjectPatternParsers;

- (RelationshipParser *)initWithCombinatorParsers:(NSArray *)theCombinatorParsers {
    if (self = [super init]) {
        combinatorParsers = theCombinatorParsers;
    }
    return self;
}

- (id <SubjectMatcher>)parseSubjectMatcher {
    for (id <SubjectPatternParser>parser in subjectPatternParsers) {
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

+ (RelationshipParser *)parserWithCombinatorParsers:(NSArray *)combinatorParsers {
    return [[self alloc] initWithCombinatorParsers:combinatorParsers];
}

@end
