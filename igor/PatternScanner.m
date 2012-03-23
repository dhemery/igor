#import "PatternScanner.h"
#import "IgorParserException.h"


@implementation PatternScanner {
    NSScanner *_scanner;
}

- (void)failBecause:(NSString *)reason {
    @throw [IgorParserException exceptionWithReason:reason scanner:_scanner];
}

- (void)failIfNotAtEnd {
    if (![_scanner isAtEnd]) {
        [self failBecause:@"Unexpected characters"];
    }
}

- (PatternScanner *)initWithPattern:(NSString *)pattern {
    self = [super init];
    if (self) {
        NSString *stripped = [pattern stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        _scanner = [NSScanner scannerWithString:stripped];
        [_scanner setCharactersToBeSkipped:nil];
    }
    return self;
}

- (BOOL)scanNameIntoString:(NSString **)destination {
    return [_scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:destination];
}

- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination {
    return [_scanner scanUpToString:string intoString:destination];
}

- (BOOL)skipString:(NSString *)string {
    return [_scanner scanString:string intoString:nil];
}

- (BOOL)skipWhiteSpace {
    return [_scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil];
}

+ (PatternScanner *)withPattern:(NSString *)pattern {
    return [[self alloc] initWithPattern:pattern];
}

@end