#import "IgorParserException.h"

@implementation IgorParserException

+ (NSException *)exceptionWithReason:(NSString *)reason scanner:(NSScanner *)scanner {
    NSUInteger stopLocation = [scanner scanLocation];
    NSString *remainingCharacters;
    [scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&remainingCharacters];

    NSString *description = [NSString stringWithFormat:@"%@ at position %u starting with %@", reason, stopLocation, remainingCharacters];
    return [NSException exceptionWithName:@"IgorParserException" reason:description userInfo:nil];
}

@end
