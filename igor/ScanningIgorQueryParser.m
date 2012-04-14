#import "ScanningIgorQueryParser.h"
#import "IgorQueryScanner.h"
#import "BranchMatcher.h"
#import "ChainParser.h"
#import "CombinatorMatcher.h"

// TODO Extract common branch parsing stuff
@implementation ScanningIgorQueryParser {
    id <IgorQueryScanner> scanner;
    id <SubjectPatternParser> subjectParser;
    id <CombinatorParser> combinatorParser;
}

- (id <IgorQueryParser>)initWithQueryScanner:(id <IgorQueryScanner>)theScanner relationshipParser:(ChainParser *)theRelationshipParser {
    if (self = [super init]) {
        scanner = theScanner;
        subjectParser = theRelationshipParser;
        combinatorParser = theRelationshipParser;
    }
    return self;
}

- (id <SubjectMatcher>)parseMatcherFromQuery:(NSString *)query {
    [scanner setQuery:query];

    id <SubjectMatcher> matcher = [subjectParser parseSubjectMatcher];
    id <Combinator> combinator;
    while ((combinator = [combinatorParser parseCombinator])) {
        id <SubjectMatcher> subjectMatcher = [subjectParser parseSubjectMatcher];
        if (!subjectMatcher) break; // what if we put the combinator back before breaking?
        matcher = [CombinatorMatcher matcherWithSubjectMatcher:subjectMatcher combinator:combinator relativeMatcher:matcher];
    }

    if (combinator) { // Interrupted.
        if (![scanner skipString:@"$"]) {
            [scanner failBecause:@"Expected $"];
        }
        // Parse a subject, combine it with the chain built so far
        // to make the subject of the Igor query.
        id <SubjectMatcher> subjectMatcher = [subjectParser parseSubjectMatcher];
        if (!subjectMatcher) {
            [scanner failBecause:@"Expected a subject pattern after '$'"];
        }
        matcher = [CombinatorMatcher matcherWithSubjectMatcher:subjectMatcher combinator:combinator relativeMatcher:matcher];
        combinator = [combinatorParser parseCombinator];
    }

    if (!matcher) { // If not started.
        if (![scanner skipString:@"$"]) {
            [scanner failBecause:@"The query must start with a subject pattern"];
        }
        matcher = [subjectParser parseSubjectMatcher];
        if (!matcher) {
            [scanner failBecause:@"Expected a subject pattern after '$'"];
        }
        combinator = [combinatorParser parseCombinator];
    }

    if (combinator) { // If not completed.
        id <SubjectMatcher> branchMatcher = [subjectParser parseSubjectMatcher];
        if (!branchMatcher) {
            NSString *message = [NSString stringWithFormat:@"Expected a subject pattern after '%@'", combinator];
            [scanner failBecause:message];
        }
        id <Combinator> branchCombinator;
        while ((branchCombinator = [combinatorParser parseCombinator])) {
            id <SubjectMatcher> subjectMatcher = [subjectParser parseSubjectMatcher];
            if (!subjectMatcher) {
                NSString *message = [NSString stringWithFormat:@"Expected a subject pattern after '%@'", branchCombinator];
                [scanner failBecause:message];
            }
            branchMatcher = [CombinatorMatcher matcherWithSubjectMatcher:subjectMatcher combinator:branchCombinator relativeMatcher:branchMatcher];
        }
        matcher = [BranchMatcher matcherWithSubjectMatcher:matcher combinator:combinator relativeMatcher:branchMatcher];
    }

    [scanner failIfNotAtEnd];
    return matcher;
}

+ (id <IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner relationshipParser:(ChainParser *)relationshipParser {
    return [[self alloc] initWithQueryScanner:scanner relationshipParser:relationshipParser];
}

@end
