#define NSZombies

fb -[NSException raise]
fb -[NSAssertionHandler handleFailureInFunction:file:lineNumber:description:]
fb -[NSAssertionHandler handleFailureInMethod:object:file:lineNumber:description:]

fb -[_NSZombie init]
fb -[_NSZombie retainCount]
fb -[_NSZombie retain]
fb -[_NSZombie release]
fb -[_NSZombie autorelease]
fb -[_NSZombie methodSignatureForSelector:]
fb -[_NSZombie respondsToSelector:]
fb -[_NSZombie forwardInvocation:]
fb -[_NSZombie class]
fb -[_NSZombie dealloc]

fb szone_error

set env MallocHelp=YES
set env NSDebugEnabled=YES
set env NSZombieEnabled=YES
set env NSDeallocateZombies=NO
set env MallocCheckHeapEach=100000
set env MallocCheckHeapStart=100000
set env MallocScribble=YES
set env MallocGuardEdges=YES
set env MallocCheckHeapAbort=1
set env NSAutoreleaseFreedObjectCheckEnabled=YES
set env MallocStackLoggingNoCompact=YES
set env MallocStackLogging=YES
set env CFZombie 5

tty /dev/ttys000