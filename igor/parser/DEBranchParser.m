#import "DEBranchParser.h"
#import "DEBranchMatcher.h"
#import "DEQueryScanner.h"
#import "DEChainParser.h"

@implementation DEBranchParser

@synthesize subjectChainParser;


- (id <DEPatternParser>)initWithChainParser:(id <DEChainParser>)theSubjectChainParser {
    self = [super init];
    if (self) {
        subjectChainParser = theSubjectChainParser;
    }
    return self;
}

- (id <DEMatcher>)parseBranchMatcherFromScanner:(id <DEQueryScanner>)scanner {
    id <DEMatcher> subject = [subjectChainParser parseStepFromScanner:scanner];
    if (!subject) [scanner failBecause:@"Expected a relationship pattern"];
    if (subjectChainParser.done) return subject;
    id <DEChainMatcher> matcher = [DEBranchMatcher matcherWithSubjectMatcher:subject];
    [subjectChainParser parseSubjectChainFromScanner:scanner intoMatcher:matcher];
    return matcher;
}

- (id <DEMatcher>)parseMatcherFromScanner:(id <DEQueryScanner>)scanner {
    if (![scanner skipString:@"("]) return nil;
    id <DEMatcher> matcher = [self parseBranchMatcherFromScanner:scanner];
    if (![scanner skipString:@")"]) {
        [scanner failBecause:@"Expected ')'"];
    }
    return matcher;
}

+ (id <DEPatternParser>)parserWithChainParser:(id <DEChainParser>)chainParser {
    return [[self alloc] initWithChainParser:chainParser];
}

@end
