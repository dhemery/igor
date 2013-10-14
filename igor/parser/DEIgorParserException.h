@interface DEIgorParserException : NSException

+ (NSException *)exceptionWithReason:(NSString *)reason scanner:(NSScanner *)scanner;

@end
