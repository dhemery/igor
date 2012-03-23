#import "IgorParserException.h"

@implementation IgorParserException

+ (NSException *)exceptionWithReason:(NSString *)reason scanner:(NSScanner *)scanner {
    NSString *description = [NSString stringWithFormat:@"%@ at position %u", reason, [scanner scanLocation]];
    return [NSException exceptionWithName:@"IgorParserException" reason:description userInfo:nil];
}

@end
