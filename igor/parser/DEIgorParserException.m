#import "DEIgorParserException.h"

@implementation DEIgorParserException

+ (NSException *)exceptionWithReason:(NSString *)reason scanner:(NSScanner *)scanner {
    NSUInteger stopLocation = [scanner scanLocation];
    NSString *remainingCharacters;
    [scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&remainingCharacters];

    NSString *description = [NSString stringWithFormat:@"%@ at position %u starting with %@", reason, (uint)stopLocation, remainingCharacters];
    return [NSException exceptionWithName:@"IgorParserException" reason:description userInfo:nil];
}

@end
