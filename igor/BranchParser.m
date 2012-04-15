#import "BranchParser.h"
#import "BranchMatcher.h"
#import "IgorQueryScanner.h"
#import "ChainParser.h"

@implementation BranchParser {
    id <IgorQueryScanner> scanner;
    ChainParser *chainParser;
}

- (id <SubjectPatternParser>)initWithScanner:(id <IgorQueryScanner>)aScanner relationshipParser:(ChainParser *)theChainParser {
    self = [super init];
    if (self) {
        scanner = aScanner;
        chainParser = theChainParser;
    }
    return self;
}

- (id <SubjectMatcher>)parseBranchMatcher {
    ChainParserState *subject = [chainParser parseOne];

    if (!subject.started) [scanner failBecause:@"Expected a relationship pattern"];

    if (subject.done) return subject.matcher;

    ChainParserState* relative = [chainParser parseChain];
    if (!relative.done) [scanner failBecause:@"Expected a subject pattern"];
    return [BranchMatcher matcherWithSubjectMatcher:subject.matcher combinator:subject.combinator relativeMatcher:relative.matcher];
}

- (id <SubjectMatcher>)parseSubjectMatcher {
    if (![scanner skipString:@"("]) return nil;
    id <SubjectMatcher> matcher = [self parseBranchMatcher];
    if (![scanner skipString:@")"]) {
        [scanner failBecause:@"Expected ')'"];
    }
    return matcher;
}

+ (id <SubjectPatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner chainParser:(ChainParser *)relationshipParser {
    return [[self alloc] initWithScanner:scanner relationshipParser:relationshipParser];
}

@end
