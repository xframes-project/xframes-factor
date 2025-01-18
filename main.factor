USING: alien alien.c-types alien.libraries
alien.libraries.finder alien.syntax calendar io
io.encodings.ascii kernel opengl.gl.extensions system threads concurrency.mailboxes ;
IN: app

LIBRARY: xframesshared

! : start-loop ( -- x x)
!     [ 
!       1000 milliseconds sleep 
!     ] thread ;

<<
os linux? [
    "xframesshared" "libxframesshared.so" cdecl add-library
] when
>>

CALLBACK: void OnInitCb ( )
FUNCTION: void init ( c-string baseAssetsPath, c-string fontDefs, c-string themeDef, OnInitCb onInit )
FUNCTION: void setElement ( c-string elementJson )
FUNCTION: void setChildren ( int id, c-string childrenIdJson )

: after-init ( -- )
    "{\"type\": \"node\", \"id\": 0, \"root\": true}" setElement
    "{\"type\": \"unformatted-text\", \"id\": 1, \"text\": \"Hello, world\"}" setElement

    0 "[1]" setChildren ;

: on-init ( -- callback )
    void {  } cdecl [
        [ after-init ] in-thread
    ] alien-callback ;


: ui-wait ( -- t )
    1000 milliseconds sleep
    t ; 

: wait-loop ( -- )
    [ ui-wait ] [  ] while ;

: launch ( -- )
    [
        "./assets" "{\"defs\": [{\"name\": \"roboto-regular\", \"size\": 16}]}" "{}" on-init init
    ] in-thread ;


: app ( -- ) 
    launch
    wait-loop ;

MAIN: app