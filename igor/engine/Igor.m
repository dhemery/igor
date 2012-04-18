#import "Igor.h"
#import "QueryParser.h"
#import "QueryScanner.h"
#import "ChainParser.h"
#import "InstanceParser.h"
#import "ClassParser.h"
#import "PredicateParser.h"
#import "BranchParser.h"
#import "IdentifierParser.h"
#import "DescendantCombinator.h"
#import "Matcher.h"

@implementation Igor

@synthesize parser;

- (NSArray *)findViewsThatMatchMatcher:(id <Matcher>)matcher inTree:(UIView *)tree {
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
    id <QueryScanner> scanner = [QueryScanner scannerWithString:stripped];
    id <Matcher> matcher = [parser parseMatcherFromScanner:scanner];
    return [self findViewsThatMatchMatcher:matcher inTree:tree];
}

+ (Igor *)igor {
    id <PatternParser> classParser = [ClassParser new];
    id <PatternParser> predicateParser = [PredicateParser new];
    id <PatternParser> identifierParser = [IdentifierParser new];
    NSArray *simplePatternParsers = [NSArray arrayWithObjects:classParser, identifierParser, predicateParser, nil];

    id <PatternParser> instanceParser = [InstanceParser parserWithSimplePatternParsers:simplePatternParsers];

    id <CombinatorParser> combinatorParser = [CombinatorParser new];
    id <ChainParser> chainParser = [ChainParser parserWithCombinatorParser:combinatorParser];
    id <PatternParser> branchParser = [BranchParser parserWithChainParser:chainParser];
    NSArray *subjectParsers = [NSArray arrayWithObjects:instanceParser, branchParser, nil];
    chainParser.subjectParsers = subjectParsers;

    id <PatternParser> parser = [QueryParser parserWithChainParser:chainParser];

    return [self igorWithParser:parser];
}

+ (Igor *)igorWithParser:(id <PatternParser>)parser {
    return [[self alloc] initWithParser:parser];
}

- (Igor *)initWithParser:(id <PatternParser>)theParser {
    self = [super init];
    if (self) {
        parser = theParser;
    }
    return self;
}

- (NSArray *)selectViewsWithSelector:(NSString *)query {
    UIView *tree = [[UIApplication sharedApplication] keyWindow];
    return [self findViewsThatMatchQuery:query inTree:tree];
}

@end
