#import "ScanningIgorQueryParser.h"
#import "IgorQueryScanner.h"
#import "BranchMatcher.h"
#import "SubjectChainParser.h"
#import "CombinatorMatcher.h"

// TODO Extract common branch parsing stuff
@implementation ScanningIgorQueryParser {
    id <IgorQueryScanner> scanner;
    SubjectChainParser *subjectChainParser;
}

+ (id <IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner subjectChainParser:(SubjectChainParser *)subjectChainParser {
    return [[self alloc] initWithQueryScanner:scanner subjectChainParser:subjectChainParser];
}

- (id <IgorQueryParser>)initWithQueryScanner:(id <IgorQueryScanner>)theScanner subjectChainParser:(SubjectChainParser *)theSubjectChainParser {
    self = [super init];
    if (self) {
        scanner = theScanner;
        subjectChainParser = theSubjectChainParser;
    }
    return self;
}

- (id <SubjectMatcher>)parseMatcherFromQuery:(NSString *)queryString {
    [scanner setQuery:queryString];

    SubjectChain *query = [self parseSubject];
    NSLog(@"Parser after parsing subject, query is %@", query);
    if (!query.done) query = [self parseBranchMatcherWithSubject:query];
    if (!query.done) [scanner failBecause:@"Expected a subject pattern"];
    [scanner failIfNotAtEnd];
    return query.matcher;
}

- (SubjectChain *)parseSubject {
    SubjectChain *subject = [subjectChainParser parseSubjectChain];
    if (subject.done) return subject;
    if (![scanner skipString:@"$"]) [scanner failBecause:@"Expected a subject marker"];
    if (subject.started) return [self parseSubjectWithPrefix:subject];
    return [subjectChainParser parseOneSubject];
}

- (SubjectChain *)parseSubjectWithPrefix:(SubjectChain *)prefix {
    SubjectChain *subject = [subjectChainParser parseOneSubject];
    id <SubjectMatcher> left = [CombinatorMatcher matcherWithRelativeMatcher:prefix.matcher combinator:prefix.combinator subjectMatcher:subject.matcher];
    return [SubjectChain stateWithMatcher:left combinator:subject.combinator];
}

- (SubjectChain *)parseBranchMatcherWithSubject:(SubjectChain *)subject {
    SubjectChain *relative = [subjectChainParser parseSubjectChain];
    id <SubjectMatcher> branch = [[BranchMatcher matcherWithSubjectMatcher:subject.matcher] appendCombinator:subject.combinator matcher:relative.matcher];
    return [SubjectChain stateWithMatcher:branch combinator:relative.combinator];
}

@end
