USING: io alien alien.c-types alien.libraries
alien.libraries.finder alien.syntax io io.encodings.ascii kernel
opengl.gl.extensions system threads ;
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

: on-init ( -- callback )
    void {  } cdecl [
        "Hello" print
    ] alien-callback ;


: ui-wait ( -- t )
    1000 milliseconds sleep
    t ; 

: wait-loop ( -- )
    [ ui-wait ] [ "Waiting..." print ] while ;

: launch ( -- )
    "./assets" "{}" "{}" on-init init ;


: app ( -- ) 
    launch
    wait-loop ;

MAIN: app