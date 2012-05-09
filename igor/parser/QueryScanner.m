#import "QueryScanner.h"
#import "IgorParserException.h"

// todo  Test
@implementation QueryScanner

@synthesize scanner;

- (id <QueryScanner>)initWithString:(NSString *)queryString {
    self = [super init];
    if (self) {
        scanner = [NSScanner scannerWithString:queryString];
        [scanner setCharactersToBeSkipped:nil];
    }
    return self;
}
- (NSString *)description {
    return [self.scanner string];
}

- (void)failBecause:(NSString *)reason {
    @throw [IgorParserException exceptionWithReason:reason scanner:self.scanner];
}

- (void)failIfNotAtEnd {
    if (![self.scanner isAtEnd]) {
        [self failBecause:@"Unexpected characters"];
    }
}

- (BOOL)scanNameIntoString:(NSString **)destination {
    NSMutableCharacterSet *nameCharacterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [nameCharacterSet addCharactersInString:@"_"];
    return [self.scanner scanCharactersFromSet:nameCharacterSet intoString:destination];
}

+ (id <QueryScanner>)scannerWithString:(NSString *)queryString {
    return [[self alloc] initWithString:queryString];
}

- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination {
    return [self.scanner scanUpToString:string intoString:destination];
}

- (BOOL)skipString:(NSString *)string {
    return [self.scanner scanString:string intoString:nil];
}

- (BOOL)skipWhiteSpace {
    return [self.scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil];
}

@end