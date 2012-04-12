#import "ScanningInstanceParser.h"
#import "ScanningInstanceChainParser.h"
#import "IgorQueryStringScanner.h"
#import "ComplexMatcher.h"
#import "UniversalMatcher.h"

@implementation ScanningInstanceChainParser {
    id<InstanceParser> instanceParser;
    id<IgorQueryScanner> scanner;
}

- (id<InstanceChainParser>)initWithScanner:(id<IgorQueryScanner>)theScanner instanceParser:(id<InstanceParser>)theInstanceParser {
    if (self = [super init]) {
        scanner = theScanner;
        instanceParser = theInstanceParser;
    }
    return self;
}

- (id <SubjectMatcher>)parseSubjectMatcher {
    if ([scanner nextStringIs:@"("]) {
        NSLog(@"Found branch pattern. Parsing.");
        return [self parseBranchMatcher];
    }
    NSLog(@"Found instance pattern. Parsing.");
    return [instanceParser parseInstanceMatcher];
}

- (id<SubjectMatcher>)parseBranchMatcher {
    [scanner skipString:@"("];
    NSMutableArray* branchInstanceChain = [NSMutableArray array];
    [self parseInstanceMatchersIntoArray:branchInstanceChain];
    [scanner skipString:@")"];
    id<SubjectMatcher> subject = [branchInstanceChain objectAtIndex:0];
    [branchInstanceChain removeObjectAtIndex:0];
    id <SubjectMatcher> tail = [self subjectMatcherFromMatcherChain:branchInstanceChain];
    return [ComplexMatcher matcherWithSubject:subject tail:tail];
}

- (void)parseInstanceMatchersIntoArray:(NSMutableArray*)instanceMatchers {
    BOOL foundSubjectMarker;
    while(!(foundSubjectMarker = [scanner nextStringIs:@"$"])) {
        id <SubjectMatcher> subjectMatcher = [self parseSubjectMatcher];
        [instanceMatchers addObject:subjectMatcher];
        NSLog(@"Parsed matcher: %@", subjectMatcher);
        if (![scanner skipWhiteSpace]) {
            NSLog(@"No whitespace. Done parsing chain.");
            return;
        }
    }
    if (foundSubjectMarker) {
        NSLog(@"Hit subject marker. Done parsing chain.");
        return;
    }
    NSLog(@"Reached end of query. Done parsing chain.");
}

+ (id<InstanceChainParser>)parserWithScanner:(id<IgorQueryScanner>)scanner instanceParser:(id<InstanceParser>)instanceParser {
    return [[self alloc] initWithScanner:scanner instanceParser:instanceParser];
}

- (id <SubjectMatcher>)subjectMatcherFromMatcherChain:(NSArray *)matcherChain {
    if ([matcherChain count] == 0) {
        return [UniversalMatcher new];
    }
    if ([matcherChain count] == 1) {
        return [matcherChain lastObject];
    }
    id<SubjectMatcher> matcher = [matcherChain objectAtIndex:0];
    for (NSUInteger i = 1 ; i < [matcherChain count] ; i++) {
        matcher = [ComplexMatcher matcherWithHead:matcher subject:[matcherChain objectAtIndex:i] ];
    }
    return matcher;
}


@end
