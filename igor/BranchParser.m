#import "BranchParser.h"
#import "BranchMatcher.h"
#import "QueryScanner.h"
#import "ChainParser.h"

@implementation BranchParser {
    ChainParser *subjectChainParser;
}

- (id <PatternParser>)initWithChainParser:(ChainParser *)theSubjectChainParser {
    self = [super init];
    if (self) {
        subjectChainParser = theSubjectChainParser;
    }
    return self;
}

- (id <Matcher>)parseBranchMatcherFromScanner:(id <QueryScanner>)scanner {
    id <Matcher> subject = [subjectChainParser parseStepFromScanner:scanner];
    if (!subject) [scanner failBecause:@"Expected a relationship pattern"];
    if (subjectChainParser.done) return subject;
    id <ChainMatcher> matcher = [BranchMatcher matcherWithSubjectMatcher:subject];
    [subjectChainParser parseSubjectChainFromScanner:scanner intoMatcher:matcher];
    return matcher;
}

- (id <Matcher>)parseMatcherFromScanner:(id <QueryScanner>)scanner {
    if (![scanner skipString:@"("]) return nil;
    id <Matcher> matcher = [self parseBranchMatcherFromScanner:scanner];
    if (![scanner skipString:@")"]) {
        [scanner failBecause:@"Expected ')'"];
    }
    return matcher;
}

+ (id <PatternParser>)parserWithChainParser:(ChainParser *)chainParser {
    return [[self alloc] initWithChainParser:chainParser];
}

@end
