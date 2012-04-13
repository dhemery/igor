@protocol IgorQueryScanner;

@protocol SubjectChainParser <NSObject>

@property (strong) NSArray *subjectPatternParsers;

- (BOOL)parseSubjectMatcherIntoArray:(NSMutableArray *)array;

- (BOOL)parseSubjectMatchersIntoArray:(NSMutableArray *)array;

@end