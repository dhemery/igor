#import "ScanningIgorQueryParser.h"
#import "IgorQueryScanner.h"
#import "BranchMatcher.h"
#import "ChainParser.h"
#import "CombinatorMatcher.h"

// TODO Extract common branch parsing stuff
@implementation ScanningIgorQueryParser {
    id <IgorQueryScanner> scanner;
    ChainParser *subjectChainParser;
}

+ (id <IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner subjectChainParser:(ChainParser *)subjectChainParser {
    return [[self alloc] initWithQueryScanner:scanner subjectChainParser:subjectChainParser];
}

- (id <IgorQueryParser>)initWithQueryScanner:(id <IgorQueryScanner>)theScanner subjectChainParser:(ChainParser *)theSubjectChainParser {
    self = [super init];
    if (self) {
        scanner = theScanner;
        subjectChainParser = theSubjectChainParser;
    }
    return self;
}

- (id <Matcher>)parseMatcherFromQuery:(NSString *)queryString {
    [scanner setQuery:queryString];

    id <Matcher> subject [self parseSubject];
    if (!query.done) query = [self parseBranchMatcherWithSubject:query];
    if (!query.done) [scanner failBecause:@"Expected a subject pattern"];
    [scanner failIfNotAtEnd];
    return query.matcher;
}

// Marker at start: $a
// Will appear as no matcher.
// Append onto nothing.

// Marker inside: a $b
// Will appear as matcher, followed by stuff ending in a combinator.
// Append onto gathered.

// No marker.
// Will appear as ending with nil combinator.

// Eat first matcher.
// If matcher, start a combinator. (next will be c)
// If no marker, start a fake combinator. (next will be m. D'oh!)
// Append onto that.
// If combinator, just be a $.
// So eat $, grab next, and append it.
// Done.
- (id <Matcher>)parseSubject {
    id <Matcher> matcher = [subjectChainParser parseSubjectMatcher];
    if <
    if (subject) {
        // Got a matcher without a $.
        // This will be complex, or will not contain a $.
        // Eat as much as we can.
        id <ChainMatcher> chain = [CombinatorMatcher matcherWithSubjectMatcher:subject];
        if ([subjectChainParser parseSubjectChainIntoMatcher:chain]) {
            // Got some stuff. If there's dangling
            subject = chain;
        }
            // Nothing new added to first matcher. So must be simple subject. Return it.
            return matcher;
        }


        if (![scanner skipString:@"$"]) [scanner failBecause:@"Expected a subject marker"];
        matcher = [subjectChainParser parseSubjectMatcher];
        // Now have a single matcher that is the subject.
    } else {
        // No starting matcher. Must start with $. Eat it and grab next matcher.
        if (![scanner skipString:@"$"]) [scanner failBecause:@"Expected a subject marker"];
        matcher = [subjectChainParser parseSubjectMatcher];
        // Now have a single matcher that is the subject.
    }
        // Got the first matcher.
        [subjectChainParser parseSubjectChainIntoMatcher:compoundSubject];
        if (subjectChainParser.combinator) {
            // Must have stopped in front of the $.
            // So eat $ and append next subject onto subject.
            if (![scanner skipString:@"$"]) [scanner failBecause:@"Expected a subject marker"];
            id <Matcher> matcher = [subjectChainParser parseSubjectMatcher];
            if (!matcher) [scanner failBecause:@"Expected a subject matcher after the $"];
            [subject appendCombinator:subjectChainParser.combinator matcher:matcher];
        }
    } else {
        // No matcher, so must have been before $.
        // Eat $ and next matcher is the subject.

    }


    matcher = [subjectChainParser parseSubjectMatcher];
    [subjectChainParser parseSubjectChainIntoMatcher:subject];
    id <ChainMatcher> subject = [CombinatorMatcher matcherWithSubjectMatcher:matcher];
    [subjectChainParser parseSubjectChainIntoMatcher:subject];
    id <ChainMatcher> subject = [CombinatorMatcher matcherWithSubjectMatcher:matcher];
    if (subject.done) return subject;
    if (subject.started) return [self parseSubjectWithPrefix:subject];
    return [subjectChainParser parseOneStep];
}

- (ChainStep *)parseSubjectWithPrefix:(ChainStep *)prefix {
    ChainStep *subject = [subjectChainParser parseOneStep];
    id <ChainMatcher> left = [CombinatorMatcher matcherWithSubjectMatcher:prefix.matcher];
    [left appendCombinator:prefix.combinator matcher:subject.matcher];
    return [ChainStep stateWithMatcher:left combinator:subject.combinator];
}

- (ChainStep *)parseBranchMatcherWithSubject:(ChainStep *)subject {
    ChainStep *relative = [subjectChainParser parseSubjectChain];
    id <ChainMatcher> branchMatcher = [BranchMatcher matcherWithSubjectMatcher:subject.matcher];
    [branchMatcher appendCombinator:subject.combinator matcher:relative.matcher];
    return [ChainStep stateWithMatcher:branchMatcher combinator:relative.combinator];
}

@end
