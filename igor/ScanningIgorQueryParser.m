#import "ScanningIgorQueryParser.h"
#import "IgorQueryScanner.h"
#import "BranchMatcher.h"
#import "ChainParser.h"
#import "CombinatorMatcher.h"

// TODO Extract common branch parsing stuff
@implementation ScanningIgorQueryParser {
    id <IgorQueryScanner> scanner;
    ChainParser *chainParser;
}

+ (id <IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner relationshipParser:(ChainParser *)relationshipParser {
    return [[self alloc] initWithQueryScanner:scanner chainParser:relationshipParser];
}

- (id <IgorQueryParser>)initWithQueryScanner:(id <IgorQueryScanner>)theScanner chainParser:(ChainParser *)theChainParser {
    if (self = [super init]) {
        scanner = theScanner;
        chainParser = theChainParser;
    }
    return self;
}

- (id <SubjectMatcher>)parseMatcherFromQuery:(NSString *)queryString {
    [scanner setQuery:queryString];

    ChainParserState *query = [self parseSubject];
    if (!query.done) query = [self parseBranchMatcherWithSubject:query];
    if (!query.done) [scanner failBecause:@"Expected a subject pattern"];
    [scanner failIfNotAtEnd];
    return query.matcher;
}

- (ChainParserState *)parseSubject {
    ChainParserState *subject = [chainParser parseChain];
    if (subject.done) return subject;
    if (![scanner skipString:@"$"]) [scanner failBecause:@"Expected a subject marker"];
    if (subject.started) return [self parseSubjectWithPrefix:subject];
    return [chainParser parseOne];
}

- (ChainParserState *)parseSubjectWithPrefix:(ChainParserState *)prefix {
    ChainParserState *subject = [chainParser parseOne];
    id <SubjectMatcher> left = [CombinatorMatcher matcherWithSubjectMatcher:subject.matcher combinator:prefix.combinator relativeMatcher:prefix.matcher];
    return [ChainParserState stateWithMatcher:left combinator:subject.combinator];
}

- (ChainParserState *)parseBranchMatcherWithSubject:(ChainParserState *)subject {
    ChainParserState *relative = [chainParser parseChain];
    id <SubjectMatcher> branch = [BranchMatcher matcherWithSubjectMatcher:subject.matcher combinator:subject.combinator relativeMatcher:relative.matcher];
    return [ChainParserState stateWithMatcher:branch combinator:relative.combinator];
}

@end
