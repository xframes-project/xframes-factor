USING: io alien alien.c-types alien.libraries
alien.libraries.finder alien.syntax io io.encodings.ascii kernel
opengl.gl.extensions system threads ;
IN: hello-world

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

: on-init ( -- callback )
    void {  } cdecl [
        "Hello" print
    ] alien-callback ;

FUNCTION: void init ( c-string baseAssetsPath, c-string fontDefs, c-string themeDef, OnInitCb onInit )

: hello ( -- ) 
    "./assets" "{}" "{}" on-init init
    "Press Enter to continue..." print readln drop ;

MAIN: hello