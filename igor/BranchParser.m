#import "BranchParser.h"
#import "BranchMatcher.h"
#import "IgorQueryScanner.h"
#import "ChainParser.h"

@implementation BranchParser {
    id <IgorQueryScanner> scanner;
    ChainParser *subjectChainParser;
}

- (id <SubjectPatternParser>)initWithScanner:(id <IgorQueryScanner>)aScanner subjectChainParser:(ChainParser *)theSubjectChainParser {
    self = [super init];
    if (self) {
        scanner = aScanner;
        subjectChainParser = theSubjectChainParser;
    }
    return self;
}

- (id <Matcher>)parseBranchMatcher {
    id <Matcher> subject = [subjectChainParser parseStep];
    if (!subject) [scanner failBecause:@"Expected a relationship pattern"];
    if (subjectChainParser.done) return subject;
    id <ChainMatcher> matcher = [BranchMatcher matcherWithSubjectMatcher:subject];
    [subjectChainParser parseSubjectChainIntoMatcher:matcher];
    return matcher;
}

- (id <Matcher>)parseMatcher {
    if (![scanner skipString:@"("]) return nil;
    id <Matcher> matcher = [self parseBranchMatcher];
    if (![scanner skipString:@")"]) {
        [scanner failBecause:@"Expected ')'"];
    }
    return matcher;
}

+ (id <SubjectPatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner subjectChainParser:(ChainParser *)subjectChainParser {
    return [[self alloc] initWithScanner:scanner subjectChainParser:subjectChainParser];
}

@end
