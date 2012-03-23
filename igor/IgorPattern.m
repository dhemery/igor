#import "IgorPattern.h"
#import "IgorParserException.h"
#import "Matcher.h"
#import "SubjectPattern.h"
#import "SubjectSubtreeMatcher.h"

@implementation IgorPattern

+ (IgorPattern *)forPattern:(NSString *)pattern {
    NSString *stripped = [pattern stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSScanner *scanner = [NSScanner scannerWithString:stripped];
    [scanner setCharactersToBeSkipped:nil];
    return (IgorPattern *)[[self alloc] initWithScanner:scanner];
}

- (Matcher *)parse {
    SubjectPattern *subjectParser = [SubjectPattern new];
    Matcher *matcher = [subjectParser parse:self.scanner];
    if ([self.scanner scanString:@"!" intoString:nil]) {
        Matcher *subtreeMatcher = [subjectParser parse:self.scanner];
        matcher = [SubjectSubtreeMatcher withSubjectMatcher:matcher subtreeMatcher:subtreeMatcher];
    }
    [self throwIfNotAtEndOfScanner];
    return matcher;
}

+ (NSScanner *)scannerForPattern:(NSString *)pattern {
    NSString *stripped = [pattern stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSScanner *scanner = [NSScanner scannerWithString:stripped];
    [scanner setCharactersToBeSkipped:nil];
    return scanner;
}

- (void)throwIfNotAtEndOfScanner {
    if (![self.scanner isAtEnd]) {
        NSString *badCharacters;
        [self.scanner scanUpToCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:&badCharacters];
        NSString *reason = [NSString stringWithFormat:@"Unexpected characters %@", badCharacters];
        @throw [IgorParserException exceptionWithReason:reason scanner:self.scanner];
    }
}

@end
