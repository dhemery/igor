#import "SubjectChain.h"

@protocol IgorQueryScanner;

@interface SubjectChainParser : NSObject

@property (strong) NSArray *subjectParsers;
@property(strong) id <IgorQueryScanner> scanner;
@property(strong) NSArray *combinatorParsers;


+ (SubjectChainParser *)parserWithCombinatorParsers:(NSArray *)combinatorParsers;

+ (SubjectChainParser *)parserWithSubjectParsers:(NSArray *)subjectParsers combinatorParsers:(NSArray *)combinatorParsers;

- (SubjectChain *)parseOneSubject;

- (SubjectChain *)parseSubjectChain;

@end
