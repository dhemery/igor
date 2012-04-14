@protocol SubjectMatcher;
@protocol Combinator;

@interface ChainParserState : NSObject

@property(nonatomic, strong) id <Combinator> combinator;
@property(nonatomic, readonly, getter=isDone) BOOL done;
@property(nonatomic, strong) id <SubjectMatcher> matcher;
@property(nonatomic, readonly, getter=isStarted) BOOL started;

+ (ChainParserState *)stateWithMatcher:(id <SubjectMatcher>)subjectMatcher combinator:(id <Combinator>)combinator;

@end