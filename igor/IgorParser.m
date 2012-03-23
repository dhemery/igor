#import "IgorParser.h"
#import "IgorParserException.h"
#import "Matcher.h"
#import "SubjectPattern.h"
#import "SubjectSubtreeMatcher.h"

@implementation IgorParser {
    NSScanner *_scanner;
}

+ (IgorParser *)forPattern:(NSString *)pattern {
    return [[self alloc] initWithPattern:pattern];
}

- (IgorParser *)initWithPattern:(NSString *)pattern {
    self = [super init];
    if (self) {
        NSString *stripped = [pattern stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        _scanner = [NSScanner scannerWithString:stripped];
        [_scanner setCharactersToBeSkipped:nil];
    }
    return self;
}

- (Matcher *)parse {
    SubjectPattern *subjectParser = [SubjectPattern new];
    Matcher *matcher = [subjectParser parse:_scanner];
    if ([_scanner scanString:@"!" intoString:nil]) {
        Matcher *subtreeMatcher = [subjectParser parse:_scanner];
        matcher = [SubjectSubtreeMatcher withSubjectMatcher:matcher subtreeMatcher:subtreeMatcher];
    }
    [self throwIfNotAtEndOfScanner];
    return matcher;
}

- (void)throwIfNotAtEndOfScanner {
    if (![_scanner isAtEnd]) {
        NSString *badCharacters;
        [_scanner scanUpToCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:&badCharacters];
        NSString *reason = [NSString stringWithFormat:@"Unexpected characters %@", badCharacters];
        @throw [IgorParserException exceptionWithReason:reason scanner:_scanner];
    }
}

@end
