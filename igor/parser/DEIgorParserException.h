@interface DEIgorParserException : NSObject

+ (NSException *)exceptionWithReason:(NSString *)reason scanner:(NSScanner *)scanner;

@end
