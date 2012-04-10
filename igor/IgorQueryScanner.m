#import "IgorQueryScanner.h"
#import "IgorParserException.h"


@implementation IgorQueryScanner {
    NSScanner *_scanner;
}

- (void)backUp {
    [_scanner setScanLocation:[_scanner scanLocation] - 1];
}

- (NSString *)description {
    return [_scanner string];
}

- (void)failBecause:(NSString *)reason {
    @throw [IgorParserException exceptionWithReason:reason scanner:_scanner];
}

- (void)failIfNotAtEnd {
    if (![_scanner isAtEnd]) {
        [self failBecause:@"Unexpected characters"];
    }
}

- (IgorQueryScanner *)initWithPattern:(NSString *)query {
    self = [super init];
    if (self) {
        NSString *stripped = [query stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
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

+ (IgorQueryScanner *)withQuery:(NSString *)query {
    return [[self alloc] initWithPattern:query];
}

@end