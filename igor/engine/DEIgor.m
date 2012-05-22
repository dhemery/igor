#import "DEIgor.h"
#import "DEQueryParser.h"
#import "DEQueryScanner.h"
#import "DEChainParser.h"
#import "DEInstanceParser.h"
#import "DEClassParser.h"
#import "DEPredicateParser.h"
#import "DEBranchParser.h"
#import "DEIdentifierParser.h"
#import "DescendantCombinator.h"
#import "DEMatcher.h"

@implementation DEIgor {
    id <DEPatternParser> _parser;
}

- (NSArray *)findViewsThatMatchMatcher:(id <DEMatcher>)matcher inTree:(UIView *)tree {
    NSMutableSet *matchingViews = [NSMutableSet set];
    NSMutableArray *allViews = [NSMutableArray arrayWithObject:tree];
    [allViews addObjectsFromArray:[[DescendantCombinator new] relativesOfView:tree]];
    for (UIView *view in allViews) {
        if ([matcher matchesView:view]) [matchingViews addObject:view];
    }
    return [matchingViews allObjects];
}

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree {
    NSString *stripped = [query stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    id <DEQueryScanner> scanner = [DEQueryScanner scannerWithString:stripped];
    id <DEMatcher> matcher = [_parser parseMatcherFromScanner:scanner];
    return [self findViewsThatMatchMatcher:matcher inTree:tree];
}

+ (DEIgor *)igor {
    id <DEPatternParser> classParser = [DEClassParser new];
    id <DEPatternParser> predicateParser = [DEPredicateParser new];
    id <DEPatternParser> identifierParser = [DEIdentifierParser new];
    NSArray *simpleParsers = [NSArray arrayWithObjects:identifierParser, predicateParser, nil];
    id <DEPatternParser> instanceParser = [DEInstanceParser parserWithClassParser:classParser simpleParsers:simpleParsers];

    id <DECombinatorParser> combinatorParser = [DECombinatorParser new];
    id <DEChainParser> chainParser = [DEChainParser parserWithCombinatorParser:combinatorParser];
    id <DEPatternParser> branchParser = [DEBranchParser parserWithChainParser:chainParser];
    NSArray *subjectParsers = [NSArray arrayWithObjects:instanceParser, branchParser, nil];
    chainParser.subjectParsers = subjectParsers;

    id <DEPatternParser> parser = [DEQueryParser parserWithChainParser:chainParser];

    return [self igorWithParser:parser];
}

+ (DEIgor *)igorWithParser:(id <DEPatternParser>)parser {
    return [[self alloc] initWithParser:parser];
}

- (DEIgor *)initWithParser:(id <DEPatternParser>)parser {
    self = [super init];
    if (self) {
        _parser = parser;
    }
    return self;
}

@end
