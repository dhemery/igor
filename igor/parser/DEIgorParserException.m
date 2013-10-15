#import "DEIgorParserException.h"

@implementation DEIgorParserException

+ (NSException *)exceptionWithReason:(NSString *)reason scanner:(NSScanner *)scanner {
    unsigned long stopLocation = (unsigned long) [scanner scanLocation];
    NSString *remainingCharacters;
    [scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&remainingCharacters];

    NSString *description = [NSString stringWithFormat:@"%@ at position %lu starting with %@", reason, stopLocation, remainingCharacters];
    return [NSException exceptionWithName:@"IgorParserException" reason:description userInfo:nil];
}

@end
