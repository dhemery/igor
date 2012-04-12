@protocol SubjectMatcher;
@protocol IgorQueryScanner;


@interface IgorQueryParser : NSObject

- (IgorQueryParser *)initWithQueryScanner:(id <IgorQueryScanner>)scanner;

- (id <SubjectMatcher>)nextMatcher;
+ (IgorQueryParser*) withQueryScanner:(id<IgorQueryScanner>)scanner;

@end
