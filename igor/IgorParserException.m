#import "IgorParserException.h"

@implementation IgorParserException

+ (NSException *)exceptionWithReason:(NSString *)reason scanner:(NSScanner *)scanner {
    NSString *remainingCharacters;
    [scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&remainingCharacters];

    NSString *description = [NSString stringWithFormat:@"%@ at position %u starting with %@", reason, [scanner scanLocation], remainingCharacters];
    return [NSException exceptionWithName:@"IgorParserException" reason:description userInfo:nil];
}

@end
