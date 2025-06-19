��
SC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\UsuarioRepository.cs
	namespace

 	

DataAccess


 
.

 
Repositories

 !
{ 
public 

class 
UsuarioRepository "
:# $
BaseRepository% 3
,3 4
IUsuarioRepository5 G
{ 
private 
readonly $
IEventTrackingRepository 1$
_eventTrackingRepository2 J
;J K
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
public 
UsuarioRepository  
(! "
ILogger 
< 
UsuarioRepository %
>% &
logger' -
,- .&
ISqlServerDbContextFactory &%
sqlServerDbContextFactory' @
,@ A$
IEventTrackingRepository $#
eventTrackingRepository% <
,< =
IConfiguration 
configuration (
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	$
_eventTrackingRepository $
=% &#
eventTrackingRepository' >
;> ?
_configuration 
= 
configuration *
;* +
} 	
public 
Usuario 
? 
FindById  
(  !
int! $
	idUsuario% .
). /
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
var   
query   
=   
from    
usuario  ! (
in  ) +
context  , 3
.  3 4
Usuario  4 ;
.  ; <
AsNoTracking  < H
(  H I
)  I J
join!!  
homologacion!!! -
in!!. 0
context!!1 8
.!!8 9
VwRol!!9 >
.!!> ?
AsNoTracking!!? K
(!!K L
)!!L M
on"" 
usuario"" &
.""& '
IdHomologacionRol""' 8
equals""9 ?
homologacion""@ L
.""L M
IdHomologacionRol""M ^
into""_ c
homologacionJoin""d t
from##  
homologacion##! -
in##. 0
homologacionJoin##1 A
.##A B
DefaultIfEmpty##B P
(##P Q
)##Q R
join$$  
ona$$! $
in$$% '
context$$( /
.$$/ 0
ONA$$0 3
.$$3 4
AsNoTracking$$4 @
($$@ A
)$$A B
on%% 
usuario%% &
.%%& '
IdONA%%' ,
equals%%- 3
ona%%4 7
.%%7 8
IdONA%%8 =
where&& !
usuario&&" )
.&&) *
	IdUsuario&&* 3
==&&4 6
	idUsuario&&7 @
orderby'' #
usuario''$ +
.''+ ,
	IdUsuario'', 5
select(( "
new((# &
Usuario((' .
{)) 
	IdUsuario**  )
=*** +
usuario**, 3
.**3 4
	IdUsuario**4 =
,**= >
IdONA++  %
=++& '
usuario++( /
.++/ 0
IdONA++0 5
,++5 6
Nombre,,  &
=,,' (
usuario,,) 0
.,,0 1
Nombre,,1 7
,,,7 8
Apellido--  (
=--) *
usuario--+ 2
.--2 3
Apellido--3 ;
,--; <
Telefono..  (
=..) *
usuario..+ 2
...2 3
Telefono..3 ;
,..; <
Email//  %
=//& '
usuario//( /
./// 0
Email//0 5
,//5 6
IdHomologacionRol00  1
=002 3
usuario004 ;
.00; <
IdHomologacionRol00< M
,00M N
Estado11  &
=11' (
usuario11) 0
.110 1
Estado111 7
}33 
;33 
return66 
query66 
.66 
FirstOrDefault66 +
(66+ ,
)66, -
;66- .
}77 
)77 
;77 
}88 	
public99 
ICollection99 
<99 

UsuarioDto99 %
>99% &
FindAll99' .
(99. /
)99/ 0
{:: 	
return;; 
ExecuteDbOperation;; %
(;;% &
context;;& -
=>;;. 0
{<< 
var== 
query== 
=== 
from==  
usuario==! (
in==) +
context==, 3
.==3 4
Usuario==4 ;
.==; <
AsNoTracking==< H
(==H I
)==I J
join>>  
homologacion>>! -
in>>. 0
context>>1 8
.>>8 9
VwRol>>9 >
.>>> ?
AsNoTracking>>? K
(>>K L
)>>L M
on?? 
usuario?? &
.??& '
IdHomologacionRol??' 8
equals??9 ?
homologacion??@ L
.??L M
IdHomologacionRol??M ^
into??_ c
homologacionJoin??d t
from@@  
homologacion@@! -
in@@. 0
homologacionJoin@@1 A
.@@A B
DefaultIfEmpty@@B P
(@@P Q
)@@Q R
joinAA  
onaAA! $
inAA% '
contextAA( /
.AA/ 0
ONAAA0 3
.AA3 4
AsNoTrackingAA4 @
(AA@ A
)AAA B
onBB 
usuarioBB &
.BB& '
IdONABB' ,
equalsBB- 3
onaBB4 7
.BB7 8
IdONABB8 =
whereCC !
usuarioCC" )
.CC) *
EstadoCC* 0
==CC1 3

ConstantesCC4 >
.CC> ?
ESTADO_USUARIO_ACC? O
orderbyDD #
usuarioDD$ +
.DD+ ,
	IdUsuarioDD, 5
selectEE "
newEE# &

UsuarioDtoEE' 1
{FF 
	IdUsuarioGG  )
=GG* +
usuarioGG, 3
.GG3 4
	IdUsuarioGG4 =
,GG= >
IdONAHH  %
=HH& '
usuarioHH( /
.HH/ 0
IdONAHH0 5
,HH5 6
NombreII  &
=II' (
usuarioII) 0
.II0 1
NombreII1 7
,II7 8
ApellidoJJ  (
=JJ) *
usuarioJJ+ 2
.JJ2 3
ApellidoJJ3 ;
,JJ; <
TelefonoKK  (
=KK) *
usuarioKK+ 2
.KK2 3
TelefonoKK3 ;
,KK; <
EmailLL  %
=LL& '
usuarioLL( /
.LL/ 0
EmailLL0 5
,LL5 6
RolMM  #
=MM$ %
homologacionMM& 2
.MM2 3
RolMM3 6
,MM6 7
EstadoNN  &
=NN' (
usuarioNN) 0
.NN0 1
EstadoNN1 7
,NN7 8
RazonSocialOO  +
=OO, -
onaOO. 1
.OO1 2
RazonSocialOO2 =
,OO= >
IdHomologacionRolPP  1
=PP2 3
usuarioPP4 ;
.PP; <
IdHomologacionRolPP< M
}QQ 
;QQ 
returnSS 
querySS 
.SS 
ToListSS #
(SS# $
)SS$ %
;SS% &
}TT 
)TT 
;TT 
}UU 	
publicXX 
UsuarioXX 
?XX 
FindByEmailXX #
(XX# $
stringXX$ *
emailXX+ 0
)XX0 1
{XX2 3
returnYY 
ExecuteDbOperationYY %
(YY% &
contextYY& -
=>YY. 0
contextZZ 
.ZZ 
UsuarioZZ 
.ZZ  
AsNoTrackingZZ  ,
(ZZ, -
)ZZ- .
.ZZ. /
FirstOrDefaultZZ/ =
(ZZ= >
uZZ> ?
=>ZZ@ B
uZZC D
.ZZD E
EmailZZE J
!=ZZK M
nullZZN R
&&ZZS U
uZZV W
.ZZW X
EmailZZX ]
.ZZ] ^
ToLowerZZ^ e
(ZZe f
)ZZf g
==ZZh j
emailZZk p
.ZZp q
ToLowerZZq x
(ZZx y
)ZZy z
)ZZz {
)ZZ{ |
;ZZ| }
}[[ 	
public]] 
bool]] 
IsUniqueUser]]  
(]]  !
string]]! '
email]]( -
)]]- .
{^^ 	
return__ 
ExecuteDbOperation__ %
(__% &
context__& -
=>__. 0
context`` 
.`` 
Usuario`` 
.``  
AsNoTracking``  ,
(``, -
)``- .
.``. /
FirstOrDefault``/ =
(``= >
u``> ?
=>``@ B
u``C D
.``D E
Email``E J
==``K M
email``N S
)``S T
==``U W
null``X \
)``\ ]
;``] ^
}aa 	
publicbb 
boolbb 
Createbb 
(bb 
Usuariobb "
usuariobb# *
)bb* +
{cc 	
returndd 
ExecuteDbOperationdd %
(dd% &
contextdd& -
=>dd. 0
{ee 
contextff 
.ff 
Usuarioff 
.ff  
Addff  #
(ff# $
usuarioff$ +
)ff+ ,
;ff, -
ifgg 
(gg 
contextgg 
.gg 
SaveChangesgg (
(gg( )
)gg) *
>=gg+ -
$numgg. /
)gg0 1
{hh !
SendConfirmationEmailii )
(ii) *
usuarioii* 1
,ii1 2
usuarioii3 :
.ii: ;
Claveii; @
)ii@ A
;iiA B
returnjj 
truejj 
;jj  
}kk 
returnll 
falsell 
;ll 
}mm 
)mm 
;mm 
}nn 	
publicoo 
voidoo !
SendConfirmationEmailoo )
(oo) *
Usuariooo* 1
usuariooo2 9
,oo9 :
stringoo; A
claveooB G
)ooG H
{pp 	
stringqq 
templatePathqq 
=qq  !
_configurationqq" 0
[qq0 1
$strqq1 N
]qqN O
??qqP R
$strqqS U
;qqU V
ifss 
(ss 
Filess 
.ss 
Existsss 
(ss 
templatePathss (
)ss( )
)ss) *
{tt 
stringuu 
htmlBodyuu 
=uu  !
Fileuu" &
.uu& '
ReadAllTextuu' 2
(uu2 3
templatePathuu3 ?
)uu? @
;uu@ A
_ww 
=ww 
Taskww 
.ww 
Runww 
(ww 
asyncww "
(ww# $
)ww$ %
=>ww& (
{xx 
tryyy 
{zz 
htmlBody{{  
={{! "
string{{# )
.{{) *
Format{{* 0
({{0 1
htmlBody{{1 9
,{{9 :
usuario{{; B
.{{B C
Nombre{{C I
,{{I J
usuario{{K R
.{{R S
Email{{S X
,{{X Y
clave{{Z _
){{_ `
;{{` a
}}} 
catch~~ 
(~~ 
	Exception~~ $
ex~~% '
)~~' (
{ 
Console
�� 
.
��  
	WriteLine
��  )
(
��) *
$"
��* ,
$str
��, D
{
��D E
ex
��E G
.
��G H
Message
��H O
}
��O P
"
��P Q
)
��Q R
;
��R S
}
�� 
}
�� 
)
�� 
;
�� 
}
�� 
else
�� 
{
�� 
throw
�� 
new
�� #
FileNotFoundException
�� /
(
��/ 0
$str
��0 v
)
��v w
;
��w x
}
�� 
}
�� 	
public
�� 
bool
�� 
Update
�� 
(
�� 
Usuario
�� "
usuario
��# *
)
��* +
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
var
�� 
_exits
�� 
=
�� #
MergeEntityProperties
�� 2
(
��2 3
context
��3 :
,
��: ;
usuario
��< C
,
��C D
u
��E F
=>
��G I
u
��J K
.
��K L
	IdUsuario
��L U
==
��V X
usuario
��Y `
.
��` a
	IdUsuario
��a j
)
��j k
;
��k l
if
�� 
(
�� 
_exits
�� 
==
�� 
null
�� "
)
��" #
{
�� 
return
�� 
false
��  
;
��  !
}
�� 
_exits
�� 
.
�� 
FechaModifica
�� $
=
��% &
DateTime
��' /
.
��/ 0
Now
��0 3
;
��3 4
var
�� 
claveActual
�� 
=
��  !
context
��" )
.
��) *
Usuario
��* 1
.
�� 
Where
�� 
(
�� 
u
�� 
=>
�� 
u
��  !
.
��! "
	IdUsuario
��" +
==
��, .
usuario
��/ 6
.
��6 7
	IdUsuario
��7 @
)
��@ A
.
�� 
Select
�� 
(
�� 
u
�� 
=>
��  
u
��! "
.
��" #
Clave
��# (
)
��( )
.
�� 
FirstOrDefault
�� #
(
��# $
)
��$ %
;
��% &
if
�� 
(
�� 
string
�� 
.
�� 
IsNullOrEmpty
�� (
(
��( )
usuario
��) 0
.
��0 1
Clave
��1 6
)
��6 7
)
��7 8
{
�� 
_exits
�� 
.
�� 
Clave
��  
=
��! "
claveActual
��# .
;
��. /
}
�� 
else
�� 
{
�� 
}
�� 
context
�� 
.
�� 
Usuario
�� 
.
��  
Update
��  &
(
��& '
_exits
��' -
)
��- .
;
��. /
return
�� 
context
�� 
.
�� 
SaveChanges
�� *
(
��* +
)
��+ ,
>
��- .
$num
��/ 0
;
��0 1
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
Result
�� 
<
�� 
bool
�� 
>
�� 
ChangePasswd
�� (
(
��( )
string
��) /
clave
��0 5
,
��5 6
string
��) /

claveNueva
��0 :
,
��: ;
int
��) ,
	idUsuario
��- 6
,
��6 7
string
��) /
nueva
��0 5
)
��5 6
{
�� 	
var
�� 
eventTrackingDto
��  
=
��! "
new
��# &#
paAddEventTrackingDto
��' <
{
�� $
CodigoHomologacionMenu
�� &
=
��' (
$str
��) 8
,
��8 9
NombreControl
�� 
=
�� 
$str
��  ,
,
��, -
NombreAccion
�� 
=
�� 
$str
�� 1
,
��1 2
ParametroJson
�� 
=
�� 
JsonConvert
��  +
.
��+ ,
SerializeObject
��, ;
(
��; <
new
��< ?
{
�� 
	IdUsuario
�� 
=
�� 
	idUsuario
��  )
,
��) *
Clave
�� 
=
�� 
clave
�� !
,
��! "

ClaveNueva
�� 
=
��  

claveNueva
��! +
}
�� 
)
�� 
}
�� 
;
�� 
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
��1 2
var
�� 
usuario
�� 
=
�� 
context
�� %
.
��% &
Usuario
��& -
.
��- .
AsNoTracking
��. :
(
��: ;
)
��; <
.
��< =
Where
��= B
(
��B C
(
��C D
c
��D E
)
��E F
=>
��G I
c
��J K
.
��K L
	IdUsuario
��L U
==
��V X
$num
��Y Z
)
��Z [
.
��[ \
FirstOrDefault
��\ j
(
��j k
)
��k l
;
��l m
if
�� 
(
�� 
usuario
�� 
==
�� 
null
�� #
)
��# $
{
�� &
_eventTrackingRepository
�� ,
.
��, -
Create
��- 3
(
��3 4
eventTrackingDto
��4 D
)
��D E
;
��E F
return
�� 
Result
�� !
<
��! "
bool
��" &
>
��& '
.
��' (
Failure
��( /
(
��/ 0
$str
��0 G
)
��G H
;
��H I
}
�� 
var
�� 
rol
�� 
=
�� 
context
�� !
.
��! "
VwRol
��" '
.
��' (
AsNoTracking
��( 4
(
��4 5
)
��5 6
.
��6 7
FirstOrDefault
��7 E
(
��E F
c
��F G
=>
��H J
c
��K L
.
��L M
IdHomologacionRol
��M ^
==
��_ a
usuario
��b i
.
��i j
IdHomologacionRol
��j {
)
��{ |
;
��| }
eventTrackingDto
��  
.
��  !#
CodigoHomologacionRol
��! 6
=
��7 8
rol
��9 <
.
��< = 
CodigoHomologacion
��= O
;
��O P
eventTrackingDto
��  
.
��  !
NombreUsuario
��! .
=
��/ 0
usuario
��1 8
.
��8 9
Nombre
��9 ?
;
��? @&
_eventTrackingRepository
�� (
.
��( )
Create
��) /
(
��/ 0
eventTrackingDto
��0 @
)
��@ A
;
��A B
if
�� 
(
�� 
usuario
�� 
.
�� 
Clave
�� !
!=
��" $
clave
��% *
)
��* +
{
�� 
return
�� 
Result
�� !
<
��! "
bool
��" &
>
��& '
.
��' (
Failure
��( /
(
��/ 0
$str
��0 B
)
��B C
;
��C D
}
�� 
usuario
�� 
.
�� 
Clave
�� 
=
�� 
nueva
��  %
;
��% &
context
�� 
.
�� 
Usuario
�� 
.
��  
Update
��  &
(
��& '
usuario
��' .
)
��. /
;
��/ 0
if
�� 
(
�� 
context
�� 
.
�� 
SaveChanges
�� '
(
��' (
)
��( )
>
��* +
$num
��, -
)
��- .
{
�� 
return
�� 
Result
�� !
<
��! "
bool
��" &
>
��& '
.
��' (
Success
��( /
(
��/ 0
true
��0 4
)
��4 5
;
��5 6
}
�� 
return
�� 
Result
�� 
<
�� 
bool
�� "
>
��" #
.
��# $
Failure
��$ +
(
��+ ,
$str
��, Y
)
��Y Z
;
��Z [
}
�� 
)
�� 
;
�� 
}
�� 	
}
�� 
}�� �
[C:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\UsuarioEndpointRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

class %
UsuarioEndpointRepository *
:+ ,
BaseRepository- ;
,; <&
IUsuarioEndpointRepository= W
{ 
public		 %
UsuarioEndpointRepository		 (
(		( )
ILogger


 
<

 %
UsuarioEndpointRepository

 +
>

+ ,
logger

- 3
,

3 4&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
UsuarioEndpoint 
? 
FindByEndpointId  0
(0 1
int1 4

endpointId5 ?
)? @
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
context1 8
.8 9
UsuarioEndpoint9 H
.H I
FirstOrDefaultI W
(W X
cX Y
=>Z \
c] ^
.^ _
IdUsuarioEndPoint_ p
==q s

endpointIdt ~
)~ 
)	 �
;
� �
} 	
public 
ICollection 
< 
UsuarioEndpoint *
>* +
FindAll, 3
(3 4
)4 5
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
context1 8
.8 9
UsuarioEndpoint9 H
.H I
OrderByI P
(P Q
cQ R
=>S U
cV W
.W X
IdUsuarioEndPointX i
)i j
.j k
ToListk q
(q r
)r s
)s t
;t u
} 	
public 
bool 
Create 
( 
UsuarioEndpoint *
usuarioEndpoint+ :
): ;
{ 	
usuarioEndpoint 
. 
IdUserModifica *
=+ ,
usuarioEndpoint- <
.< =
IdUserCreacion= K
;K L
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
context 
. 
UsuarioEndpoint '
.' (
Add( +
(+ ,
usuarioEndpoint, ;
); <
;< =
return 
context 
. 
SaveChanges *
(* +
)+ ,
>=- /
$num0 1
;1 2
} 
) 
; 
}   	
}!! 
}"" �
XC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\UsuarioEmailRepository.cs
	namespace		 	

DataAccess		
 
.		 
Repositories		 !
{

 
public 

class "
UsuarioEmailRepository '
(' (
IConfiguration( 6
configuration7 D
)D E
:F G#
IUsuarioEmailRepositoryH _
{ 
private 
readonly 
string 
_connectionString  1
=2 3
configuration4 A
.A B
GetConnectionStringB U
(U V
$strV c
)c d
;d e
public 
UserEmailDto 
ObtenerUsuario *
(* +
string+ 1
User2 6
)6 7
{ 	
try 
{ 
using 
( 
var 

connection %
=& '
new( +
SqlConnection, 9
(9 :
_connectionString: K
)K L
)L M
{ 

connection 
. 
Open #
(# $
)$ %
;% &
DynamicParameters %

parameters& 0
=1 2
new3 6
DynamicParameters7 H
(H I
)I J
;J K

parameters 
. 
Add "
(" #
$str# -
,- .
User/ 3
)3 4
;4 5
var 
result 
=  

connection! +
.+ ,

QueryFirst, 6
<6 7
UserEmailDto7 C
>C D
(D E
$strE X
,X Y

parametersZ d
,d e
commandTypef q
:q r
CommandTypes ~
.~ 
StoredProcedure	 �
)
� �
;
� �
return 
result !
;! "
} 
} 
catch   
{!! 
throw"" 
;"" 
}## 
}$$ 	
public&& 
List&& 
<&& 
UserEmailDto&&  
>&&  !
ObtenerUsuarios&&" 1
(&&1 2
int&&2 5
IdOna&&6 ;
)&&; <
{'' 	
try(( 
{)) 
using** 
(** 
var** 

connection** %
=**& '
new**( +
SqlConnection**, 9
(**9 :
_connectionString**: K
)**K L
)**L M
{++ 

connection,, 
.,, 
Open,, #
(,,# $
),,$ %
;,,% &
DynamicParameters.. %

parameters..& 0
=..1 2
new..3 6
DynamicParameters..7 H
(..H I
)..I J
;..J K

parameters// 
.// 
Add// "
(//" #
$str//# +
,//+ ,
IdOna//- 2
)//2 3
;//3 4
var11 
result11 
=11  

connection11! +
.11+ ,
Query11, 1
<111 2
UserEmailDto112 >
>11> ?
(11? @
$str11@ W
,11W X

parameters11Y c
,11c d
commandType11e p
:11p q
CommandType11r }
.11} ~
StoredProcedure	11~ �
)
11� �
;
11� �
return33 
result33 !
.33! "
ToList33" (
(33( )
)33) *
;33* +
}44 
}55 
catch66 
{77 
throw88 
;88 
}99 
}:: 	
};; 
}<< �S
UC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\ThesaurusRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

class 
ThesaurusRepository $
($ %
IConfiguration% 3
configuration4 A
)A B
:C D 
IThesaurusRepositoryE Y
{ 
private 
readonly 
string 
_connectionString! 2
=3 4
configuration5 B
.B C
GetConnectionStringC V
(V W
$strW d
)d e
;e f
private 
readonly 
string 
_rutaArchivo  ,
=- .
configuration/ <
[< =
$str= U
]U V
;V W
private 
readonly 
string 
_rutaArchivoDestino  3
=4 5
configuration6 C
[C D
$strD Y
]Y Z
;Z [
public 
	Thesaurus 
ObtenerThesaurus )
() *
)* +
{ 	
var 
rutaProyecto 
= 
	Directory (
.( )
GetCurrentDirectory) <
(< =
)= >
;> ?
string 
rutaArchivo 
=  
Path! %
.% &
Combine& -
(- .
rutaProyecto. :
,: ;
_rutaArchivo< H
)H I
;I J
if 
( 
! 
File 
. 
Exists 
( 
rutaArchivo (
)( )
)) *
{ 
return 
new 
	Thesaurus $
($ %
)% &
;& '
} 
try 
{ 
string   

xmlContent   !
=  " #
File  $ (
.  ( )
ReadAllText  ) 4
(  4 5
rutaArchivo  5 @
)  @ A
;  A B
string## 
pattern## 
=##  
$str##! B
;##B C
Match$$ 
match$$ 
=$$ 
Regex$$ #
.$$# $
Match$$$ )
($$) *

xmlContent$$* 4
,$$4 5
pattern$$6 =
,$$= >
RegexOptions$$? K
.$$K L

IgnoreCase$$L V
)$$V W
;$$W X
if&& 
(&& 
!&& 
match&& 
.&& 
Success&& "
)&&" #
{'' 
throw(( 
new(( 
	Exception(( '
(((' (
$str((( _
)((_ `
;((` a
})) 
string++ 
	xmlLimpio++  
=++! "
match++# (
.++( )
Value++) .
;++. /
XmlSerializer.. 

serializer.. (
=..) *
new..+ .
XmlSerializer../ <
(..< =
typeof..= C
(..C D
	Thesaurus..D M
)..M N
)..N O
;..O P
using// 
StringReader// "
reader//# )
=//* +
new//, /
StringReader//0 <
(//< =
	xmlLimpio//= F
)//F G
;//G H
var11 
archivo11 
=11 
(11 
	Thesaurus11 (
)11( )

serializer11) 3
.113 4
Deserialize114 ?
(11? @
reader11@ F
)11F G
;11G H
return44 
archivo44 
??44 !
new44" %
	Thesaurus44& /
(44/ 0
)440 1
;441 2
}77 
catch88 
(88 
	Exception88 
ex88 
)88  
{99 
throw:: 
new:: 
	Exception:: #
(::# $
$"::$ &
$str::& H
{::H I
ex::I K
.::K L
Message::L S
}::S T
"::T U
)::U V
;::V W
};; 
}<< 	
publicAA 
voidAA 
GuardarThesaurusAA $
(AA$ %
	ThesaurusAA% .
	thesaurusAA/ 8
)AA8 9
{BB 	
stringCC 
rutaArchivoCC 
=CC  
$strCC! #
;CC# $
tryDD 
{EE 
varFF 
rutaProyectoFF  
=FF! "
	DirectoryFF# ,
.FF, -
GetCurrentDirectoryFF- @
(FF@ A
)FFA B
;FFB C
rutaArchivoGG 
=GG 
PathGG "
.GG" #
CombineGG# *
(GG* +
rutaProyectoGG+ 7
,GG7 8
_rutaArchivoGG9 E
)GGE F
;GGF G
ifHH 
(HH 
!HH 
FileHH 
.HH 
ExistsHH  
(HH  !
rutaArchivoHH! ,
)HH, -
)HH- .
{II 
throwJJ 
newJJ 
	ExceptionJJ '
(JJ' (
$strJJ( C
)JJC D
;JJD E
}KK 
stringMM 

xmlContentMM !
=MM" #
FileMM$ (
.MM( )
ReadAllTextMM) 4
(MM4 5
rutaArchivoMM5 @
)MM@ A
;MMA B
XmlSerializerNN 

serializerNN (
=NN) *
newNN+ .
XmlSerializerNN/ <
(NN< =
typeofNN= C
(NNC D
	ThesaurusNND M
)NNM N
)NNN O
;NNO P#
XmlSerializerNamespacesPP '

namespacesPP( 2
=PP3 4
newPP5 8#
XmlSerializerNamespacesPP9 P
(PPP Q
)PPQ R
;PPR S

namespacesQQ 
.QQ 
AddQQ 
(QQ 
$strQQ !
,QQ! "
$strQQ# :
)QQ: ;
;QQ; <
usingSS 
StringWriterSS "
writerSS# )
=SS* +
newSS, /
StringWriterSS0 <
(SS< =
)SS= >
;SS> ?
usingTT 
	XmlWriterTT 
	xmlWriterTT  )
=TT* +
	XmlWriterTT, 5
.TT5 6
CreateTT6 <
(TT< =
writerTT= C
,TTC D
newTTE H
XmlWriterSettingsTTI Z
{TT[ \
OmitXmlDeclarationTT] o
=TTp q
trueTTr v
,TTv w
IndentTTx ~
=	TT �
true
TT� �
}
TT� �
)
TT� �
;
TT� �

serializerVV 
.VV 
	SerializeVV $
(VV$ %
	xmlWriterVV% .
,VV. /
	thesaurusVV0 9
,VV9 :

namespacesVV; E
)VVE F
;VVF G
stringWW 
nuevoThesaurusXMLWW (
=WW) *
writerWW+ 1
.WW1 2
ToStringWW2 :
(WW: ;
)WW; <
;WW< =
stringYY 
patternYY 
=YY  
$strYY! B
;YYB C
if[[ 
([[ 
![[ 
Regex[[ 
.[[ 
IsMatch[[ "
([[" #

xmlContent[[# -
,[[- .
pattern[[/ 6
)[[6 7
)[[7 8
{\\ 
throw]] 
new]] 
	Exception]] '
(]]' (
$str]]( _
)]]_ `
;]]` a
}^^ 
string`` 
nuevoXML`` 
=``  !
Regex``" '
.``' (
Replace``( /
(``/ 0

xmlContent``0 :
,``: ;
pattern``< C
,``C D
nuevoThesaurusXML``E V
)``V W
;``W X
Filebb 
.bb 
WriteAllTextbb !
(bb! "
rutaArchivobb" -
,bb- .
nuevoXMLbb/ 7
)bb7 8
;bb8 9
}cc 
catchdd 
(dd 
	Exceptiondd 
exdd 
)dd  
{ee 
throwff 
newff 
	Exceptionff #
(ff# $
$"ff$ &
$strff& G
{ffG H
exffH J
.ffJ K
MessageffK R
}ffR S
$strffS Y
"ffY Z
+ffZ [
rutaArchivoff\ g
)ffg h
;ffh i
}gg 
}hh 	
publicmm 
voidmm 
EjecutarArchivoBatmm &
(mm& '
)mm' (
{mm) *
tryoo 
{pp 
varqq 
rutaProyectoqq  
=qq! "
	Directoryqq# ,
.qq, -
GetCurrentDirectoryqq- @
(qq@ A
)qqA B
;qqB C
stringrr 
rutaArchivorr "
=rr# $
Pathrr% )
.rr) *
Combinerr* 1
(rr1 2
rutaProyectorr2 >
,rr> ?
_rutaArchivorr@ L
)rrL M
;rrM N
stringss 
rutaArchiDestinoss '
=ss( )
_rutaArchivoDestinoss* =
;ss= >
Filevv 
.vv 
Copyvv 
(vv 
rutaArchivovv %
,vv% &
rutaArchiDestinovv' 7
,vv7 8
truevv9 =
)vv= >
;vv> ?
ResetSQLServerww 
(ww 
)ww  
;ww  !
}zz 
catch{{ 
({{ 
	Exception{{ 
ex{{ 
){{  
{|| 
Console}} 
.}} 
	WriteLine}} !
(}}! "
$"}}" $
$str}}$ F
{}}F G
ex}}G I
.}}I J
Message}}J Q
}}}Q R
"}}R S
)}}S T
;}}T U
}~~ 
} 	
public
�� 
string
�� 
ResetSQLServer
�� $
(
��$ %
)
��% &
{
�� 	
try
�� 
{
�� 
using
�� 
(
�� 
var
�� 

connection
�� %
=
��& '
new
��( +
SqlConnection
��, 9
(
��9 :
_connectionString
��: K
)
��K L
)
��L M
{
�� 

connection
�� 
.
�� 
Open
�� #
(
��# $
)
��$ %
;
��% &
var
�� 
result
�� 
=
��  

connection
��! +
.
��+ ,
Execute
��, 3
(
��3 4
$str
�� 6
,
��6 7
commandType
�� #
:
��# $
CommandType
��% 0
.
��0 1
StoredProcedure
��1 @
)
�� 
;
�� 
return
�� 
$str
�� 
;
��  
}
�� 
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
return
�� 
$"
�� 
$str
�� H
{
��H I
ex
��I K
.
��K L
Message
��L S
}
��S T
"
��T U
;
��U V
}
�� 
}
�� 	
}
�� 
}�� �Y
SC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\ReporteRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

class 
ReporteRepository "
:# $
BaseRepository% 3
,3 4
IReporteRepository5 G
{		 
public

 
ReporteRepository

  
(

  !
ILogger
 
< 
ReporteRepository #
># $
logger% +
,+ ,&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
VwHomologacion 
findByVista )
() *
string* 0
codigoHomologacion1 C
)C D
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
context 
. 
VwHomologacion $
. 
AsNoTracking 
( 
) 
. 
Where 
( 
c 
=> 
c 
. 
CodigoHomologacion 0
==1 3
codigoHomologacion4 F
)F G
. 
FirstOrDefault 
(  
)  !
)! "
;" #
} 	
public 
List 
< 
VwAcreditacionOna %
>% &$
ObtenerVwAcreditacionOna' ?
(? @
)@ A
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
context 
. 
VwAcreditacionOna )
.   
AsNoTracking   !
(  ! "
)  " #
.!! 
ToList!! 
(!! 
)!! 
)!! 
;!! 
}"" 	
public$$ 
List$$ 
<$$ !
VwAcreditacionEsquema$$ )
>$$) *(
ObtenerVwAcreditacionEsquema$$+ G
($$G H
)$$H I
{%% 	
return&& 
ExecuteDbOperation&& %
(&&% &
context&&& -
=>&&. 0
context'' 
.'' !
VwAcreditacionEsquema'' -
.(( 
AsNoTracking(( !
(((! "
)((" #
.)) 
ToList)) 
()) 
))) 
))) 
;)) 
}** 	
public,, 
List,, 
<,, 
VwEstadoEsquema,, #
>,,# $"
ObtenerVwEstadoEsquema,,% ;
(,,; <
),,< =
{-- 	
return.. 
ExecuteDbOperation.. %
(..% &
context..& -
=>... 0
context// 
.// 
VwEstadoEsquema// '
.00 
AsNoTracking00 !
(00! "
)00" #
.11 
ToList11 
(11 
)11 
)11 
;11 
}22 	
public44 
List44 
<44 
	VwOecPais44 
>44 
ObtenerVwOecPais44 /
(44/ 0
)440 1
{55 	
return66 
ExecuteDbOperation66 %
(66% &
context66& -
=>66. 0
context77 
.77 
	VwOecPais77 !
.88 
AsNoTracking88 !
(88! "
)88" #
.99 
ToList99 
(99 
)99 
)99 
;99 
}:: 	
public<< 
List<< 
<<< 
VwEsquemaPais<< !
><<! " 
ObtenerVwEsquemaPais<<# 7
(<<7 8
)<<8 9
{== 	
return>> 
ExecuteDbOperation>> %
(>>% &
context>>& -
=>>>. 0
context?? 
.?? 
VwEsquemaPais?? %
.@@ 
AsNoTracking@@ !
(@@! "
)@@" #
.AA 
ToListAA 
(AA 
)AA 
)AA 
;AA 
}BB 	
publicDD 
ListDD 
<DD 

VwOecFechaDD 
>DD 
ObtenerVwOecFechaDD  1
(DD1 2
)DD2 3
{EE 	
returnFF 
ExecuteDbOperationFF %
(FF% &
contextFF& -
=>FF. 0
contextGG 
.GG 

VwOecFechaGG "
.HH 
AsNoTrackingHH !
(HH! "
)HH" #
.II 
ToListII 
(II 
)II 
)II 
;II 
}JJ 	
publicMM 
ListMM 
<MM #
VwProfesionalCalificadoMM +
>MM+ ,*
ObtenerVwProfesionalCalificadoMM- K
(MMK L
)MML M
{NN 	
returnOO 
ExecuteDbOperationOO %
(OO% &
contextOO& -
=>OO. 0
contextPP 
.PP #
VwProfesionalCalificadoPP /
.QQ 
AsNoTrackingQQ !
(QQ! "
)QQ" #
.RR 
ToListRR 
(RR 
)RR 
)RR 
;RR 
}SS 	
publicTT 
ListTT 
<TT 
VwProfesionalOnaTT $
>TT$ %#
ObtenerVwProfesionalOnaTT& =
(TT= >
)TT> ?
{UU 	
returnVV 
ExecuteDbOperationVV %
(VV% &
contextVV& -
=>VV. 0
contextWW 
.WW 
VwProfesionalOnaWW (
.XX 
AsNoTrackingXX !
(XX! "
)XX" #
.YY 
ToListYY 
(YY 
)YY 
)YY 
;YY 
}ZZ 	
public[[ 
List[[ 
<[[  
VwProfesionalEsquema[[ (
>[[( )'
ObtenerVwProfesionalEsquema[[* E
([[E F
)[[F G
{\\ 	
return]] 
ExecuteDbOperation]] %
(]]% &
context]]& -
=>]]. 0
context^^ 
.^^  
VwProfesionalEsquema^^ ,
.__ 
AsNoTracking__ !
(__! "
)__" #
.`` 
ToList`` 
(`` 
)`` 
)`` 
;`` 
}aa 	
publicbb 
Listbb 
<bb 
VwProfesionalFechabb &
>bb& '%
ObtenerVwProfesionalFechabb( A
(bbA B
)bbB C
{cc 	
returndd 
ExecuteDbOperationdd %
(dd% &
contextdd& -
=>dd. 0
contextee 
.ee 
VwProfesionalFechaee *
.ff 
AsNoTrackingff !
(ff! "
)ff" #
.gg 
ToListgg 
(gg 
)gg 
)gg 
;gg 
}hh 	
publicii 
Listii 
<ii 
VwCalificaUbicacionii '
>ii' (&
ObtenerVwCalificaUbicacionii) C
(iiC D
)iiD E
{jj 	
returnkk 
ExecuteDbOperationkk %
(kk% &
contextkk& -
=>kk. 0
contextll 
.ll 
VwCalificaUbicacionll +
.mm 
AsNoTrackingmm !
(mm! "
)mm" #
.nn 
ToListnn 
(nn 
)nn 
)nn 
;nn 
}oo 	
publicrr 
Listrr 
<rr 
VwBusquedaFecharr #
>rr# $"
ObtenerVwBusquedaFecharr% ;
(rr; <
)rr< =
{ss 	
returntt 
ExecuteDbOperationtt %
(tt% &
contexttt& -
=>tt. 0
contextuu 
.uu 
VwBusquedaFechauu '
.vv 
AsNoTrackingvv !
(vv! "
)vv" #
.ww 
ToListww 
(ww 
)ww 
)ww 
;ww 
}xx 	
publicyy 
Listyy 
<yy 
VwBusquedaFiltroyy $
>yy$ %#
ObtenerVwBusquedaFiltroyy& =
(yy= >
)yy> ?
{zz 	
return{{ 
ExecuteDbOperation{{ %
({{% &
context{{& -
=>{{. 0
context|| 
.|| 
VwBusquedaFiltro|| (
.}} 
AsNoTracking}} !
(}}! "
)}}" #
.~~ 
ToList~~ 
(~~ 
)~~ 
)~~ 
;~~ 
} 	
public
�� 
List
�� 
<
�� !
VwBusquedaUbicacion
�� '
>
��' ((
ObtenerVwBusquedaUbicacion
��) C
(
��C D
)
��D E
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� !
VwBusquedaUbicacion
�� +
.
�� 
AsNoTracking
�� !
(
��! "
)
��" #
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
��  
VwActualizacionONA
�� &
>
��& ''
ObtenerVwActualizacionONA
��( A
(
��A B
)
��B C
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
��  
VwActualizacionONA
�� *
.
�� 
AsNoTracking
�� !
(
��! "
)
��" #
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� #
VwOrganismoRegistrado
�� )
>
��) **
ObtenerVwOrganismoRegistrado
��+ G
(
��G H
)
��H I
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� #
VwOrganismoRegistrado
�� -
.
�� 
AsNoTracking
�� !
(
��! "
)
��" #
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� #
VwOrganizacionEsquema
�� )
>
��) **
ObtenerVwOrganizacionEsquema
��+ G
(
��G H
)
��H I
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� #
VwOrganizacionEsquema
�� -
.
�� 
AsNoTracking
�� !
(
��! "
)
��" #
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� "
VwOrganismoActividad
�� (
>
��( ))
ObtenerVwOrganismoActividad
��* E
(
��E F
)
��F G
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� "
VwOrganismoActividad
�� ,
.
�� 
AsNoTracking
�� !
(
��! "
)
��" #
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
}
�� 
}�� �
^C:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\paActualizarFiltroRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public		 

class		 (
paActualizarFiltroRepository		 -
:		. /)
IpaActualizarFiltroRepository		0 M
{

 
private 
readonly 
string 
_connectionString  1
;1 2
public (
paActualizarFiltroRepository +
(+ ,
IConfiguration, :
configuration; H
)H I
{ 	
_connectionString 
= 
configuration  -
.- .
GetConnectionString. A
(A B
$strB O
)O P
;P Q
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
_connectionString* ;
); <
)< =
{ 
throw 
new %
InvalidOperationException 3
(3 4
$str4 n
)n o
;o p
} 
} 	
public 
async 
Task 
< 
bool 
> !
ActualizarFiltroAsync  5
(5 6
)6 7
{ 	
try 
{ 
using 
( 
var 

connection %
=& '
new( +
SqlConnection, 9
(9 :
_connectionString: K
)K L
)L M
{ 
await 

connection $
.$ %
	OpenAsync% .
(. /
)/ 0
;0 1
var 
result 
=  
await! &

connection' 1
.1 2
ExecuteAsync2 >
(> ?
$str 3
,3 4
commandType   #
:  # $
CommandType  % 0
.  0 1
StoredProcedure  1 @
)!! 
;!! 
return$$ 
result$$ !
>$$" #
$num$$$ %
;$$% &
}%% 
}&& 
catch'' 
('' 
	Exception'' 
ex'' 
)''  
{(( 
Console)) 
.)) 
	WriteLine)) !
())! "
$"))" $
$str))$ S
{))S T
ex))T V
.))V W
Message))W ^
}))^ _
"))_ `
)))` a
;))a b
return** 
false** 
;** 
}++ 
},, 	
}-- 
}.. �9
OC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\ONARepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{		 
public

 

class

 
ONARepository

 
:

  
BaseRepository

! /
,

/ 0
IONARepository

1 ?
{ 
public 
ONARepository 
( 
ILogger
 
< 
ONARepository 
>  
logger! '
,' (&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
bool 
Create 
( 
ONA 
data #
)# $
{ 	
data 
. 
IdUserModifica 
=  !
data" &
.& '
IdUserCreacion' 5
;5 6
data 
. 
InfoExtraJson 
=  
$str! %
;% &
data 
. 
Estado 
= 

Constantes $
.$ %
ESTADO_USUARIO_A% 5
;5 6
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
context 
. 
ONA 
. 
Add 
(  
data  $
)$ %
;% &
return 
context 
. 
SaveChanges *
(* +
)+ ,
>=- /
$num0 1
;1 2
} 
) 
; 
} 	
public 
ONA 
? 
FindById 
( 
int  
id! #
)# $
{   	
return!! 
ExecuteDbOperation!! %
(!!% &
context!!& -
=>!!. 0
context!!1 8
.!!8 9
ONA!!9 <
.!!< =
AsNoTracking!!= I
(!!I J
)!!J K
.!!K L
FirstOrDefault!!L Z
(!!Z [
u!![ \
=>!!] _
u!!` a
.!!a b
IdONA!!b g
==!!h j
id!!k m
)!!m n
)!!n o
;!!o p
}"" 	
public## 
async## 
Task## 
<## 
ONA## 
?## 
>## 
FindByIdAsync##  -
(##- .
int##. 1
id##2 4
)##4 5
{$$ 	
return%% 
await%% 
ExecuteDbOperation%% +
(%%+ ,
async%%, 1
context%%2 9
=>%%: <
await&& 
context&& 
.&& 
ONA&& !
.&&! "
AsNoTracking&&" .
(&&. /
)&&/ 0
.&&0 1
FirstOrDefaultAsync&&1 D
(&&D E
u&&E F
=>&&G I
u&&J K
.&&K L
IdONA&&L Q
==&&R T
id&&U W
)&&W X
)'' 
;'' 
}(( 	
public** 
ONA** 
?** 
FindBySiglas**  
(**  !
string**! '
siglas**( .
)**. /
{++ 	
return,, 
ExecuteDbOperation,, %
(,,% &
context,,& -
=>,,. 0
context,,1 8
.,,8 9
ONA,,9 <
.,,< =
AsNoTracking,,= I
(,,I J
),,J K
.,,K L
FirstOrDefault,,L Z
(,,Z [
u,,[ \
=>,,] _
u,,` a
.,,a b
Siglas,,b h
.,,h i
Equals,,i o
(,,o p
siglas,,p v
),,v w
),,w x
),,x y
;,,y z
}-- 	
public.. 
List.. 
<.. 
ONA.. 
>.. 
FindAll..  
(..  !
)..! "
{// 	
return00 
ExecuteDbOperation00 %
(00% &
context00& -
=>00. 0
context001 8
.008 9
ONA009 <
.00< =
AsNoTracking00= I
(00I J
)00J K
.00K L
Where00L Q
(00Q R
c00R S
=>00T V
c00W X
.00X Y
Estado00Y _
.00_ `
Equals00` f
(00f g

Constantes00g q
.00q r
ESTADO_USUARIO_A	00r �
)
00� �
)
00� �
.
00� �
ToList
00� �
(
00� �
)
00� �
)
00� �
;
00� �
}11 	
public22 
List22 
<22 
ONA22 
>22 
GetListByONAsAsync22 +
(22+ ,
int22, /
idOna220 5
)225 6
{33 	
return44 
ExecuteDbOperation44 %
(44% &
context44& -
=>44. 0
context55 
.55 
ONA55 
.66 
AsNoTracking66 !
(66! "
)66" #
.77 
Where77 
(77 
c77 
=>77 
c77  !
.77! "
IdONA77" '
==77( *
idOna77+ 0
&&771 3
c774 5
.775 6
Estado776 <
==77= ?

Constantes77@ J
.77J K
ESTADO_USUARIO_A77K [
)77[ \
.88 
ToList88 
(88 
)88 
)99 
;99 
}:: 	
public<< 
List<< 
<<< 
VwPais<< 
><< 
FindAllPaises<< )
(<<) *
)<<* +
{== 	
return>> 
ExecuteDbOperation>> %
(>>% &
context>>& -
=>>>. 0
context>>1 8
.>>8 9
VwPais>>9 ?
.>>? @
AsNoTracking>>@ L
(>>L M
)>>M N
.>>N O
ToList>>O U
(>>U V
)>>V W
)>>W X
;>>X Y
}?? 	
public@@ 
bool@@ 
Update@@ 
(@@ 
ONA@@ 
	newRecord@@ (
,@@( )
int@@* -
	userToken@@. 7
)@@7 8
{AA 	
returnBB 
ExecuteDbOperationBB %
(BB% &
contextBB& -
=>BB. 0
{CC 
varDD 
_exitsDD 
=DD !
MergeEntityPropertiesDD 2
(DD2 3
contextDD3 :
,DD: ;
	newRecordDD< E
,DDE F
uDDG H
=>DDI K
uDDL M
.DDM N
IdONADDN S
==DDT V
	newRecordDDW `
.DD` a
IdONADDa f
)DDf g
;DDg h
_exitsFF 
.FF 
FechaModificaFF $
=FF% &
DateTimeFF' /
.FF/ 0
NowFF0 3
;FF3 4
_exitsGG 
.GG 
IdUserModificaGG %
=GG& '
	userTokenGG( 1
;GG1 2
contextII 
.II 
ONAII 
.II 
UpdateII "
(II" #
_exitsII# )
)II) *
;II* +
returnJJ 
contextJJ 
.JJ 
SaveChangesJJ *
(JJ* +
)JJ+ ,
>=JJ- /
$numJJ0 1
;JJ1 2
}KK 
)KK 
;KK 
}LL 	
}NN 
}OO �
VC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\OnaMigrateRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{		 
public

 

class

  
OnaMigrateRepository

 %
:

& '
BaseRepository

( 6
,

6 7!
IOnaMigrateRepository

8 M
{ 
public  
OnaMigrateRepository #
(# $
ILogger
 
<  
OnaMigrateRepository &
>& '
logger( .
,. /&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
}
 
public 
List 
< 
OnaMigrateDto !
>! "
postOnaMigrate# 1
(1 2
int2 5
idOna6 ;
,; <
int= @
	idEsquemaA J
,J K
stringL R
jsonParameterS `
)` a
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
try 
{ 
string   
sql   
=    
$"  ! #
$str  # ]
"  ] ^
;  ^ _
return!! 
context!! "
.!!" #

onaMigrate!!# -
."" 

FromSqlRaw"" 
(""  
sql""  #
,""# $
new## 
SqlParameter## +
(##+ ,
$str##, 4
,##4 5
idOna##6 ;
)##; <
,##< =
new$$ 
SqlParameter$$ +
($$+ ,
$str$$, 8
,$$8 9
	idEsquema$$: C
)$$C D
,$$D E
new%% 
SqlParameter%% +
(%%+ ,
$str%%, <
,%%< =
jsonParameter%%> K
)%%K L
)%%L M
.&& 
ToList&& 
(&& 
)&&  
;&&  !
}'' 
catch(( 
((( 
	Exception((  
ex((! #
)((# $
{)) 
_logger** 
.** 
LogError** $
(**$ %
ex**% '
,**' (
$str**) O
)**O P
;**P Q
return++ 
[++ 
]++ 
;++ 
},, 
}-- 
)-- 
;-- 
}.. 	
}// 
}00 �3
WC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\ONAConexionRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{		 
public

 

class

 !
ONAConexionRepository

 &
:

' (
BaseRepository

) 7
,

7 8"
IONAConexionRepository

9 O
{ 
public !
ONAConexionRepository $
($ %
ILogger
 
< !
ONAConexionRepository '
>' (
logger) /
,/ 0&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
bool 
Create 
( 
ONAConexion &
data' +
)+ ,
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
context 
. 
ONAConexion #
.# $
Add$ '
(' (
data( ,
), -
;- .
return 
context 
. 
SaveChanges *
(* +
)+ ,
>=- /
$num0 1
;1 2
} 
) 
; 
} 	
public 
ONAConexion 
? 
FindById $
($ %
int% (
id) +
)+ ,
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
context1 8
.8 9
ONAConexion9 D
.D E
AsNoTrackingE Q
(Q R
)R S
.S T
FirstOrDefaultT b
(b c
uc d
=>e g
uh i
.i j
IdONAj o
==p r
ids u
)u v
)v w
;w x
} 	
public 
ONAConexion 
? 
FindByIdONA '
(' (
int( +
IdONA, 1
)1 2
{   	
return!! 
ExecuteDbOperation!! %
(!!% &
context!!& -
=>!!. 0
context!!1 8
.!!8 9
ONAConexion!!9 D
.!!D E
AsNoTracking!!E Q
(!!Q R
)!!R S
.!!S T
FirstOrDefault!!T b
(!!b c
u!!c d
=>!!e g
u!!h i
.!!i j
IdONA!!j o
==!!p r
IdONA!!s x
)!!x y
)!!y z
;!!z {
}"" 	
public## 
async## 
Task## 
<## 
ONAConexion## %
?##% &
>##& '
FindByIdONAAsync##( 8
(##8 9
int##9 <
IdONA##= B
)##B C
{$$ 	
return%% 
await%% 
ExecuteDbOperation%% +
(%%+ ,
async%%, 1
context%%2 9
=>%%: <
await&& 
context&& 
.&& 
ONAConexion&& )
.&&) *
AsNoTracking&&* 6
(&&6 7
)&&7 8
.&&8 9
FirstOrDefaultAsync&&9 L
(&&L M
u&&M N
=>&&O Q
u&&R S
.&&S T
IdONA&&T Y
==&&Z \
IdONA&&] b
)&&b c
)'' 
;'' 
}(( 	
public** 
List** 
<** 
ONAConexion** 
>**  
FindAll**! (
(**( )
)**) *
{++ 	
return,, 
ExecuteDbOperation,, %
(,,% &
context,,& -
=>,,. 0
context,,1 8
.,,8 9
ONAConexion,,9 D
.,,D E
AsNoTracking,,E Q
(,,Q R
),,R S
.,,S T
Where,,T Y
(,,Y Z
c,,Z [
=>,,\ ^
c,,_ `
.,,` a
Estado,,a g
.,,g h
Equals,,h n
(,,n o

Constantes,,o y
.,,y z
ESTADO_USUARIO_A	,,z �
)
,,� �
)
,,� �
.
,,� �
ToList
,,� �
(
,,� �
)
,,� �
)
,,� �
;
,,� �
}-- 	
public.. 
List.. 
<.. 
ONAConexion.. 
>..  (
GetOnaConexionByOnaListAsync..! =
(..= >
int..> A
idOna..B G
)..G H
{// 	
return00 
ExecuteDbOperation00 %
(00% &
context00& -
=>00. 0
context11 
.11 
ONAConexion11 #
.22 
AsNoTracking22 !
(22! "
)22" #
.33 
Where33 
(33 
c33 
=>33 
c33  !
.33! "
IdONA33" '
==33( *
idOna33+ 0
&&331 3
c334 5
.335 6
Estado336 <
==33= ?

Constantes33@ J
.33J K
ESTADO_USUARIO_A33K [
)33[ \
.44 
ToList44 
(44 
)44 
)55 
;55 
}66 	
public88 
bool88 
Update88 
(88 
ONAConexion88 &
	newRecord88' 0
,880 1
int882 5
	userToken886 ?
)88? @
{99 	
return:: 
ExecuteDbOperation:: %
(::% &
context::& -
=>::. 0
{;; 
var<< 
_exits<< 
=<< !
MergeEntityProperties<< 2
(<<2 3
context<<3 :
,<<: ;
	newRecord<<< E
,<<E F
u<<G H
=><<I K
u<<L M
.<<M N
IdONA<<N S
==<<T V
	newRecord<<W `
.<<` a
IdONA<<a f
)<<f g
;<<g h
_exits>> 
.>> 
FechaModifica>> $
=>>% &
DateTime>>' /
.>>/ 0
Now>>0 3
;>>3 4
_exits?? 
.?? 
IdUserModifica?? %
=??& '
	userToken??( 1
;??1 2
contextAA 
.AA 
ONAConexionAA #
.AA# $
UpdateAA$ *
(AA* +
_exitsAA+ 1
)AA1 2
;AA2 3
returnBB 
contextBB 
.BB 
SaveChangesBB *
(BB* +
)BB+ ,
>=BB- /
$numBB0 1
;BB1 2
}CC 
)CC 
;CC 
}DD 	
}GG 
}HH �1
ZC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\MigracionExcelRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public		 
class			 $
MigracionExcelRepository		 '
:		( )
BaseRepository		* 8
,		8 9%
IMigracionExcelRepository		: S
{

 
public 
$
MigracionExcelRepository #
(# $
ILogger 
< $
MigracionExcelRepository &
>& '
logger( .
,. /&
ISqlServerDbContextFactory  %
sqlServerDbContextFactory! :
) 
: 
base 
( %
sqlServerDbContextFactory &
,& '
logger( .
). /
{ 
} 
public 
LogMigracion 
Create "
(" #
LogMigracion# /
data0 4
)4 5
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{1 2
context 
. 
LogMigracion $
.$ %
Add% (
(( )
data) -
)- .
;. /
context   
.   
SaveChanges   #
(  # $
)  $ %
;  % &
return!! 
data!! 
;!! 
}"" 
)"" 
;"" 
}## 	
public$$ 
async$$ 
Task$$ 
<$$ 
LogMigracion$$ &
>$$& '
CreateAsync$$( 3
($$3 4
LogMigracion$$4 @
data$$A E
)$$E F
{%% 	
try&& 
{'' 
return(( 
await(( 
ExecuteDbOperation(( /
(((/ 0
async((0 5
context((6 =
=>((> @
{)) 
context** 
.** 
LogMigracion** (
.**( )
Add**) ,
(**, -
data**- 1
)**1 2
;**2 3
await++ 
context++ !
.++! "
SaveChangesAsync++" 2
(++2 3
)++3 4
;++4 5
return,, 
data,, 
;,,  
}-- 
)-- 
;-- 
}.. 
catch// 
(// 
	Exception// 
ex// 
)//  
{00 
throw22 
;22 
}33 
}55 	
public77 
MigracionExcel77 
?77 
FindById77 '
(77' (
int77( +
id77, .
)77. /
{88 
return99 
ExecuteDbOperation99 
(99  
context99  '
=>99( *
context99+ 2
.992 3
MigracionExcel993 A
.99A B
AsNoTracking99B N
(99N O
)99O P
.99P Q
FirstOrDefault99Q _
(99_ `
u99` a
=>99b d
u99e f
.99f g
IdMigracionExcel99g w
==99x z
id99{ }
)99} ~
)99~ 
;	99 �
}:: 
public;; 

List;; 
<;; 
MigracionExcel;; 
>;; 
FindAll;;  '
(;;' (
);;( )
{<< 
return== 
ExecuteDbOperation== 
(==  
context==  '
=>==( *
context==+ 2
.==2 3
MigracionExcel==3 A
.==A B
AsNoTracking==B N
(==N O
)==O P
.==P Q
OrderByDescending==Q b
(==b c
c==c d
=>==e g
c==h i
.==i j
FechaCreacion==j w
)==w x
.==x y
ToList==y 
(	== �
)
==� �
)
==� �
;
==� �
}>> 
publicHH 
boolHH 
UpdateHH 
(HH 
LogMigracionHH $
	newRecordHH% .
)HH. /
{II 
returnJJ 
ExecuteDbOperationJJ %
(JJ% &
contextJJ& -
=>JJ. 0
{KK 
varLL 
_exitsLL 
=LL !
MergeEntityPropertiesLL 2
(LL2 3
contextLL3 :
,LL: ;
	newRecordLL< E
,LLE F
uLLG H
=>LLI K
uLLL M
.LLM N
IdLogMigracionLLN \
==LL] _
	newRecordLL` i
.LLi j
IdLogMigracionLLj x
)LLx y
;LLy z
contextNN 
.NN 
LogMigracionNN $
.NN$ %
UpdateNN% +
(NN+ ,
_exitsNN, 2
)NN2 3
;NN3 4
returnOO 
contextOO 
.OO 
SaveChangesOO *
(OO* +
)OO+ ,
>=OO- /
$numOO0 1
;OO1 2
}PP 
)PP 
;PP 
}RR 
publicSS 
asyncSS 
TaskSS 
<SS 
boolSS 
>SS 
UpdateAsyncSS  +
(SS+ ,
LogMigracionSS, 8
	newRecordSS9 B
)SSB C
{TT 	
returnUU 
awaitUU 
ExecuteDbOperationUU +
(UU+ ,
asyncUU, 1
contextUU2 9
=>UU: <
{VV 
varXX 
existingRecordXX "
=XX# $!
MergeEntityPropertiesXX% :
(XX: ;
contextXX; B
,XXB C
	newRecordXXD M
,XXM N
uXXO P
=>XXQ S
uXXT U
.XXU V
IdLogMigracionXXV d
==XXe g
	newRecordXXh q
.XXq r
IdLogMigracion	XXr �
)
XX� �
;
XX� �
ifZZ 
(ZZ 
existingRecordZZ "
==ZZ# %
nullZZ& *
)ZZ* +
{[[ 
return]] 
false]]  
;]]  !
}^^ 
contextaa 
.aa 
LogMigracionaa $
.aa$ %
Updateaa% +
(aa+ ,
existingRecordaa, :
)aa: ;
;aa; <
vardd 
rowsAffecteddd  
=dd! "
awaitdd# (
contextdd) 0
.dd0 1
SaveChangesAsyncdd1 A
(ddA B
)ddB C
;ddC D
returnee 
rowsAffectedee #
>ee$ %
$numee& '
;ee' (
}ff 
)ff 
;ff 
}gg 	
}ii 
}jj �k
PC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\MenuRepository.cs
	namespace		 	

DataAccess		
 
.		 
Repositories		 !
{

 
public 

class 
MenuRepository 
:  !
BaseRepository" 0
,0 1
IMenuRepository2 A
{ 
public 
MenuRepository 
( 
ILogger
 
< 
MenuRepository  
>  !
logger" (
,( )&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
bool 
Create 
( 
MenuRol "
data# '
)' (
{ 	
data 
. 
Estado 
= 

Constantes $
.$ %
ESTADO_USUARIO_A% 5
;5 6
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
context 
. 
MenuRol 
.  
Add  #
(# $
data$ (
)( )
;) *
return 
context 
. 
SaveChanges *
(* +
)+ ,
>=- /
$num0 1
;1 2
} 
) 
; 
} 	
public!! 
Menus!! 
?!! 
FindDataById!! "
(!!" #
int!!# &
idHRol!!' -
,!!- .
int!!/ 2
idHMenu!!3 :
)!!: ;
{"" 	
return## 
ExecuteDbOperation## %
(##% &
context##& -
=>##. 0
($$ 
from$$ 
mr$$ 
in$$ 
context$$ #
.$$# $
MenuRol$$$ +
.$$+ ,
AsNoTracking$$, 8
($$8 9
)$$9 :
join%% 
hm%% 
in%% 
context%% #
.%%# $
Homologacion%%$ 0
.%%0 1
AsNoTracking%%1 =
(%%= >
)%%> ?
on%%@ B
mr%%C E
.%%E F
IdHMenu%%F M
equals%%N T
hm%%U W
.%%W X
IdHomologacion%%X f
join&& 
hr&& 
in&& 
context&& #
.&&# $
Homologacion&&$ 0
.&&0 1
AsNoTracking&&1 =
(&&= >
)&&> ?
on&&@ B
mr&&C E
.&&E F
IdHRol&&F L
equals&&M S
hr&&T V
.&&V W
IdHomologacion&&W e
where'' 
mr'' 
.'' 
IdHRol''  
==''! #
idHRol''$ *
&&''+ -
mr''. 0
.''0 1
IdHMenu''1 8
==''9 ;
idHMenu''< C
&&''D F
hm''G I
.''I J
Estado''J P
==''Q S

Constantes''T ^
.''^ _
ESTADO_USUARIO_A''_ o
&&''p r
hr''s u
.''u v
Estado''v |
==''} 

Constantes
''� �
.
''� �
ESTADO_USUARIO_A
''� �
select(( 
new(( 
Menus(( !
{)) 
	IdMenuRol** 
=**  
mr**! #
.**# $
	IdMenuRol**$ -
,**- .
IdHRol++ 
=++ 
mr++  
.++  !
IdHRol++! '
,++' (
Rol,, 
=,, 
hr,, 
.,, 

MostrarWeb,, (
,,,( )
IdHMenu-- 
=-- 
mr-- !
.--! "
IdHMenu--" )
,--) *
Menu.. 
=.. 
hm.. 
... 

MostrarWeb.. )
,..) *
Estado// 
=// 
mr//  
.//  !
Estado//! '
,//' (
FechaCreacion00 "
=00# $
mr00% '
.00' (
FechaCreacion00( 5
}11 
)11 
.11 
FirstOrDefault11 "
(11" #
)11# $
)22 
;22 
}33 	
public44 
MenuRol44 
?44 
FindById44  
(44  !
int44! $
idHRol44% +
,44+ ,
int44- 0
idHMenu441 8
)448 9
{55 	
return66 
ExecuteDbOperation66 %
(66% &
context66& -
=>66. 0
(77 
from77 
mr77 
in77 
context77 #
.77# $
MenuRol77$ +
.77+ ,
AsNoTracking77, 8
(778 9
)779 :
join88 
hm88 
in88 
context88 #
.88# $
Homologacion88$ 0
.880 1
AsNoTracking881 =
(88= >
)88> ?
on88@ B
mr88C E
.88E F
IdHMenu88F M
equals88N T
hm88U W
.88W X
IdHomologacion88X f
join99 
hr99 
in99 
context99 #
.99# $
Homologacion99$ 0
.990 1
AsNoTracking991 =
(99= >
)99> ?
on99@ B
mr99C E
.99E F
IdHRol99F L
equals99M S
hr99T V
.99V W
IdHomologacion99W e
where:: 
mr:: 
.:: 
IdHRol::  
==::! #
idHRol::$ *
&&::+ -
mr::. 0
.::0 1
IdHMenu::1 8
==::9 ;
idHMenu::< C
&&::D F
hm::G I
.::I J
Estado::J P
==::Q S

Constantes::T ^
.::^ _
ESTADO_USUARIO_A::_ o
&&::p r
hr::s u
.::u v
Estado::v |
==::} 

Constantes
::� �
.
::� �
ESTADO_USUARIO_A
::� �
select;; 
new;; 
MenuRol;; #
{<< 
	IdMenuRol== 
===  
mr==! #
.==# $
	IdMenuRol==$ -
,==- .
IdHRol>> 
=>> 
mr>>  
.>>  !
IdHRol>>! '
,>>' (
IdHMenu?? 
=?? 
mr?? !
.??! "
IdHMenu??" )
,??) *
Estado@@ 
=@@ 
mr@@  
.@@  !
Estado@@! '
,@@' (
FechaCreacionAA "
=AA# $
mrAA% '
.AA' (
FechaCreacionAA( 5
}BB 
)BB 
.BB 
FirstOrDefaultBB "
(BB" #
)BB# $
)CC 
;CC 
}DD 	
publicFF 
ListFF 
<FF 
MenusFF 
>FF 
FindAllFF "
(FF" #
)FF# $
{GG 	
returnHH 
ExecuteDbOperationHH %
(HH% &
contextHH& -
=>HH. 0
(II 
fromII 
mrII 
inII 
contextII #
.II# $
MenuRolII$ +
.II+ ,
AsNoTrackingII, 8
(II8 9
)II9 :
joinJJ 
hmJJ 
inJJ 
contextJJ #
.JJ# $
HomologacionJJ$ 0
.JJ0 1
AsNoTrackingJJ1 =
(JJ= >
)JJ> ?
onJJ@ B
mrJJC E
.JJE F
IdHMenuJJF M
equalsJJN T
hmJJU W
.JJW X
IdHomologacionJJX f
joinKK 
hrKK 
inKK 
contextKK #
.KK# $
HomologacionKK$ 0
.KK0 1
AsNoTrackingKK1 =
(KK= >
)KK> ?
onKK@ B
mrKKC E
.KKE F
IdHRolKKF L
equalsKKM S
hrKKT V
.KKV W
IdHomologacionKKW e
whereLL 
hmLL 
.LL 
EstadoLL  
==LL! #

ConstantesLL$ .
.LL. /
ESTADO_USUARIO_ALL/ ?
&&LL@ B
hrLLC E
.LLE F
EstadoLLF L
==LLM O

ConstantesLLP Z
.LLZ [
ESTADO_USUARIO_ALL[ k
selectMM 
newMM 
MenusMM !
{NN 
	IdMenuRolOO 
=OO  
mrOO! #
.OO# $
	IdMenuRolOO$ -
,OO- .
IdHRolPP 
=PP 
mrPP  
.PP  !
IdHRolPP! '
,PP' (
RolQQ 
=QQ 
hrQQ 
.QQ 

MostrarWebQQ (
,QQ( )
IdHMenuRR 
=RR 
mrRR !
.RR! "
IdHMenuRR" )
,RR) *
MenuSS 
=SS 
hmSS 
.SS 

MostrarWebSS )
,SS) *
EstadoTT 
=TT 
mrTT  
.TT  !
EstadoTT! '
,TT' (
FechaCreacionUU "
=UU# $
mrUU% '
.UU' (
FechaCreacionUU( 5
,UU5 6
}VV 
)VV 
.VV 
ToListVV 
(VV 
)VV 
)WW 
;WW 
}XX 	
publicZZ 
ListZZ 
<ZZ 
MenusZZ 
>ZZ 
GetListByMenusAsyncZZ .
(ZZ. /
intZZ/ 2
idHRolZZ3 9
,ZZ9 :
intZZ; >
idHMenuZZ? F
)ZZF G
{[[ 	
return\\ 
ExecuteDbOperation\\ %
(\\% &
context\\& -
=>\\. 0
context]] 
.]] 
Menus]] 
.^^ 
AsNoTracking^^ !
(^^! "
)^^" #
.__ 
Where__ 
(__ 
c__ 
=>__ 
c__  !
.__! "
IdHRol__" (
==__) +
idHRol__, 2
&&__3 5
c__6 7
.__7 8
Estado__8 >
==__? A

Constantes__B L
.__L M
ESTADO_USUARIO_A__M ]
)__] ^
.`` 
ToList`` 
(`` 
)`` 
)aa 
;aa 
}bb 	
publicee 
boolee 
Updateee 
(ee 
MenuRolee "
	newRecordee# ,
)ee, -
{ff 	
returngg 
ExecuteDbOperationgg %
(gg% &
contextgg& -
=>gg. 0
{hh 
varii 
_exitsii 
=ii !
MergeEntityPropertiesii 2
(ii2 3
contextii3 :
,ii: ;
	newRecordii< E
,iiE F
uiiG H
=>iiI K
uiiL M
.iiM N
	IdMenuRoliiN W
==iiX Z
	newRecordii[ d
.iid e
	IdMenuRoliie n
)iin o
;iio p
_exitskk 
.kk 
FechaCreacionkk $
=kk% &
DateTimekk' /
.kk/ 0
Nowkk0 3
;kk3 4
contextmm 
.mm 
MenuRolmm 
.mm  
Updatemm  &
(mm& '
_exitsmm' -
)mm- .
;mm. /
returnnn 
contextnn 
.nn 
SaveChangesnn *
(nn* +
)nn+ ,
>=nn- /
$numnn0 1
;nn1 2
}oo 
)oo 
;oo 
}pp 	
publicqq 
Listqq 
<qq 

MenuPaginaqq 
>qq %
ObtenerMenusPendingConfigqq  9
(qq9 :
intqq: =
idHomologacionRolqq> O
)qqO P
{rr 	
returnss 
ExecuteDbOperationss %
(ss% &
contextss& -
=>ss. 0
{tt 
varuu 
homologacionesuu "
=uu# $
contextuu% ,
.uu, -
Homologacionuu- 9
.vv 
Wherevv 
(vv 
hvv 
=>vv 
hvv  !
.vv! "
IdHomologacionGrupovv" 5
==vv6 8
$numvv9 :
&&vv; =
hvv> ?
.vv? @
Estadovv@ F
==vvG I

ConstantesvvJ T
.vvT U
ESTADO_USUARIO_AvvU e
)vve f
.ww 
Selectww 
(ww 
hww 
=>ww  
hww! "
.ww" #
IdHomologacionww# 1
)ww1 2
;ww2 3
varyy 
menusExcluidosyy "
=yy# $
contextyy% ,
.yy, -
MenuRolyy- 4
.zz 
Wherezz 
(zz 
mrzz 
=>zz  
mrzz! #
.zz# $
IdHRolzz$ *
==zz+ -
idHomologacionRolzz. ?
)zz? @
.{{ 
Select{{ 
({{ 
mr{{ 
=>{{ !
mr{{" $
.{{$ %
IdHMenu{{% ,
){{, -
;{{- .
var}} 
	resultado}} 
=}} 
context}}  '
.}}' (
Homologacion}}( 4
.~~ 
Where~~ 
(~~ 
h~~ 
=>~~ 
homologaciones~~  .
.~~. /
Contains~~/ 7
(~~7 8
h~~8 9
.~~9 :
IdHomologacion~~: H
)~~H I
&&~~J L
!~~M N
menusExcluidos~~N \
.~~\ ]
Contains~~] e
(~~e f
h~~f g
.~~g h
IdHomologacion~~h v
)~~v w
)~~w x
. 
Select 
( 
h 
=>  
new! $

MenuPagina% /
{
�� 
IdHomologacion
�� &
=
��' (
h
��) *
.
��* +
IdHomologacion
��+ 9
,
��9 :

MostrarWeb
�� "
=
��# $
h
��% &
.
��& '

MostrarWeb
��' 1
}
�� 
)
�� 
.
�� 
ToList
�� 
(
�� 
)
�� 
;
�� 
return
�� 
	resultado
��  
;
��  !
}
�� 
)
�� 
;
�� 
}
�� 	
}
�� 
}�� �N
XC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\LogMigracionRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public		 

class		 "
LogMigracionRepository		 '
:		( )
BaseRepository		* 8
,		8 9#
ILogMigracionRepository		: Q
{

 
public "
LogMigracionRepository %
(% &
ILogger
 
< "
LogMigracionRepository (
>( )
logger* 0
,0 1&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
LogMigracion 
Create "
(" #
LogMigracion# /
data0 4
)4 5
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
context 
. 
LogMigracion $
.$ %
Add% (
(( )
data) -
)- .
;. /
context 
. 
SaveChanges #
(# $
)$ %
;% &
return 
data 
; 
} 
) 
; 
} 	
public 
async 
Task 
< 
LogMigracion &
>& '
CreateAsync( 3
(3 4
LogMigracion4 @
dataA E
)E F
{ 	
return 
await 
ExecuteDbOperation +
(+ ,
async, 1
context2 9
=>: <
{ 
context 
. 
LogMigracion $
.$ %
Add% (
(( )
data) -
)- .
;. /
await 
context 
. 
SaveChangesAsync .
(. /
)/ 0
;0 1
return   
data   
;   
}!! 
)!! 
;!! 
}"" 	
public$$ 
LogMigracion$$ 
?$$ 
FindById$$ %
($$% &
int$$& )
id$$* ,
)$$, -
{%% 	
return&& 
ExecuteDbOperation&& %
(&&% &
context&&& -
=>&&. 0
context&&1 8
.&&8 9
LogMigracion&&9 E
.&&E F
AsNoTracking&&F R
(&&R S
)&&S T
.&&T U
FirstOrDefault&&U c
(&&c d
u&&d e
=>&&f h
u&&i j
.&&j k
IdLogMigracion&&k y
==&&z |
id&&} 
)	&& �
)
&&� �
;
&&� �
}'' 	
public(( 
List(( 
<(( 
LogMigracion((  
>((  !
FindAll((" )
((() *
)((* +
{)) 	
return** 
ExecuteDbOperation** %
(**% &
context**& -
=>**. 0
context**1 8
.**8 9
LogMigracion**9 E
.**E F
AsNoTracking**F R
(**R S
)**S T
.**T U
OrderByDescending**U f
(**f g
c**g h
=>**i k
c**l m
.**m n
Fecha**n s
)**s t
.**t u
ToList**u {
(**{ |
)**| }
)**} ~
;**~ 
}++ 	
public,, 
bool,, 
Update,, 
(,, 
LogMigracion,, '
	newRecord,,( 1
),,1 2
{-- 	
return.. 
ExecuteDbOperation.. %
(..% &
context..& -
=>... 0
{// 
var00 
_exits00 
=00 !
MergeEntityProperties00 2
(002 3
context003 :
,00: ;
	newRecord00< E
,00E F
u00G H
=>00I K
u00L M
.00M N
IdLogMigracion00N \
==00] _
	newRecord00` i
.00i j
IdLogMigracion00j x
)00x y
;00y z
context22 
.22 
LogMigracion22 $
.22$ %
Update22% +
(22+ ,
_exits22, 2
)222 3
;223 4
return33 
context33 
.33 
SaveChanges33 *
(33* +
)33+ ,
>=33- /
$num330 1
;331 2
}44 
)44 
;44 
}55 	
public66 
async66 
Task66 
<66 
bool66 
>66 
UpdateAsync66  +
(66+ ,
LogMigracion66, 8
	newRecord669 B
)66B C
{77 	
return88 
await88 
ExecuteDbOperation88 +
(88+ ,
async88, 1
context882 9
=>88: <
{99 
var;; 
existingRecord;; "
=;;# $!
MergeEntityProperties;;% :
(;;: ;
context;;; B
,;;B C
	newRecord;;D M
,;;M N
u;;O P
=>;;Q S
u;;T U
.;;U V
IdLogMigracion;;V d
==;;e g
	newRecord;;h q
.;;q r
IdLogMigracion	;;r �
)
;;� �
;
;;� �
if== 
(== 
existingRecord== "
====# %
null==& *
)==* +
{>> 
return@@ 
false@@  
;@@  !
}AA 
contextDD 
.DD 
LogMigracionDD $
.DD$ %
UpdateDD% +
(DD+ ,
existingRecordDD, :
)DD: ;
;DD; <
varGG 
rowsAffectedGG  
=GG! "
awaitGG# (
contextGG) 0
.GG0 1
SaveChangesAsyncGG1 A
(GGA B
)GGB C
;GGC D
returnHH 
rowsAffectedHH #
>HH$ %
$numHH& '
;HH' (
}II 
)II 
;II 
}JJ 	
publicLL 
LogMigracionDetalleLL "
CreateDetalleLL# 0
(LL0 1
LogMigracionDetalleLL1 D
dataLLE I
)LLI J
{MM 	
returnNN 
ExecuteDbOperationNN %
(NN% &
contextNN& -
=>NN. 0
{OO 
contextPP 
.PP 
LogMigracionDetallePP +
.PP+ ,
AddPP, /
(PP/ 0
dataPP0 4
)PP4 5
;PP5 6
contextQQ 
.QQ 
SaveChangesQQ #
(QQ# $
)QQ$ %
;QQ% &
returnRR 
dataRR 
;RR 
}SS 
)SS 
;SS 
}TT 	
publicUU 
asyncUU 
TaskUU 
<UU 
LogMigracionDetalleUU -
>UU- .
CreateDetalleAsyncUU/ A
(UUA B
LogMigracionDetalleUUB U
dataUUV Z
)UUZ [
{VV 	
returnWW 
awaitWW 
ExecuteDbOperationWW +
(WW+ ,
asyncWW, 1
contextWW2 9
=>WW: <
{XX 
contextYY 
.YY 
LogMigracionDetalleYY +
.YY+ ,
AddYY, /
(YY/ 0
dataYY0 4
)YY4 5
;YY5 6
awaitZZ 
contextZZ 
.ZZ 
SaveChangesAsyncZZ .
(ZZ. /
)ZZ/ 0
;ZZ0 1
return[[ 
data[[ 
;[[ 
}\\ 
)\\ 
;\\ 
}]] 	
public__ 
List__ 
<__ 
LogMigracionDetalle__ '
>__' (
FindAllDetalle__) 7
(__7 8
)__8 9
{`` 	
returnaa 
ExecuteDbOperationaa %
(aa% &
contextaa& -
=>aa. 0
contextaa1 8
.aa8 9
LogMigracionDetalleaa9 L
.aaL M
AsNoTrackingaaM Y
(aaY Z
)aaZ [
.aa[ \
OrderByDescendingaa\ m
(aam n
caan o
=>aap r
caas t
.aat u
Fechaaau z
)aaz {
.aa{ |
ToList	aa| �
(
aa� �
)
aa� �
)
aa� �
;
aa� �
}bb 	
publiccc 
Listcc 
<cc 
LogMigracionDetallecc '
>cc' (
FindDetalleByIdcc) 8
(cc8 9
intcc9 <
idcc= ?
)cc? @
{dd 	
returnee 
ExecuteDbOperationee %
(ee% &
contextee& -
=>ee. 0
contextee1 8
.ee8 9
LogMigracionDetalleee9 L
.eeL M
AsNoTrackingeeM Y
(eeY Z
)eeZ [
.ee[ \
Whereee\ a
(eea b
ueeb c
=>eed f
ueeg h
.eeh i
IdLogMigracioneei w
==eex z
idee{ }
)ee} ~
.ee~ 
ToList	ee �
(
ee� �
)
ee� �
)
ee� �
;
ee� �
}ff 	
publicgg 
boolgg 
UpdateDetallegg !
(gg! "
LogMigracionDetallegg" 5
	newRecordgg6 ?
)gg? @
{hh 	
returnii 
ExecuteDbOperationii %
(ii% &
contextii& -
=>ii. 0
{jj 
varkk 
_exitskk 
=kk !
MergeEntityPropertieskk 2
(kk2 3
contextkk3 :
,kk: ;
	newRecordkk< E
,kkE F
ukkG H
=>kkI K
ukkL M
.kkM N!
IdLogMigracionDetallekkN c
==kkd f
	newRecordkkg p
.kkp q"
IdLogMigracionDetalle	kkq �
)
kk� �
;
kk� �
contextmm 
.mm 
LogMigracionDetallemm +
.mm+ ,
Updatemm, 2
(mm2 3
_exitsmm3 9
)mm9 :
;mm: ;
returnnn 
contextnn 
.nn 
SaveChangesnn *
(nn* +
)nn+ ,
>=nn- /
$numnn0 1
;nn1 2
}oo 
)oo 
;oo 
}pp 	
}qq 
}rr �[
TC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\ImportarRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public		 

class		 
ImportarRepository		 #
:		$ %
IImportarRepository		& 9
{

 
private 
string 
connectionString '
=( )
$str* ,
;, -
private 
readonly 
string 

idEnteName  *
=+ ,
$str- =
;= >
private 
readonly 
int 
executionIndex +
=, -
$num. /
;/ 0
private 
readonly 
int 
[ 
] 
heids $
=% &
[' (
]( )
;) *
private 
readonly 
string 
[  
]  !
vids" &
=' (
[) *
]* +
;+ ,
private 
bool 
deleted 
= 
false $
;$ %
public 
ImportarRepository !
(! "
IConfiguration" 0
configuration1 >
)> ?
{ 	
connectionString 
= 
configuration ,
., -
GetConnectionString- @
(@ A
$strA N
)N O
;O P
} 	
public 
string  
buildSelectViewQuery *
(* +
int+ .
[. /
]/ 0
homologacionIds1 @
,@ A
stringB H
[H I
]I J
selectFieldsK W
,W X
stringY _
viewName` h
)h i
{ 	
using 
SqlConnection 

connection  *
=+ ,
new- 0
SqlConnection1 >
(> ?
connectionString? O
)O P
;P Q
if 
( 
! 

viewExists 
( 

connection &
,& '
viewName( 0
)0 1
)1 2
{ 
Console 
. 
	WriteLine !
(! "
$"" $
$str$ *
{* +
viewName+ 3
}3 4
$str4 >
"> ?
)? @
;@ A
return 
$str 
; 
} 
List!! 
<!! 
int!! 
>!! 
newHomologacionIds!! (
=!!) *
new!!+ .
List!!/ 3
<!!3 4
int!!4 7
>!!7 8
(!!8 9
)!!9 :
;!!: ;
List"" 
<"" 
string"" 
>"" 
newSelectFields"" (
="") *
new""+ .
List""/ 3
<""3 4
string""4 :
>"": ;
(""; <
)""< =
;""= >
foreach$$ 
($$ 
string$$ 
field$$ !
in$$" $
selectFields$$% 1
)$$1 2
{%% 
if&& 
(&& 
fieldExists&& 
(&&  

connection&&  *
,&&* +
viewName&&, 4
,&&4 5
field&&6 ;
)&&; <
)&&< =
{'' 
int(( 
homologacionId(( &
=((' (
homologacionIds(() 8
[((8 9
Array((9 >
.((> ?
IndexOf((? F
(((F G
selectFields((G S
,((S T
field((U Z
)((Z [
](([ \
;((\ ]
newHomologacionIds)) &
.))& '
Add))' *
())* +
homologacionId))+ 9
)))9 :
;)): ;
newSelectFields** #
.**# $
Add**$ '
(**' (
field**( -
)**- .
;**. /
}++ 
else,, 
{-- 
Console.. 
... 
	WriteLine.. %
(..% &
$"..& (
$str..( .
{... /
field../ 4
}..4 5
$str..5 M
{..M N
viewName..N V
}..V W
"..W X
)..X Y
;..Y Z
continue// 
;// 
}00 
}11 
string22 
newSelectFieldsStr22 %
=22& '
string22( .
.22. /
Join22/ 3
(223 4
$str224 8
,228 9
newSelectFields22: I
)22I J
;22J K
if44 
(44 
fieldExists44 
(44 

connection44 &
,44& '
viewName44( 0
,440 1

idEnteName442 <
)44< =
)44= >
{55 
newSelectFieldsStr66 "
+=66# %
$"66& (
$str66( *
{66* +

idEnteName66+ 5
}665 6
"666 7
;667 8
}77 
else88 
{99 
Console:: 
.:: 
	WriteLine:: !
(::! "
$"::" $
$str::$ *
{::* +

idEnteName::+ 5
}::5 6
$str::6 N
{::N O
viewName::O W
}::W X
"::X Y
)::Y Z
;::Z [
};; 
if<< 
(<< 
fieldExists<< 
(<< 

connection<< &
,<<& '
viewName<<( 0
,<<0 1
vids<<2 6
[<<6 7
executionIndex<<7 E
]<<E F
)<<F G
)<<G H
{== 
newSelectFieldsStr>> "
+=>># %
$str>>& *
+>>+ ,
vids>>- 1
[>>1 2
executionIndex>>2 @
]>>@ A
;>>A B
}?? 
else@@ 
{AA 
ConsoleBB 
.BB 
	WriteLineBB !
(BB! "
$strBB" *
+BB+ ,
vidsBB- 1
[BB1 2
executionIndexBB2 @
]BB@ A
+BBB C
$strBBD ^
+BB_ `
viewNameBBa i
)BBi j
;BBj k
}CC 
returnEE 
$"EE 
$strEE 
{EE 
newSelectFieldsStrEE /
}EE/ 0
$strEE0 6
{EE6 7
viewNameEE7 ?
}EE? @
"EE@ A
;EEA B
}FF 	
privateHH 
staticHH 
boolHH 

viewExistsHH &
(HH& '
SqlConnectionHH' 4

connectionHH5 ?
,HH? @
stringHHA G
viewNameHHH P
)HHP Q
{II 	
throwJJ 
newJJ #
NotImplementedExceptionJJ -
(JJ- .
)JJ. /
;JJ/ 0
}KK 	
privateMM 
staticMM 
boolMM 
fieldExistsMM '
(MM' (
SqlConnectionMM( 5

connectionMM6 @
,MM@ A
stringMMB H
viewNameMMI Q
,MMQ R
stringMMS Y
	fieldNameMMZ c
)MMc d
{NN 	
stringPP 
queryPP 
=PP 
$"PP 
$strPP d
{PPd e
viewNamePPe m
}PPm n
$str	PPn �
{
PP� �
	fieldName
PP� �
}
PP� �
$str
PP� �
"
PP� �
;
PP� �

SqlCommandQQ 
commandQQ 
=QQ  
newQQ! $

SqlCommandQQ% /
(QQ/ 0
queryQQ0 5
,QQ5 6

connectionQQ7 A
)QQA B
;QQB C
SqlDataAdapterRR 
adapterRR "
=RR# $
newRR% (
SqlDataAdapterRR) 7
(RR7 8
commandRR8 ?
)RR? @
;RR@ A
DataSetSS 
dataSetSS 
=SS 
newSS !
DataSetSS" )
(SS) *
)SS* +
;SS+ ,
adapterTT 
.TT 
FillTT 
(TT 
dataSetTT  
)TT  !
;TT! "
returnUU 
dataSetUU 
.UU 
TablesUU !
.UU! "
CountUU" '
>UU( )
$numUU* +
&&UU, .
dataSetUU/ 6
.UU6 7
TablesUU7 =
[UU= >
$numUU> ?
]UU? @
.UU@ A
RowsUUA E
.UUE F
CountUUF K
>UUL M
$numUUN O
;UUO P
}VV 	
privateWW 
boolWW 
deleteOldRecordsWW %
(WW% &
intWW& )!
IdHomologacionEsquemaWW* ?
)WW? @
{XX 	
ifYY 
(YY 
deletedYY 
)YY 
{ZZ 
return[[ 
true[[ 
;[[ 
}\\ 
deleted^^ 
=^^ 
true^^ 
;^^ 
return__ 
false__ 
;__ 
}`` 	
publicgg 
boolgg 
executeQueryViewgg $
(gg$ %
stringgg% +
selectQuerygg, 7
)gg7 8
{hh 	
usingii 
SqlConnectionii 

connectionii  *
=ii+ ,
newii- 0
SqlConnectionii1 >
(ii> ?
connectionStringii? O
)iiO P
;iiP Q
tryjj 
{kk 

SqlCommandll 
commandll "
=ll# $
newll% (

SqlCommandll) 3
(ll3 4
selectQueryll4 ?
,ll? @

connectionllA K
)llK L
;llL M
SqlDataAdaptermm 
adaptermm &
=mm' (
newmm) ,
SqlDataAdaptermm- ;
(mm; <
commandmm< C
)mmC D
;mmD E
DataSetnn 
dataSetnn 
=nn  !
newnn" %
DataSetnn& -
(nn- .
)nn. /
;nn/ 0

connectionoo 
.oo 
Openoo 
(oo  
)oo  !
;oo! "
adapterpp 
.pp 
Fillpp 
(pp 
dataSetpp $
)pp$ %
;pp% &
ifqq 
(qq 
dataSetqq 
.qq 
Tablesqq "
.qq" #
Countqq# (
<qq) *
$numqq+ ,
||qq- /
dataSetqq0 7
.qq7 8
Tablesqq8 >
[qq> ?
$numqq? @
]qq@ A
.qqA B
RowsqqB F
.qqF G
CountqqG L
<qqM N
$numqqO P
)qqP Q
{rr 
Consoless 
.ss 
	WriteLiness %
(ss% &
$strss& 7
)ss7 8
;ss8 9
returntt 
falsett  
;tt  !
}uu  
DataColumnCollectionvv $
columnsvv% ,
=vv- .
dataSetvv/ 6
.vv6 7
Tablesvv7 =
[vv= >
$numvv> ?
]vv? @
.vv@ A
ColumnsvvA H
;vvH I
foreachxx 
(xx 
DataRowxx  
rowxx! $
inxx% '
dataSetxx( /
.xx/ 0
Tablesxx0 6
[xx6 7
$numxx7 8
]xx8 9
.xx9 :
Rowsxx: >
)xx> ?
{yy 
deleteOldRecordszz $
(zz$ %
heidszz% *
[zz* +
executionIndexzz+ 9
]zz9 :
)zz: ;
;zz; <
}{{ 
return|| 
true|| 
;|| 
}}} 
catch~~ 
(~~ 
	Exception~~ 
ex~~ 
)~~  
{ 
Console
�� 
.
�� 
	WriteLine
�� !
(
��! "
ex
��" $
.
��$ %
Message
��% ,
)
��, -
;
��- .
return
�� 
false
�� 
;
�� 
}
�� 
finally
�� 
{
�� 

connection
�� 
.
�� 
Close
��  
(
��  !
)
��! "
;
��" #
}
�� 
}
�� 	
}
�� 
}�� �A
XC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\HomologacionRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{		 
public

 

class

 "
HomologacionRepository

 '
:

( )
BaseRepository

* 8
,

8 9#
IHomologacionRepository

: Q
{ 
public "
HomologacionRepository %
(% &
ILogger
 
< "
HomologacionRepository (
>( )
logger* 0
,0 1&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
bool 
Create 
( 
Homologacion '
data( ,
), -
{ 	
data 
. 
IdUserModifica 
=  !
data" &
.& '
IdUserCreacion' 5
;5 6
data 
. 
Estado 
= 

Constantes $
.$ %
ESTADO_USUARIO_A% 5
;5 6
data 
. 
Mostrar 
= 

Constantes %
.% &
ESTADO_USUARIO_S& 6
;6 7
data 
. 
Indexar 
= 
data 
.  
Indexar  '
==( *
null+ /
?0 1

Constantes2 <
.< =

INDEXAR_NO= G
:H I
dataJ N
.N O
IndexarO V
.V W
ToStringW _
(_ `
)` a
;a b
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
context 
. 
Homologacion $
.$ %
Add% (
(( )
data) -
)- .
;. /
return 
context 
. 
SaveChanges *
(* +
)+ ,
>=- /
$num0 1
;1 2
} 
) 
; 
} 	
public 
Homologacion 
? 
FindById %
(% &
int& )
id* ,
), -
{ 	
return   
ExecuteDbOperation   %
(  % &
context  & -
=>  . 0
context  1 8
.  8 9
Homologacion  9 E
.  E F
AsNoTracking  F R
(  R S
)  S T
.  T U
FirstOrDefault  U c
(  c d
u  d e
=>  f h
u  i j
.  j k
IdHomologacion  k y
==  z |
id  } 
)	   �
)
  � �
;
  � �
}!! 	
public"" 
ICollection"" 
<"" 
Homologacion"" '
>""' (
FindByParent"") 5
(""5 6
)""6 7
{## 	
return$$ 
ExecuteDbOperation$$ %
($$% &
context$$& -
=>$$. 0
{%% 
var'' 
parentId'' 
='' 
context'' &
.''& '
Homologacion''' 3
.(( 
Where(( 
((( 
h(( 
=>(( 
h((  !
.((! "
CodigoHomologacion((" 4
==((5 7
$str((8 I
)((I J
.)) 
Select)) 
()) 
h)) 
=>))  
h))! "
.))" #
IdHomologacion))# 1
)))1 2
.** 
FirstOrDefault** #
(**# $
)**$ %
;**% &
return-- 
context-- 
.-- 
Homologacion-- +
... 
Where.. 
(.. 
h.. 
=>.. 
h..  !
...! "
IdHomologacionGrupo.." 5
==..6 8
parentId..9 A
&&..B D
h..E F
...F G
Estado..G M
==..N P

Constantes..Q [
...[ \
ESTADO_USUARIO_A..\ l
)..l m
.// 
OrderBy// 
(// 
h// 
=>// !
h//" #
.//# $
MostrarWebOrden//$ 3
)//3 4
.00 
AsNoTracking00 !
(00! "
)00" #
.11 
ToList11 
(11 
)11 
;11 
}22 
)22 
;22 
}33 	
public44 
List44 
<44 
Homologacion44  
>44  !
	FindByIds44" +
(44+ ,
int44, /
[44/ 0
]440 1
ids442 5
)445 6
{55 	
return66 
ExecuteDbOperation66 %
(66% &
context66& -
=>66. 0
context661 8
.668 9
Homologacion669 E
.66E F
Where66F K
(66K L
c66L M
=>66N P
ids66Q T
.66T U
Contains66U ]
(66] ^
c66^ _
.66_ `
IdHomologacion66` n
)66n o
)66o p
.66p q
OrderBy66q x
(66x y
c66y z
=>66{ }
c66~ 
.	66 �
MostrarWebOrden
66� �
)
66� �
.
66� �
ToList
66� �
(
66� �
)
66� �
)
66� �
;
66� �
}77 	
public88 
bool88 
Update88 
(88 
Homologacion88 '
	newRecord88( 1
)881 2
{99 	
return:: 
ExecuteDbOperation:: %
(::% &
context::& -
=>::. 0
{;; 
var<< 
_exits<< 
=<< !
MergeEntityProperties<< 2
(<<2 3
context<<3 :
,<<: ;
	newRecord<<< E
,<<E F
u<<G H
=><<I K
u<<L M
.<<M N
IdHomologacion<<N \
==<<] _
	newRecord<<` i
.<<i j
IdHomologacion<<j x
)<<x y
;<<y z
_exits>> 
.>> 
FechaModifica>> $
=>>% &
DateTime>>' /
.>>/ 0
Now>>0 3
;>>3 4
context?? 
.?? 
Homologacion?? $
.??$ %
Update??% +
(??+ ,
_exits??, 2
)??2 3
;??3 4
return@@ 
context@@ 
.@@ 
SaveChanges@@ *
(@@* +
)@@+ ,
>=@@- /
$num@@0 1
;@@1 2
}AA 
)AA 
;AA 
}BB 	
publicDD 
ListDD 
<DD 
VwHomologacionDD "
>DD" #*
ObtenerVwHomologacionPorCodigoDD$ B
(DDB C
stringDDC I
codigoHomologacionDDJ \
)DD\ ]
{EE 	
returnFF 
ExecuteDbOperationFF %
(FF% &
contextFF& -
=>FF. 0
contextGG 
.GG 
VwHomologacionGG $
.HH 
AsNoTrackingHH 
(HH 
)HH 
.II 
WhereII 
(II 
cII 
=>II 
cII 
.II !
CodigoHomologacionKEYII 3
==II4 6
codigoHomologacionII7 I
)III J
.JJ 
OrderByJJ 
(JJ 
cJJ 
=>JJ 
cJJ 
.JJ  

MostrarWebJJ  *
)JJ* +
.KK 
ToListKK 
(KK 
)KK 
)KK 
;KK 
}LL 	
publicNN 
ListNN 
<NN 
HomologacionNN  
>NN  !
	FindByAllNN" +
(NN+ ,
)NN, -
{OO 	
returnPP 
ExecuteDbOperationPP %
(PP% &
contextPP& -
=>PP. 0
contextPP1 8
.PP8 9
HomologacionPP9 E
.PPE F
WherePPF K
(PPK L
cPPL M
=>PPN P
cPPQ R
.PPR S
EstadoPPS Y
==PPZ \

ConstantesPP] g
.PPg h
ESTADO_USUARIO_APPh x
)PPx y
.PPy z
ToList	PPz �
(
PP� �
)
PP� �
)
PP� �
;
PP� �
}QQ 	
}RR 
}SS �s
YC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\EventTrackingRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

class #
EventTrackingRepository (
:) *
BaseRepository+ 9
,9 :$
IEventTrackingRepository; S
{ 
public #
EventTrackingRepository &
(& '
ILogger
 
< #
EventTrackingRepository )
>) *
logger+ 1
,1 2&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
bool 
Create 
( !
paAddEventTrackingDto 0
data1 5
)5 6
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
try 
{ 
return 
context "
." #
Database# +
.+ ,
SqlQueryRaw, 7
<7 8
bool8 <
>< =
(= >
$str	 �
,
� �
new 
SqlParameter (
(( )
$str) A
,A B
dataC G
.G H!
CodigoHomologacionRolH ]
)] ^
,^ _
new   
SqlParameter   (
(  ( )
$str  ) 9
,  9 :
data  ; ?
.  ? @
NombreUsuario  @ M
)  M N
,  N O
new!! 
SqlParameter!! (
(!!( )
$str!!) B
,!!B C
data!!D H
.!!H I"
CodigoHomologacionMenu!!I _
)!!_ `
,!!` a
new"" 
SqlParameter"" (
(""( )
$str"") 9
,""9 :
data""; ?
.""? @
NombreControl""@ M
)""M N
,""N O
new## 
SqlParameter## (
(##( )
$str##) 8
,##8 9
data##: >
.##> ?
NombreAccion##? K
)##K L
,##L M
new$$ 
SqlParameter$$ (
($$( )
$str$$) 9
,$$9 :
data$$; ?
.$$? @
UbicacionJson$$@ M
)$$M N
,$$N O
new%% 
SqlParameter%% (
(%%( )
$str%%) 9
,%%9 :
data%%; ?
.%%? @
ParametroJson%%@ M
)%%M N
)&& 
.&& 
AsEnumerable&& "
(&&" #
)&&# $
.&&$ %
FirstOrDefault&&% 3
(&&3 4
)&&4 5
;&&5 6
}'' 
catch(( 
((( 
	Exception((  
ex((! #
)((# $
{)) 
_logger** 
.** 
LogError** $
(**$ %
ex**% '
,**' (
$str**) ^
)**^ _
;**_ `
return++ 
false++  
;++  !
},, 
}-- 
)-- 
;-- 
}.. 	
public00 
string00 
GetCodeByUser00 #
(00# $
string00$ *
nombreUsuario00+ 8
,008 9
string00: @!
codigoHomologacionRol00A V
,00V W
string00X ^"
codigoHomologacionMenu00_ u
)00u v
{11 	
try22 
{33 
return44 
ExecuteDbOperation44 )
(44) *
context44* 1
=>442 4
{55 
var66 
result66 
=66  
context66! (
.66( )
EventTracking66) 6
.666 7
AsNoTracking667 C
(66C D
)66D E
.77 
Where77 
(77 
u77  
=>77! #
u77$ %
.77% &
NombreUsuario77& 3
==774 6
nombreUsuario777 D
&&77E G
u77H I
.77I J!
CodigoHomologacionRol77J _
==77` b!
codigoHomologacionRol77c x
&&77y {
u77| }
.77} ~#
CodigoHomologacionMenu	77~ �
==
77� �$
codigoHomologacionMenu
77� �
)
77� �
.88 
OrderByDescending88 *
(88* +
o88+ ,
=>88- /
o880 1
.881 2
FechaCreacion882 ?
)88? @
.99 
FirstOrDefault99 '
(99' (
)99( )
;99) *
return;; 
result;; !
!=;;" $
null;;% )
?;;* +
JsonConvert;;, 7
.;;7 8
DeserializeObject;;8 I
<;;I J
JObject;;J Q
>;;Q R
(;;R S
result;;S Y
.;;Y Z
ParametroJson;;Z g
);;g h
?;;h i
[;;i j
$str;;j p
];;p q
?;;q r
.;;r s
ToString;;s {
(;;{ |
);;| }
:;;~ 
null
;;� �
;
;;� �
}<< 
)<< 
;<< 
}== 
catch>> 
(>> 
	Exception>> 
ex>> 
)>>  
{?? 
_logger@@ 
.@@ 
LogError@@  
(@@  !
ex@@! #
,@@# $
$str@@% J
)@@J K
;@@K L
returnAA 
stringAA 
.AA 
EmptyAA #
;AA# $
}BB 
}CC 	
publicDD 
ListDD 
<DD 
	EventUserDD 
>DD 
GetEventAllDD *
(DD* +
stringDD+ 1
reportDD2 8
,DD8 9
DateOnlyDD: B
finiDDC G
,DDG H
DateOnlyDDI Q
ffinDDR V
)DDV W
{EE 	
returnFF 
ExecuteDbOperationFF %
(FF% &
contextFF& -
=>FF. 0
{GG 
tryHH 
{II 
ifKK 
(KK 
!KK 
RegexKK 
.KK 
IsMatchKK &
(KK& '
reportKK' -
,KK- .
$strKK/ @
)KK@ A
)KKA B
{LL 
throwMM 
newMM !
ArgumentExceptionMM" 3
(MM3 4
$strMM4 O
)MMO P
;MMP Q
}NN 
stringQQ 
sqlQQ 
=QQ  
$"QQ! #
$strQQ# 1
{QQ1 2
reportQQ2 8
}QQ8 9
$strQQ9 s
"QQs t
;QQt u
returnSS 
contextSS "
.SS" #
	EventUserSS# ,
.TT 

FromSqlRawTT "
(TT" #
sqlTT# &
,TT& '
newUU 
SqlParameterUU +
(UU+ ,
$strUU, 3
,UU3 4
finiUU5 9
)UU9 :
,UU: ;
newVV 
SqlParameterVV +
(VV+ ,
$strVV, 3
,VV3 4
ffinVV5 9
)VV9 :
)VV: ;
.WW 
ToListWW 
(WW 
)WW  
;WW  !
;YY 
}ZZ 
catch[[ 
([[ 
	Exception[[  
ex[[! #
)[[# $
{\\ 
_logger]] 
.]] 
LogError]] $
(]]$ %
ex]]% '
,]]' (
$str]]) L
)]]L M
;]]M N
return^^ 
[^^ 
]^^ 
;^^ 
}__ 
}`` 
)`` 
;`` 
}aa 	
publiccc 
Listcc 
<cc 
VwEventUserAllcc "
>cc" #
GetEventUserAllcc$ 3
(cc3 4
)cc4 5
{dd 	
returnee 
ExecuteDbOperationee %
(ee% &
contextee& -
=>ee. 0
contextee1 8
.ee8 9
VwEventUserAllee9 G
.eeG H
AsNoTrackingeeH T
(eeT U
)eeU V
.eeV W
ToListeeW ]
(ee] ^
)ee^ _
)ee_ `
;ee` a
}ff 	
publicii 
boolii 
DeleteEventAllii "
(ii" #
DateOnlyii# +
finiii, 0
,ii0 1
DateOnlyii2 :
ffinii; ?
)ii? @
{jj 	
returnkk 
ExecuteDbOperationkk %
(kk% &
contextkk& -
=>kk. 0
{ll 
trymm 
{nn 
stringoo 
sqloo 
=oo  
$"oo! #
$stroo# v
"oov w
;oow x
intqq 
rowsAffectedqq $
=qq% &
contextqq' .
.qq. /
Databaseqq/ 7
.qq7 8
ExecuteSqlRawqq8 E
(qqE F
sqlrr! $
,rr$ %
newss" %
SqlParameterss& 2
(ss2 3
$strss3 :
,ss: ;
finiss< @
)ss@ A
,ssA B
newtt" %
SqlParametertt& 2
(tt2 3
$strtt3 :
,tt: ;
ffintt< @
)tt@ A
)uu 
;uu  
returnww 
rowsAffectedww '
>ww( )
$numww* +
;ww+ ,
}xx 
catchyy 
(yy 
	Exceptionyy  
exyy! #
)yy# $
{zz 
_logger{{ 
.{{ 
LogError{{ $
({{$ %
ex{{% '
,{{' (
$str{{) O
){{O P
;{{P Q
return|| 
false||  
;||  !
}}} 
}~~ 
)~~ 
;~~ 
} 	
public
�� 
bool
�� 
DeleteEventById
�� #
(
��# $
int
��$ '
id
��( *
)
��* +
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
try
�� 
{
�� 
string
�� 
sql
�� 
=
��  
$str
��! X
;
��X Y
int
�� 
rowsAffected
�� $
=
��% &
context
��' .
.
��. /
Database
��/ 7
.
��7 8
ExecuteSqlRaw
��8 E
(
��E F
sql
�� 
,
�� 
new
�� 
SqlParameter
�� (
(
��( )
$str
��) .
,
��. /
id
��0 2
)
��2 3
)
�� 
;
�� 
return
�� 
rowsAffected
�� '
>
��( )
$num
��* +
;
��+ ,
}
�� 
catch
�� 
(
�� 
	Exception
��  
ex
��! #
)
��# $
{
�� 
_logger
�� 
.
�� 
LogError
�� $
(
��$ %
ex
��% '
,
��' (
$str
��) P
)
��P Q
;
��Q R
return
�� 
false
��  
;
��  !
}
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
Menus
�� 
?
�� 
FindDataById
�� "
(
��" #
int
��# &
idHRol
��' -
,
��- .
int
��/ 2
idHMenu
��3 :
)
��: ;
{
�� 	
throw
�� 
new
�� %
NotImplementedException
�� -
(
��- .
)
��. /
;
��/ 0
}
�� 	
public
�� 
List
�� 
<
�� '
VwEventTrackingSessionDto
�� -
>
��- .
GetEventSession
��/ >
(
��> ?
)
��? @
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
try
�� 
{
�� 
string
�� 
sql
�� 
=
��  
$str
��! :
;
��: ;
return
�� 
context
�� "
.
��" #
EventSession
��# /
.
�� 

FromSqlRaw
�� "
(
��" #
sql
��# &
)
��& '
.
�� 
ToList
�� 
(
�� 
)
��  
;
��  !
}
�� 
catch
�� 
(
�� 
	Exception
��  
ex
��! #
)
��# $
{
�� 
_logger
�� 
.
�� 
LogError
�� $
(
��$ %
ex
��% '
,
��' (
$str
��) P
)
��P Q
;
��Q R
return
�� 
[
�� 
]
�� 
;
�� 
}
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� #
PaginasMasVisitadaDto
�� )
>
��) *!
GetEventPagMasVisit
��+ >
(
��> ?
)
��? @
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
try
�� 
{
�� 
string
�� 
sql
�� 
=
��  
$str
��! =
;
��= >
return
�� 
context
�� "
.
��" #
EventPagMasVisit
��# 3
.
�� 

FromSqlRaw
�� "
(
��" #
sql
��# &
)
��& '
.
�� 
ToList
�� 
(
�� 
)
��  
;
��  !
}
�� 
catch
�� 
(
�� 
	Exception
��  
ex
��! #
)
��# $
{
�� 
_logger
�� 
.
�� 
LogError
�� $
(
��$ %
ex
��% '
,
��' (
$str
��) T
)
��T U
;
��U V
return
�� 
[
�� 
]
�� 
;
�� 
}
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
��  
FiltrosMasUsadoDto
�� &
>
��& '"
GetEventFiltroMasUsa
��( <
(
��< =
)
��= >
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
try
�� 
{
�� 
string
�� 
sql
�� 
=
��  
$str
��! 9
;
��9 :
return
�� 
context
�� "
.
��" #!
EventFiltroMasUsado
��# 6
.
�� 

FromSqlRaw
�� "
(
��" #
sql
��# &
)
��& '
.
�� 
ToList
�� 
(
�� 
)
��  
;
��  !
}
�� 
catch
�� 
(
�� 
	Exception
��  
ex
��! #
)
��# $
{
�� 
_logger
�� 
.
�� 
LogError
�� $
(
��$ %
ex
��% '
,
��' (
$str
��) U
)
��U V
;
��V W
return
�� 
[
�� 
]
�� 
;
�� 
}
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
}
�� 
}�� �8
XC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\EsquemaVistaRepository.cs
	namespace		 	

DataAccess		
 
.		 
Repositories		 !
{

 
public 

class "
EsquemaVistaRepository '
:( )
BaseRepository* 8
,8 9#
IEsquemaVistaRepository: Q
{ 
public "
EsquemaVistaRepository %
(% &
ILogger
 
< "
EsquemaVistaRepository (
>( )
logger* 0
,0 1&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
bool 
Create 
( 
EsquemaVista '
data( ,
), -
{ 	
data 
. 
IdUserModifica 
=  !
data" &
.& '
IdUserCreacion' 5
;5 6
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
context 
. 
EsquemaVista $
.$ %
Add% (
(( )
data) -
)- .
;. /
return 
context 
. 
SaveChanges *
(* +
)+ ,
>=- /
$num0 1
;1 2
} 
) 
; 
} 	
public 
EsquemaVista 
? 
FindById %
(% &
int& )
id* ,
), -
{   	
return!! 
ExecuteDbOperation!! %
(!!% &
context!!& -
=>!!. 0
context!!1 8
.!!8 9
EsquemaVista!!9 E
.!!E F
AsNoTracking!!F R
(!!R S
)!!S T
.!!T U
FirstOrDefault!!U c
(!!c d
u!!d e
=>!!f h
u!!i j
.!!j k
IdEsquemaVista!!k y
==!!z |
id!!} 
)	!! �
)
!!� �
;
!!� �
}"" 	
public## 
EsquemaVista## 
?## 
FindByIdEsquema## ,
(##, -
int##- 0
	idEsquema##1 :
)##: ;
{$$ 	
return%% 
ExecuteDbOperation%% %
(%%% &
context%%& -
=>%%. 0
context%%1 8
.%%8 9
EsquemaVista%%9 E
.%%E F
AsNoTracking%%F R
(%%R S
)%%S T
.%%T U
FirstOrDefault%%U c
(%%c d
u%%d e
=>%%f h
u%%i j
.%%j k
	IdEsquema%%k t
==%%u w
	idEsquema	%%x �
)
%%� �
)
%%� �
;
%%� �
}&& 	
public'' 
EsquemaVista'' 
?'' 
_FindByIdEsquema'' -
(''- .
int''. 1
	idEsquema''2 ;
,''; <
int''= @
idOna''A F
)''F G
{(( 	
return)) 
ExecuteDbOperation)) %
())% &
context))& -
=>)). 0
context** 
.** 
EsquemaVista** $
.++ 
AsNoTracking++ !
(++! "
)++" #
.,, 
FirstOrDefault,, #
(,,# $
u,,$ %
=>,,& (
u,,) *
.,,* +
	IdEsquema,,+ 4
==,,5 7
	idEsquema,,8 A
&&,,B D
u,,E F
.,,F G
IdONA,,G L
==,,M O
idOna,,P U
&&,,V X
u,,Y Z
.,,Z [
Estado,,[ a
==,,b d

Constantes,,e o
.,,o p
ESTADO_USUARIO_A	,,p �
)
,,� �
)
,,� �
;
,,� �
}-- 	
public.. 
async.. 
Task.. 
<.. 
EsquemaVista.. &
?..& '
>..' (!
_FindByIdEsquemaAsync..) >
(..> ?
int..? B
	idEsquema..C L
,..L M
int..N Q
idOna..R W
)..W X
{// 	
return00 
await00 
ExecuteDbOperation00 +
(00+ ,
async00, 1
context002 9
=>00: <
await11 
context11 
.11 
EsquemaVista11 *
.22 
AsNoTracking22 !
(22! "
)22" #
.33 
FirstOrDefaultAsync33 (
(33( )
u33) *
=>33+ -
u33. /
.33/ 0
	IdEsquema330 9
==33: <
	idEsquema33= F
&&33G I
u33J K
.33K L
IdONA33L Q
==33R T
idOna33U Z
&&33[ ]
u33^ _
.33_ `
Estado33` f
==33g i

Constantes33j t
.33t u
ESTADO_USUARIO_A	33u �
)
33� �
)44 
;44 
}55 	
public77 
List77 
<77 
EsquemaVista77  
>77  !
FindAll77" )
(77) *
)77* +
{88 	
try99 
{:: 
return;; 
ExecuteDbOperation;; )
(;;) *
context;;* 1
=>;;2 4
context;;5 <
.;;< =
EsquemaVista;;= I
.;;I J
AsNoTracking;;J V
(;;V W
);;W X
.;;X Y
Where;;Y ^
(;;^ _
c;;_ `
=>;;a c
c;;d e
.;;e f
Estado;;f l
.;;l m
Equals;;m s
(;;s t

Constantes;;t ~
.;;~ 
ESTADO_USUARIO_A	;; �
)
;;� �
)
;;� �
.
;;� �
ToList
;;� �
(
;;� �
)
;;� �
)
;;� �
;
;;� �
}<< 
catch== 
(== 
	Exception== 
ex== 
)==  
{>> 
throw@@ 
ex@@ 
;@@ 
}AA 
}CC 	
publicDD 
boolDD 
UpdateDD 
(DD 
EsquemaVistaDD '
	newRecordDD( 1
)DD1 2
{EE 	
returnFF 
ExecuteDbOperationFF %
(FF% &
contextFF& -
=>FF. 0
{GG 
varHH 
_exitsHH 
=HH !
MergeEntityPropertiesHH 2
(HH2 3
contextHH3 :
,HH: ;
	newRecordHH< E
,HHE F
uHHG H
=>HHI K
uHHL M
.HHM N
IdEsquemaVistaHHN \
==HH] _
	newRecordHH` i
.HHi j
IdEsquemaVistaHHj x
)HHx y
;HHy z
_exitsII 
.II 
FechaModificaII $
=II% &
DateTimeII' /
.II/ 0
NowII0 3
;II3 4
contextJJ 
.JJ 
EsquemaVistaJJ $
.JJ$ %
UpdateJJ% +
(JJ+ ,
_exitsJJ, 2
)JJ2 3
;JJ3 4
returnKK 
contextKK 
.KK 
SaveChangesKK *
(KK* +
)KK+ ,
>=KK- /
$numKK0 1
;KK1 2
}LL 
)LL 
;LL 
}MM 	
}OO 
}PP �O
_C:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\EsquemaVistaColumnaRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{		 
public

 

class

 )
EsquemaVistaColumnaRepository

 .
:

/ 0
BaseRepository

1 ?
,

? @*
IEsquemaVistaColumnaRepository

A _
{ 
public )
EsquemaVistaColumnaRepository ,
(, -
ILogger
 
< )
EsquemaVistaColumnaRepository /
>/ 0
logger1 7
,7 8&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
bool 
Create 
( 
EsquemaVistaColumna .
data/ 3
)3 4
{ 	
data 
. 
IdUserModifica 
=  !
data" &
.& '
IdUserCreacion' 5
;5 6
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
context 
. 
EsquemaVistaColumna +
.+ ,
Add, /
(/ 0
data0 4
)4 5
;5 6
return 
context 
. 
SaveChanges *
(* +
)+ ,
>=- /
$num0 1
;1 2
} 
) 
; 
} 	
public 
EsquemaVistaColumna "
?" #
FindById$ ,
(, -
int- 0
id1 3
)3 4
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
context1 8
.8 9
EsquemaVistaColumna9 L
.L M
AsNoTrackingM Y
(Y Z
)Z [
.[ \
FirstOrDefault\ j
(j k
uk l
=>m o
up q
.q r"
IdEsquemaVistaColumna	r �
==
� �
id
� �
)
� �
)
� �
;
� �
} 	
public   
List   
<   
EsquemaVistaColumna   '
>  ' ( 
FindByIdEsquemaVista  ) =
(  = >
int  > A
IdEsquemaVista  B P
)  P Q
{!! 	
return"" 
ExecuteDbOperation"" %
(""% &
context""& -
=>"". 0
context""1 8
.""8 9
EsquemaVistaColumna""9 L
.""L M
AsNoTracking""M Y
(""Y Z
)""Z [
.""[ \
Where""\ a
(""a b
u""b c
=>""d f
u""g h
.""h i
IdEsquemaVista""i w
==""x z
IdEsquemaVista	""{ �
&&
""� �
u
""� �
.
""� �
Estado
""� �
==
""� �

Constantes
""� �
.
""� �
ESTADO_USUARIO_A
""� �
)
""� �
.
""� �
ToList
""� �
(
""� �
)
""� �
)
""� �
;
""� �
}## 	
public$$ 
List$$ 
<$$ 
EsquemaVistaColumna$$ '
>$$' (#
FindByIdEsquemaVistaOna$$) @
($$@ A
int$$A D
idEsquemaVista$$E S
,$$S T
int$$U X
idONA$$Y ^
)$$^ _
{%% 	
return&& 
ExecuteDbOperation&& %
(&&% &
context&&& -
=>&&. 0
('' 
from'' 
vista'' 
in'' 
context'' &
.''& '
EsquemaVista''' 3
join(( 
columna(( 
in((  
context((! (
.((( )
EsquemaVistaColumna(() <
on)) 
vista)) 
.)) 
IdEsquemaVista)) (
equals))) /
columna))0 7
.))7 8
IdEsquemaVista))8 F
where** 
vista** 
.** 
IdONA** "
==**# %
idONA**& +
&&++ 
vista++ 
.++  
Estado++  &
==++' )

Constantes++* 4
.++4 5
ESTADO_USUARIO_A++5 E
&&,, 
columna,, !
.,,! "
Estado,," (
==,,) +

Constantes,,, 6
.,,6 7
ESTADO_USUARIO_A,,7 G
&&-- 
columna-- !
.--! "
IdEsquemaVista--" 0
==--1 3
idEsquemaVista--4 B
select.. 
new.. 
EsquemaVistaColumna.. /
{// 
IdEsquemaVista00 #
=00$ %
vista00& +
.00+ ,
IdEsquemaVista00, :
,00: ;
ColumnaVista11 !
=11" #
columna11$ +
.11+ ,
ColumnaVista11, 8
,118 9
ColumnaEsquemaIdH22 &
=22' (
columna22) 0
.220 1
ColumnaEsquemaIdH221 B
,22B C!
IdEsquemaVistaColumna33 *
=33+ ,
columna33- 4
.334 5!
IdEsquemaVistaColumna335 J
,33J K
ColumnaEsquema44 #
=44$ %
columna44& -
.44- .
ColumnaEsquema44. <
,44< =
ColumnaVistaPK55 #
=55$ %
columna55& -
.55- .
ColumnaVistaPK55. <
,55< =
}77 
)77 
.77 
ToList77 
(77 
)77 
)77 
;77 
}88 	
public99 
async99 
Task99 
<99 
List99 
<99 
EsquemaVistaColumna99 2
>992 3
>993 4(
FindByIdEsquemaVistaOnaAsync995 Q
(99Q R
int99R U
idEsquemaVista99V d
,99d e
int99f i
idONA99j o
)99o p
{:: 	
return;; 
await;; 
ExecuteDbOperation;; +
(;;+ ,
async;;, 1
context;;2 9
=>;;: <
await<< 
(<< 
from<< 
vista<< !
in<<" $
context<<% ,
.<<, -
EsquemaVista<<- 9
join== 
columna== #
in==$ &
context==' .
.==. /
EsquemaVistaColumna==/ B
on>> 
vista>> 
.>>  
IdEsquemaVista>>  .
equals>>/ 5
columna>>6 =
.>>= >
IdEsquemaVista>>> L
where?? 
vista?? "
.??" #
IdONA??# (
==??) +
idONA??, 1
&&@@ 
vista@@  %
.@@% &
Estado@@& ,
==@@- /

Constantes@@0 :
.@@: ;
ESTADO_USUARIO_A@@; K
&&AA 
columnaAA  '
.AA' (
EstadoAA( .
==AA/ 1

ConstantesAA2 <
.AA< =
ESTADO_USUARIO_AAA= M
&&BB 
columnaBB  '
.BB' (
IdEsquemaVistaBB( 6
==BB7 9
idEsquemaVistaBB: H
selectCC 
newCC !
EsquemaVistaColumnaCC" 5
{DD 
IdEsquemaVistaEE )
=EE* +
vistaEE, 1
.EE1 2
IdEsquemaVistaEE2 @
,EE@ A
ColumnaVistaFF '
=FF( )
columnaFF* 1
.FF1 2
ColumnaVistaFF2 >
,FF> ?
ColumnaEsquemaIdHGG ,
=GG- .
columnaGG/ 6
.GG6 7
ColumnaEsquemaIdHGG7 H
,GGH I!
IdEsquemaVistaColumnaHH 0
=HH1 2
columnaHH3 :
.HH: ;!
IdEsquemaVistaColumnaHH; P
,HHP Q
ColumnaEsquemaII )
=II* +
columnaII, 3
.II3 4
ColumnaEsquemaII4 B
,IIB C
ColumnaVistaPKJJ )
=JJ* +
columnaJJ, 3
.JJ3 4
ColumnaVistaPKJJ4 B
,JJB C
}KK 
)KK 
.KK 
ToListAsyncKK %
(KK% &
)KK& '
)KK' (
;KK( )
}LL 	
publicNN 
ListNN 
<NN 
EsquemaVistaColumnaNN '
>NN' (
FindAllNN) 0
(NN0 1
)NN1 2
{OO 	
returnPP 
ExecuteDbOperationPP %
(PP% &
contextPP& -
=>PP. 0
contextPP1 8
.PP8 9
EsquemaVistaColumnaPP9 L
.PPL M
AsNoTrackingPPM Y
(PPY Z
)PPZ [
.PP[ \
WherePP\ a
(PPa b
cPPb c
=>PPd f
cPPg h
.PPh i
EstadoPPi o
.PPo p
EqualsPPp v
(PPv w

Constantes	PPw �
.
PP� �
ESTADO_USUARIO_A
PP� �
)
PP� �
)
PP� �
.
PP� �
ToList
PP� �
(
PP� �
)
PP� �
)
PP� �
;
PP� �
}QQ 	
publicRR 
boolRR 
UpdateRR 
(RR 
EsquemaVistaColumnaRR .
	newRecordRR/ 8
)RR8 9
{SS 	
returnTT 
ExecuteDbOperationTT %
(TT% &
contextTT& -
=>TT. 0
{UU 
varVV 
_exitsVV 
=VV !
MergeEntityPropertiesVV 2
(VV2 3
contextVV3 :
,VV: ;
	newRecordVV< E
,VVE F
uVVG H
=>VVI K
uVVL M
.VVM N!
IdEsquemaVistaColumnaVVN c
==VVd f
	newRecordVVg p
.VVp q"
IdEsquemaVistaColumna	VVq �
)
VV� �
;
VV� �
_exitsXX 
.XX 
FechaModificaXX $
=XX% &
DateTimeXX' /
.XX/ 0
NowXX0 3
;XX3 4
contextYY 
.YY 
EsquemaVistaColumnaYY +
.YY+ ,
UpdateYY, 2
(YY2 3
_exitsYY3 9
)YY9 :
;YY: ;
returnZZ 
contextZZ 
.ZZ 
SaveChangesZZ *
(ZZ* +
)ZZ+ ,
>=ZZ- /
$numZZ0 1
;ZZ1 2
}[[ 
)[[ 
;[[ 
}\\ 	
}^^ 
}__ ؜
SC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\EsquemaRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{		 
public

 

class

 
EsquemaRepository

 "
:

# $
BaseRepository

% 3
,

3 4
IEsquemaRepository

5 G
{ 
public 
EsquemaRepository  
(  !
ILogger
 
< 
EsquemaRepository #
># $
logger% +
,+ ,&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
bool 
Create 
( 
Esquema "
data# '
)' (
{ 	
data 
. 
IdUserModifica 
=  !
data" &
.& '
IdUserCreacion' 5
;5 6
data 
. 
FechaCreacion 
=  
DateTime! )
.) *
Now* -
;- .
data 
. 
FechaModifica 
=  
DateTime! )
.) *
Now* -
;- .
data 
. 
Estado 
= 

Constantes $
.$ %
ESTADO_USUARIO_A% 5
;5 6
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
context 
. 
Esquema 
.  
Add  #
(# $
data$ (
)( )
;) *
return 
context 
. 
SaveChanges *
(* +
)+ ,
>=- /
$num0 1
;1 2
} 
) 
; 
} 	
public 
bool #
CreateEsquemaValidacion +
(+ ,
EsquemaVista, 8
data9 =
)= >
{   	
data!! 
.!! 
IdUserModifica!! 
=!!  !
data!!" &
.!!& '
IdUserCreacion!!' 5
;!!5 6
data"" 
."" 
FechaModifica"" 
=""  
DateTime""! )
."") *
Now""* -
;""- .
data## 
.## 
Estado## 
=## 

Constantes## $
.##$ %
ESTADO_USUARIO_A##% 5
;##5 6
return%% 
ExecuteDbOperation%% %
(%%% &
context%%& -
=>%%. 0
{&& 
context'' 
.'' 
EsquemaVista'' $
.''$ %
Add''% (
(''( )
data'') -
)''- .
;''. /
return(( 
context(( 
.(( 
SaveChanges(( *
(((* +
)((+ ,
>=((- /
$num((0 1
;((1 2
})) 
))) 
;)) 
}** 	
public++ 
Esquema++ 
?++ 
FindById++  
(++  !
int++! $
id++% '
)++' (
{,, 	
return-- 
ExecuteDbOperation-- %
(--% &
context--& -
=>--. 0
context--1 8
.--8 9
Esquema--9 @
.--@ A
AsNoTracking--A M
(--M N
)--N O
.--O P
FirstOrDefault--P ^
(--^ _
u--_ `
=>--a c
u--d e
.--e f
	IdEsquema--f o
==--p r
id--s u
)--u v
)--v w
;--w x
}.. 	
public// 
EsquemaVistaColumna// "
?//" #6
*GetEsquemaVistaColumnaByIdEquemaVistaAsync//$ N
(//N O
int//O R
idOna//S X
,//X Y
int//Z ]
	idEsquema//^ g
)//g h
{00 	
return11 
ExecuteDbOperation11 %
(11% &
context11& -
=>11. 0
{22 
var44 
idEsquemaVista44 "
=44# $
context44% ,
.44, -
EsquemaVista44- 9
.55 
Where55 
(55 
v55 
=>55 
v55  !
.55! "
IdONA55" '
==55( *
idOna55+ 0
&&551 3
v554 5
.555 6
	IdEsquema556 ?
==55@ B
	idEsquema55C L
&&55M O
v55P Q
.55Q R
Estado55R X
==55Y [

Constantes55\ f
.55f g
ESTADO_USUARIO_A55g w
)55w x
.66 
Select66 
(66 
v66 
=>66  
v66! "
.66" #
IdEsquemaVista66# 1
)661 2
.77 
FirstOrDefault77 #
(77# $
)77$ %
;77% &
if:: 
(:: 
idEsquemaVista:: "
==::# %
$num::& '
)::' (
{;; 
return<< 
null<< 
;<<  
}== 
return@@ 
context@@ 
.@@ 
EsquemaVistaColumna@@ 2
.AA 
AsNoTrackingAA !
(AA! "
)AA" #
.BB 
FirstOrDefaultBB #
(BB# $
uBB$ %
=>BB& (
uBB) *
.BB* +
IdEsquemaVistaBB+ 9
==BB: <
idEsquemaVistaBB= K
)BBK L
;BBL M
}CC 
)CC 
;CC 
}DD 	
publicFF 
EsquemaFF 
?FF 
FindByViewNameFF &
(FF& '
stringFF' -
esquemaVistaFF. :
)FF: ;
{GG 	
returnHH 
ExecuteDbOperationHH %
(HH% &
contextHH& -
=>HH. 0
contextHH1 8
.HH8 9
EsquemaHH9 @
.HH@ A
AsNoTrackingHHA M
(HHM N
)HHN O
.HHO P
FirstOrDefaultHHP ^
(HH^ _
uHH_ `
=>HHa c
uHHd e
.HHe f
EsquemaVistaHHf r
==HHs u
esquemaVista	HHv �
)
HH� �
)
HH� �
;
HH� �
}II 	
publicJJ 
asyncJJ 
TaskJJ 
<JJ 
EsquemaJJ !
?JJ! "
>JJ" #
FindByViewNameAsyncJJ$ 7
(JJ7 8
stringJJ8 >
esquemaVistaJJ? K
)JJK L
{KK 	
returnLL 
awaitLL 
ExecuteDbOperationLL +
(LL+ ,
asyncLL, 1
contextLL2 9
=>LL: <
awaitMM 
contextMM 
.MM 
EsquemaMM %
.MM% &
AsNoTrackingMM& 2
(MM2 3
)MM3 4
.MM4 5
FirstOrDefaultAsyncMM5 H
(MMH I
uMMI J
=>MMK M
uMMN O
.MMO P
EsquemaVistaMMP \
==MM] _
esquemaVistaMM` l
)MMl m
)NN 
;NN 
}OO 	
publicQQ 
ListQQ 
<QQ 
EsquemaQQ 
>QQ 
FindAllQQ $
(QQ$ %
)QQ% &
{RR 	
returnSS 
ExecuteDbOperationSS %
(SS% &
contextSS& -
=>SS. 0
contextSS1 8
.SS8 9
EsquemaSS9 @
.SS@ A
AsNoTrackingSSA M
(SSM N
)SSN O
.SSO P
WhereSSP U
(SSU V
cSSV W
=>SSX Z
cSS[ \
.SS\ ]
EstadoSS] c
.SSc d
EqualsSSd j
(SSj k

ConstantesSSk u
.SSu v
ESTADO_USUARIO_A	SSv �
)
SS� �
)
SS� �
.
SS� �
OrderBy
SS� �
(
SS� �
c
SS� �
=>
SS� �
c
SS� �
.
SS� �
MostrarWebOrden
SS� �
)
SS� �
.
SS� �
ToList
SS� �
(
SS� �
)
SS� �
)
SS� �
;
SS� �
}TT 	
publicUU 
ListUU 
<UU 
EsquemaUU 
>UU 
FindAllWithViewsUU -
(UU- .
)UU. /
{VV 	
returnWW 
ExecuteDbOperationWW %
(WW% &
contextWW& -
=>WW. 0
contextWW1 8
.WW8 9
EsquemaWW9 @
.WW@ A
AsNoTrackingWWA M
(WWM N
)WWN O
.WWO P
WhereWWP U
(WWU V
cWWV W
=>WWX Z
cWW[ \
.WW\ ]
EstadoWW] c
==WWd f

ConstantesWWg q
.WWq r
ESTADO_USUARIO_A	WWr �
&&
WW� �
c
WW� �
.
WW� �
EsquemaVista
WW� �
!=
WW� �
null
WW� �
&&
WW� �
!
WW� �
string
WW� �
.
WW� �
IsNullOrEmpty
WW� �
(
WW� �
c
WW� �
.
WW� �
EsquemaVista
WW� �
.
WW� �
Trim
WW� �
(
WW� �
)
WW� �
)
WW� �
)
WW� �
.
WW� �
OrderBy
WW� �
(
WW� �
c
WW� �
=>
WW� �
c
WW� �
.
WW� �
MostrarWebOrden
WW� �
)
WW� �
.
WW� �
ToList
WW� �
(
WW� �
)
WW� �
)
WW� �
;
WW� �
}XX 	
publicYY 
boolYY 
UpdateYY 
(YY 
EsquemaYY "
	newRecordYY# ,
)YY, -
{ZZ 	
return[[ 
ExecuteDbOperation[[ %
([[% &
context[[& -
=>[[. 0
{\\ 
var]] 
_exits]] 
=]] !
MergeEntityProperties]] 2
(]]2 3
context]]3 :
,]]: ;
	newRecord]]< E
,]]E F
u]]G H
=>]]I K
u]]L M
.]]M N
	IdEsquema]]N W
==]]X Z
	newRecord]][ d
.]]d e
	IdEsquema]]e n
)]]n o
;]]o p
_exits__ 
.__ 
FechaModifica__ $
=__% &
DateTime__' /
.__/ 0
Now__0 3
;__3 4
contextaa 
.aa 
Esquemaaa 
.aa  
Updateaa  &
(aa& '
_exitsaa' -
)aa- .
;aa. /
returnbb 
contextbb 
.bb 
SaveChangesbb *
(bb* +
)bb+ ,
>=bb- /
$numbb0 1
;bb1 2
}cc 
)cc 
;cc 
}dd 	
publicee 
boolee ;
/EliminarEsquemaVistaColumnaByIdEquemaVistaAsyncee C
(eeC D
inteeD G
IdEsquemaVistaeeH V
)eeV W
{ff 	
returngg 
ExecuteDbOperationgg %
(gg% &
contextgg& -
=>gg. 0
{hh 
varjj 
	registrosjj 
=jj 
contextjj  '
.jj' (
EsquemaVistaColumnajj( ;
.kk 
Wherekk 
(kk 
ekk 
=>kk 
ekk  !
.kk! "
IdEsquemaVistakk" 0
==kk1 3
IdEsquemaVistakk4 B
)kkB C
.ll 
ToListll 
(ll 
)ll 
;ll 
ifnn 
(nn 
	registrosnn 
.nn 
Anynn !
(nn! "
)nn" #
)nn# $
{oo 
foreachpp 
(pp 
varpp  
registropp! )
inpp* ,
	registrospp- 6
)pp6 7
{qq 
registrorr  
.rr  !
Estadorr! '
=rr( )

Constantesrr* 4
.rr4 5)
MESAGGE_REGISTRO_NO_ENCOTRADOrr5 R
;rrR S
registross  
.ss  !
FechaModificass! .
=ss/ 0
DateTimess1 9
.ss9 :
Nowss: =
;ss= >
}tt 
contextww 
.ww 
EsquemaVistaColumnaww /
.ww/ 0
UpdateRangeww0 ;
(ww; <
	registrosww< E
)wwE F
;wwF G
}xx 
returnzz 
contextzz 
.zz 
SaveChangeszz *
(zz* +
)zz+ ,
>=zz- /
$numzz0 1
;zz1 2
}{{ 
){{ 
;{{ 
}|| 	
public~~ 
bool~~ #
UpdateEsquemaValidacion~~ +
(~~+ ,
EsquemaVista~~, 8
	newRecord~~9 B
)~~B C
{ 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
var
�� 
existingRecord
�� "
=
��# $
context
��% ,
.
��, -
EsquemaVista
��- 9
.
�� 
FirstOrDefault
�� #
(
��# $
u
��$ %
=>
��& (
u
��) *
.
��* +
IdONA
��+ 0
==
��1 3
	newRecord
��4 =
.
��= >
IdONA
��> C
&&
��D F
u
��G H
.
��H I
	IdEsquema
��I R
==
��S U
	newRecord
��V _
.
��_ `
	IdEsquema
��` i
)
��i j
;
��j k
if
�� 
(
�� 
existingRecord
�� "
!=
��# %
null
��& *
)
��* +
{
�� 
existingRecord
�� "
=
��# $#
MergeEntityProperties
��% :
(
��: ;
context
��; B
,
��B C
	newRecord
��D M
,
��M N
u
��O P
=>
��Q S
u
��T U
.
��U V
IdONA
��V [
==
��\ ^
	newRecord
��_ h
.
��h i
IdONA
��i n
&&
��o q
u
��U V
.
��V W
	IdEsquema
��W `
==
��a c
	newRecord
��d m
.
��m n
	IdEsquema
��n w
)
��w x
;
��x y
existingRecord
�� "
.
��" #
FechaModifica
��# 0
=
��1 2
DateTime
��3 ;
.
��; <
Now
��< ?
;
��? @
context
�� 
.
�� 
EsquemaVista
�� (
.
��( )
Update
��) /
(
��/ 0
existingRecord
��0 >
)
��> ?
;
��? @
}
�� 
else
�� 
{
�� 
	newRecord
�� 
.
�� 
FechaCreacion
�� +
=
��, -
DateTime
��. 6
.
��6 7
Now
��7 :
;
��: ;
	newRecord
�� 
.
�� 
Estado
�� $
=
��% &

Constantes
��' 1
.
��1 2
ESTADO_USUARIO_A
��2 B
;
��B C
context
�� 
.
�� 
EsquemaVista
�� (
.
��( )
Add
��) ,
(
��, -
	newRecord
��- 6
)
��6 7
;
��7 8
}
�� 
return
�� 
context
�� 
.
�� 
SaveChanges
�� *
(
��* +
)
��+ ,
>=
��- /
$num
��0 1
;
��1 2
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� 
Esquema
�� 
>
�� "
GetListaEsquemaByOna
�� 1
(
��1 2
int
��2 5
idONA
��6 ;
)
��; <
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
(
�� 
from
�� 
e
�� 
in
�� 
context
�� "
.
��" #
Esquema
��# *
where
�� 
e
�� 
.
�� 
Estado
�� 
==
��  "

Constantes
��# -
.
��- .
ESTADO_USUARIO_A
��. >
select
�� 
new
�� 
Esquema
�� #
{
�� 
	IdEsquema
�� 
=
��  
e
��! "
.
��" #
	IdEsquema
��# ,
,
��, -
EsquemaVista
�� !
=
��" #
e
��$ %
.
��% &
EsquemaVista
��& 2
,
��2 3

MostrarWeb
�� 
=
��  !
e
��" #
.
��# $

MostrarWeb
��$ .
,
��. /
MostrarWebOrden
�� $
=
��% &
e
��' (
.
��( )
MostrarWebOrden
��) 8
,
��8 9

TooltipWeb
�� 
=
��  !
e
��" #
.
��# $

TooltipWeb
��$ .
,
��. /
EsquemaJson
��  
=
��! "
e
��# $
.
��$ %
EsquemaJson
��% 0
}
�� 
)
�� 
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
bool
�� -
GuardarListaEsquemaVistaColumna
�� 3
(
��3 4
List
��4 8
<
��8 9!
EsquemaVistaColumna
��9 L
>
��L M&
listaEsquemaVistaColumna
��N f
,
��f g
int
��h k
?
��k l
idOna
��m r
,
��r s
int
��t w
?
��w x
	idEsquema��y �
)��� �
{
�� 	
if
�� 
(
�� &
listaEsquemaVistaColumna
�� (
==
��) +
null
��, 0
||
��1 3
!
��4 5&
listaEsquemaVistaColumna
��5 M
.
��M N
Any
��N Q
(
��Q R
)
��R S
)
��S T
{
�� 
return
�� 
false
�� 
;
�� 
}
�� 
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
var
�� 
idEsquemaVista
�� "
=
��# $
context
��% ,
.
��, -
EsquemaVista
��- 9
.
�� 
Where
�� 
(
�� 
v
�� 
=>
�� 
v
��  !
.
��! "
IdONA
��" '
==
��( *
idOna
��+ 0
&&
��1 3
v
��4 5
.
��5 6
	IdEsquema
��6 ?
==
��@ B
	idEsquema
��C L
&&
��M O
v
��P Q
.
��Q R
Estado
��R X
==
��Y [

Constantes
��\ f
.
��f g
ESTADO_USUARIO_A
��g w
)
��w x
.
�� 
Select
�� 
(
�� 
v
�� 
=>
��  
v
��! "
.
��" #
IdEsquemaVista
��# 1
)
��1 2
.
�� 
FirstOrDefault
�� #
(
��# $
)
��$ %
;
��% &
if
�� 
(
�� 
idEsquemaVista
�� "
==
��# %
$num
��& '
)
��' (
{
�� 
return
�� 
false
��  
;
��  !
}
�� 
var
�� 
fechaActual
�� 
=
��  !
DateTime
��" *
.
��* +
Now
��+ .
;
��. /
foreach
�� 
(
�� 
var
�� 
item
�� !
in
��" $&
listaEsquemaVistaColumna
��% =
)
��= >
{
�� 
item
�� 
.
�� 
IdUserCreacion
�� '
=
��( )
$num
��* +
;
��+ ,
item
�� 
.
�� 
IdUserModifica
�� '
=
��( )
$num
��* +
;
��+ ,
item
�� 
.
�� 
FechaModifica
�� &
=
��' (
fechaActual
��) 4
;
��4 5
item
�� 
.
�� 
Estado
�� 
=
��  !

Constantes
��" ,
.
��, -
ESTADO_USUARIO_A
��- =
;
��= >
item
�� 
.
�� 
IdEsquemaVista
�� '
=
��( )
idEsquemaVista
��* 8
;
��8 9
}
�� 
context
�� 
.
�� !
EsquemaVistaColumna
�� +
.
��+ ,
AddRange
��, 4
(
��4 5&
listaEsquemaVistaColumna
��5 M
)
��M N
;
��N O
return
�� 
context
�� 
.
�� 
SaveChanges
�� *
(
��* +
)
��+ ,
>=
��- /
$num
��0 1
;
��1 2
}
�� 
)
�� 
;
�� 
}
�� 	
}
�� 
}�� �
[C:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\EsquemaFullTextRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 
class	 %
EsquemaFullTextRepository (
:) *
BaseRepository+ 9
,9 :&
IEsquemaFullTextRepository; U
{		 
public

 
%
EsquemaFullTextRepository

 $
(

$ %
ILogger 
< %
EsquemaFullTextRepository '
>' (
logger) /
,/ 0&
ISqlServerDbContextFactory  %
sqlServerDbContextFactory! :
) 
: 
base 
( %
sqlServerDbContextFactory &
,& '
logger( .
). /
{ 
} 
public 

EsquemaFullText 
Create !
(! "
EsquemaFullText" 1
data2 6
)6 7
{ 
data 

.
 
IdEsquemaFullText 
= 
$num  
;  !
return 
ExecuteDbOperation 
(  
context  '
=>( *
{+ ,
context 
. 
EsquemaFullText 
.  
Add  #
(# $
data$ (
)( )
;) *
context 
. 
SaveChanges 
( 
) 
; 
return 
data 
; 
} 
) 
; 	
} 
public 
async 
Task 
< 
EsquemaFullText )
>) *
CreateAsync+ 6
(6 7
EsquemaFullText7 F
dataG K
)K L
{ 	
data 
. 
IdEsquemaFullText "
=# $
$num% &
;& '
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{1 2
context 
. 
EsquemaFullText '
.' (
Add( +
(+ ,
data, 0
)0 1
;1 2
context   
.   
SaveChanges   #
(  # $
)  $ %
;  % &
return!! 
data!! 
;!! 
}"" 
)"" 
;"" 
}## 	
public$$ 
EsquemaFullText$$ 
?$$ 
FindById$$  (
($$( )
int$$) ,
id$$- /
)$$/ 0
{%% 
return&& 
ExecuteDbOperation&& 
(&&  
context&&  '
=>&&( *
context&&+ 2
.&&2 3
EsquemaFullText&&3 B
.&&B C
AsNoTracking&&C O
(&&O P
)&&P Q
.&&Q R
FirstOrDefault&&R `
(&&` a
u&&a b
=>&&c e
u&&f g
.&&g h
IdEsquemaFullText&&h y
==&&z |
id&&} 
)	&& �
)
&&� �
;
&&� �
}'' 
}(( 
})) ��
WC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\EsquemaDataRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{		 
public

 

class

 !
EsquemaDataRepository

 &
:

' (
BaseRepository

) 7
,

7 8"
IEsquemaDataRepository

9 O
{ 
public !
EsquemaDataRepository $
($ %
ILogger
 
< !
EsquemaDataRepository '
>' (
logger) /
,/ 0&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
EsquemaData 
? 
Create "
(" #
EsquemaData# .
data/ 3
)3 4
{ 	
data 
. 
IdEsquemaData 
=  
$num! "
;" #
try 
{ 
return 
ExecuteDbOperation )
() *
context* 1
=>2 4
{ 
context 
. 
EsquemaData '
.' (
Add( +
(+ ,
data, 0
)0 1
;1 2
context 
. 
SaveChanges '
(' (
)( )
;) *
return 
data 
;  
} 
) 
; 
} 
catch 
( 
	Exception 
e 
) 
{   
Console!! 
.!! 
	WriteLine!! !
(!!! "
e!!" #
)!!# $
;!!$ %
return"" 
null"" 
;"" 
}## 
}$$ 	
public%% 
async%% 
Task%% 
<%% 
EsquemaData%% %
?%%% &
>%%& '
CreateAsync%%( 3
(%%3 4
EsquemaData%%4 ?
data%%@ D
)%%D E
{&& 	
data'' 
.'' 
IdEsquemaData'' 
=''  
$num''! "
;''" #
try)) 
{** 
return++ 
await++ 
ExecuteDbOperation++ /
(++/ 0
async++0 5
context++6 =
=>++> @
{,, 
context-- 
.-- 
EsquemaData-- '
.--' (
Add--( +
(--+ ,
data--, 0
)--0 1
;--1 2
await.. 
context.. !
...! "
SaveChangesAsync.." 2
(..2 3
)..3 4
;..4 5
return// 
data// 
;//  
}00 
)00 
;00 
}11 
catch22 
(22 
	Exception22 
e22 
)22 
{33 
Console55 
.55 
	WriteLine55 !
(55! "
$"55" $
$str55$ @
{55@ A
e55A B
.55B C
Message55C J
}55J K
"55K L
)55L M
;55M N
return66 
null66 
;66 
}77 
}88 	
public:: 
EsquemaData:: 
?:: 
FindById:: $
(::$ %
int::% (
Id::) +
)::+ ,
{;; 	
return<< 
ExecuteDbOperation<< %
(<<% &
context<<& -
=><<. 0
context<<1 8
.<<8 9
EsquemaData<<9 D
.<<D E
AsNoTracking<<E Q
(<<Q R
)<<R S
.<<S T
FirstOrDefault<<T b
(<<b c
u<<c d
=><<e g
u<<h i
.<<i j
IdEsquemaData<<j w
==<<x z
Id<<{ }
)<<} ~
)<<~ 
;	<< �
}== 	
public>> 
ICollection>> 
<>> 
EsquemaData>> &
>>>& '
FindAll>>( /
(>>/ 0
)>>0 1
{?? 	
return@@ 
ExecuteDbOperation@@ %
(@@% &
context@@& -
=>@@. 0
context@@1 8
.@@8 9
EsquemaData@@9 D
.@@D E
AsNoTracking@@E Q
(@@Q R
)@@R S
.@@S T
OrderBy@@T [
(@@[ \
c@@\ ]
=>@@^ `
c@@a b
.@@b c
IdEsquemaData@@c p
)@@p q
.@@q r
ToList@@r x
(@@x y
)@@y z
)@@z {
;@@{ |
}AA 	
publicBB 
boolBB 
UpdateBB 
(BB 
EsquemaDataBB &
	newRecordBB' 0
)BB0 1
{CC 	
returnDD 
ExecuteDbOperationDD %
(DD% &
contextDD& -
=>DD. 0
{EE 
varFF 
currentRecordFF !
=FF" #!
MergeEntityPropertiesFF$ 9
(FF9 :
contextFF: A
,FFA B
	newRecordFFC L
,FFL M
uFFN O
=>FFP R
uFFS T
.FFT U
IdEsquemaDataFFU b
==FFc e
	newRecordFFf o
.FFo p
IdEsquemaDataFFp }
)FF} ~
;FF~ 
contextGG 
.GG 
EsquemaDataGG #
.GG# $
UpdateGG$ *
(GG* +
currentRecordGG+ 8
)GG8 9
;GG9 :
returnHH 
contextHH 
.HH 
SaveChangesHH *
(HH* +
)HH+ ,
>=HH- /
$numHH0 1
;HH1 2
}II 
)II 
;II 
}JJ 	
publicKK 
intKK 
	GetLastIdKK 
(KK 
)KK 
{LL 	
returnMM 
ExecuteDbOperationMM %
(MM% &
contextMM& -
=>MM. 0
contextMM1 8
.MM8 9
EsquemaDataMM9 D
.MMD E
AsNoTrackingMME Q
(MMQ R
)MMR S
.MMS T
MaxMMT W
(MMW X
cMMX Y
=>MMZ \
cMM] ^
.MM^ _
IdEsquemaDataMM_ l
)MMl m
)MMm n
;MMn o
}NN 	
publicOO 
boolOO 
DeleteOldRecordsOO $
(OO$ %
intOO% (
idONAOO) .
)OO. /
{PP 	
tryQQ 
{RR 
returnSS 
ExecuteDbOperationSS )
(SS) *
contextSS* 1
=>SS2 4
{TT 
varVV 
esquemaVistasVV %
=VV& '
contextVV( /
.VV/ 0
EsquemaVistaVV0 <
.WW 
WhereWW 
(WW 
evWW !
=>WW" $
evWW% '
.WW' (
IdONAWW( -
==WW. 0
idONAWW1 6
)WW6 7
.XX 
ToListXX 
(XX  
)XX  !
;XX! "
ifZZ 
(ZZ 
esquemaVistasZZ %
==ZZ& (
nullZZ) -
||ZZ. 0
!ZZ1 2
esquemaVistasZZ2 ?
.ZZ? @
AnyZZ@ C
(ZZC D
)ZZD E
)ZZE F
{[[ 
Console\\ 
.\\  
	WriteLine\\  )
(\\) *
$"\\* ,
$str\\, d
{\\d e
idONA\\e j
}\\j k
"\\k l
)\\l m
;\\m n
return]] 
false]] $
;]]$ %
}^^ 
List`` 
<`` 
int`` 
>`` 
idEsquemaVistaList`` 0
=``1 2
esquemaVistas``3 @
.aa 
Whereaa 
(aa 
evaa !
=>aa" $
evaa% '
.aa' (
IdEsquemaVistaaa( 6
!=aa7 9
nullaa: >
)aa> ?
.bb 
Selectbb 
(bb  
evbb  "
=>bb# %
evbb& (
.bb( )
IdEsquemaVistabb) 7
)bb7 8
.cc 
ToListcc 
(cc  
)cc  !
;cc! "
varff 
esquemaDataRecordsff *
=ff+ ,
contextff- 4
.ff4 5
EsquemaDataff5 @
.gg 
Wheregg 
(gg 
edgg !
=>gg" $
idEsquemaVistaListgg% 7
.gg7 8
Containsgg8 @
(gg@ A
edggA C
.ggC D
IdEsquemaVistaggD R
)ggR S
)ggS T
.hh 
ToListhh 
(hh  
)hh  !
;hh! "
ifjj 
(jj 
esquemaDataRecordsjj *
==jj+ -
nulljj. 2
||jj3 5
!jj6 7
esquemaDataRecordsjj7 I
.jjI J
AnyjjJ M
(jjM N
)jjN O
)jjO P
{kk 
Consolell 
.ll  
	WriteLinell  )
(ll) *
$"ll* ,
$str	ll, �
{
ll� �
idONA
ll� �
}
ll� �
"
ll� �
)
ll� �
;
ll� �
returnmm 
falsemm $
;mm$ %
}nn 
Listpp 
<pp 
intpp 
>pp 
idEsquemaDataListpp /
=pp0 1
esquemaDataRecordspp2 D
.qq 
Whereqq 
(qq 
edqq !
=>qq" $
edqq% '
.qq' (
IdEsquemaDataqq( 5
!=qq6 8
nullqq9 =
)qq= >
.rr 
Selectrr 
(rr  
edrr  "
=>rr# %
edrr& (
.rr( )
IdEsquemaDatarr) 6
)rr6 7
.ss 
ToListss 
(ss  
)ss  !
;ss! "
ifuu 
(uu 
idEsquemaDataListuu )
.uu) *
Anyuu* -
(uu- .
)uu. /
)uu/ 0
{vv 
varxx "
esquemaFullTextRecordsxx 2
=xx3 4
contextxx5 <
.xx< =
EsquemaFullTextxx= L
.yy 
Whereyy "
(yy" #
efyy# %
=>yy& (
idEsquemaDataListyy) :
.yy: ;
Containsyy; C
(yyC D
efyyD F
.yyF G
IdEsquemaDatayyG T
)yyT U
)yyU V
.zz 
ToListzz #
(zz# $
)zz$ %
;zz% &
if|| 
(|| "
esquemaFullTextRecords|| 2
!=||3 5
null||6 :
&&||; ="
esquemaFullTextRecords||> T
.||T U
Any||U X
(||X Y
)||Y Z
)||Z [
{}} 
context~~ #
.~~# $
EsquemaFullText~~$ 3
.~~3 4
RemoveRange~~4 ?
(~~? @"
esquemaFullTextRecords~~@ V
)~~V W
;~~W X
context #
.# $
SaveChanges$ /
(/ 0
)0 1
;1 2
}
�� 
}
�� 
if
�� 
(
��  
esquemaDataRecords
�� *
.
��* +
Any
��+ .
(
��. /
)
��/ 0
)
��0 1
{
�� 
context
�� 
.
��  
EsquemaData
��  +
.
��+ ,
RemoveRange
��, 7
(
��7 8 
esquemaDataRecords
��8 J
)
��J K
;
��K L
context
�� 
.
��  
SaveChanges
��  +
(
��+ ,
)
��, -
;
��- .
}
�� 
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$"
��& (
$str
��( W
{
��W X
idONA
��X ]
}
��] ^
"
��^ _
)
��_ `
;
��` a
var
�� 
data
�� 
=
�� 
new
�� "
LogMigracion
��# /
{
�� 
IdONA
�� 
=
�� 
idONA
��  %
,
��% &
Observacion
�� #
=
��$ %
$str
��& S
}
�� 
;
�� 
return
�� 
true
�� 
;
��  
}
�� 
)
�� 
;
�� 
}
�� 
catch
�� 
(
�� #
SqlNullValueException
�� (
ex
��) +
)
��+ ,
{
�� 
Console
�� 
.
�� 
	WriteLine
�� !
(
��! "
$"
��" $
$str
��$ g
{
��g h
ex
��h j
.
��j k
Message
��k r
}
��r s
"
��s t
)
��t u
;
��u v
return
�� 
false
�� 
;
�� 
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
Console
�� 
.
�� 
	WriteLine
�� !
(
��! "
$"
��" $
$str
��$ 3
{
��3 4
ex
��4 6
.
��6 7
Message
��7 >
}
��> ?
"
��? @
)
��@ A
;
��A B
return
�� 
false
�� 
;
�� 
}
�� 
}
�� 	
public
�� 
bool
�� 
DeleteDataAntigua
�� %
(
��% &
int
��& )
idONA
��* /
)
��/ 0
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
using
�� 
(
�� 
var
�� 
transaction
�� &
=
��' (
context
��) 0
.
��0 1
Database
��1 9
.
��9 :
BeginTransaction
��: J
(
��J K
)
��K L
)
��L M
{
�� 
try
�� 
{
�� 
var
�� 
esquemaDataIds
�� *
=
��+ ,
context
��- 4
.
��4 5
EsquemaData
��5 @
.
�� 
Where
�� "
(
��" #
d
��# $
=>
��% '
context
��( /
.
��/ 0
EsquemaVista
��0 <
.
��  !
Any
��! $
(
��$ %
v
��% &
=>
��' )
v
��* +
.
��+ ,
IdEsquemaVista
��, :
==
��; =
d
��> ?
.
��? @
IdEsquemaVista
��@ N
&&
��O Q
v
��R S
.
��S T
IdONA
��T Y
==
��Z \
idONA
��] b
)
��b c
)
��c d
.
�� 
Select
�� #
(
��# $
d
��$ %
=>
��& (
d
��) *
.
��* +
IdEsquemaData
��+ 8
)
��8 9
.
�� 
ToList
�� #
(
��# $
)
��$ %
;
��% &
if
�� 
(
�� 
esquemaDataIds
�� *
.
��* +
Any
��+ .
(
��. /
)
��/ 0
)
��0 1
{
�� 
var
�� 
esquemaFullText
��  /
=
��0 1
context
��2 9
.
��9 :
EsquemaFullText
��: I
.
��  !
Where
��! &
(
��& '
e
��' (
=>
��) +
esquemaDataIds
��, :
.
��: ;
Contains
��; C
(
��C D
e
��D E
.
��E F
IdEsquemaData
��F S
)
��S T
)
��T U
;
��U V
context
�� #
.
��# $
EsquemaFullText
��$ 3
.
��3 4
RemoveRange
��4 ?
(
��? @
esquemaFullText
��@ O
)
��O P
;
��P Q
context
�� #
.
��# $
SaveChanges
��$ /
(
��/ 0
)
��0 1
;
��1 2
var
�� 
esquemaData
��  +
=
��, -
context
��. 5
.
��5 6
EsquemaData
��6 A
.
��  !
Where
��! &
(
��& '
d
��' (
=>
��) +
esquemaDataIds
��, :
.
��: ;
Contains
��; C
(
��C D
d
��D E
.
��E F
IdEsquemaData
��F S
)
��S T
)
��T U
;
��U V
context
�� #
.
��# $
EsquemaData
��$ /
.
��/ 0
RemoveRange
��0 ;
(
��; <
esquemaData
��< G
)
��G H
;
��H I
context
�� #
.
��# $
SaveChanges
��$ /
(
��/ 0
)
��0 1
;
��1 2
}
�� 
transaction
�� #
.
��# $
Commit
��$ *
(
��* +
)
��+ ,
;
��, -
return
�� 
true
�� #
;
��# $
}
�� 
catch
�� 
(
�� 
	Exception
�� $
ex
��% '
)
��' (
{
�� 
transaction
�� #
.
��# $
Rollback
��$ ,
(
��, -
)
��- .
;
��. /
Console
�� 
.
��  
	WriteLine
��  )
(
��) *
$"
��* ,
$str
��, D
{
��D E
ex
��E G
.
��G H
Message
��H O
}
��O P
"
��P Q
)
��Q R
;
��R S
return
�� 
false
�� $
;
��$ %
}
�� 
}
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
bool
�� 
>
�� #
DeleteOldRecordsAsync
��  5
(
��5 6
int
��6 9
IdEsquemaVista
��: H
)
��H I
{
�� 	
return
�� 
await
��  
ExecuteDbOperation
�� +
(
��+ ,
async
��, 1
context
��2 9
=>
��: <
{
�� 
var
�� 
records
�� 
=
�� 
await
�� #
context
��$ +
.
��+ ,
EsquemaData
��, 7
.
�� 
Where
�� 
(
�� 
c
�� 
=>
�� 
c
��  !
.
��! "
IdEsquemaVista
��" 0
==
��1 3
IdEsquemaVista
��4 B
)
��B C
.
�� 
ToListAsync
��  
(
��  !
)
��! "
;
��" #
if
�� 
(
�� 
records
�� 
.
�� 
Any
�� 
(
��  
)
��  !
)
��! "
{
�� 
var
�� 
deletedRecordIds
�� (
=
��) *
records
��+ 2
.
��2 3
Select
��3 9
(
��9 :
r
��: ;
=>
��< >
r
��? @
.
��@ A
IdEsquemaData
��A N
)
��N O
.
��O P
ToList
��P V
(
��V W
)
��W X
;
��X Y
var
�� '
deletedCanFullTextRecords
�� 1
=
��2 3
await
��4 9
context
��: A
.
��A B
EsquemaFullText
��B Q
.
�� 
Where
�� 
(
�� 
o
��  
=>
��! #
deletedRecordIds
��$ 4
.
��4 5
Contains
��5 =
(
��= >
o
��> ?
.
��? @
IdEsquemaData
��@ M
)
��M N
)
��N O
.
�� 
ToListAsync
�� $
(
��$ %
)
��% &
;
��& '
if
�� 
(
�� '
deletedCanFullTextRecords
�� 1
.
��1 2
Any
��2 5
(
��5 6
)
��6 7
)
��7 8
{
�� 
context
�� 
.
��  
EsquemaFullText
��  /
.
��/ 0
RemoveRange
��0 ;
(
��; <'
deletedCanFullTextRecords
��< U
)
��U V
;
��V W
}
�� 
context
�� 
.
�� 
EsquemaData
�� '
.
��' (
RemoveRange
��( 3
(
��3 4
records
��4 ;
)
��; <
;
��< =
await
�� 
context
�� !
.
��! "
SaveChangesAsync
��" 2
(
��2 3
)
��3 4
;
��4 5
}
�� 
return
�� 
true
�� 
;
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
bool
�� 
DeleteOnaRecords
�� $
(
��$ %
int
��% (

IdConexion
��) 3
)
��3 4
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
var
�� 
records
�� 
=
�� 
new
�� !
List
��" &
<
��& '
EsquemaData
��' 2
>
��2 3
(
��3 4
)
��4 5
;
��5 6
List
�� 
<
�� 
int
�� 
>
�� 
deletedRecordIds
�� *
=
��+ ,
records
��- 4
.
��4 5
Select
��5 ;
(
��; <
r
��< =
=>
��> @
r
��A B
.
��B C
IdEsquemaData
��C P
)
��P Q
.
��Q R
ToList
��R X
(
��X Y
)
��Y Z
;
��Z [
var
�� '
deletedCanFullTextRecords
�� -
=
��. /
context
��0 7
.
��7 8
EsquemaFullText
��8 G
.
��G H
Where
��H M
(
��M N
o
��N O
=>
��P R
deletedRecordIds
��S c
.
��c d
Contains
��d l
(
��l m
o
��m n
.
��n o
IdEsquemaData
��o |
)
��| }
)
��} ~
.
��~ 
ToList�� �
(��� �
)��� �
;��� �
context
�� 
.
�� 
EsquemaFullText
�� '
.
��' (
RemoveRange
��( 3
(
��3 4'
deletedCanFullTextRecords
��4 M
)
��M N
;
��N O
context
�� 
.
�� 
SaveChanges
�� #
(
��# $
)
��$ %
;
��% &
context
�� 
.
�� 
EsquemaData
�� #
.
��# $
RemoveRange
��$ /
(
��/ 0
records
��0 7
)
��7 8
;
��8 9
context
�� 
.
�� 
SaveChanges
�� #
(
��# $
)
��$ %
;
��% &
return
�� 
true
�� 
;
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
bool
�� 
DeleteOldRecord
�� #
(
��# $
string
��$ *
idVista
��+ 2
,
��2 3
string
��4 :
idEnte
��; A
,
��A B
int
��C F

IdConexion
��G Q
,
��Q R
int
��S V#
idHomologacionEsquema
��W l
)
��l m
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
var
�� 
records
�� 
=
�� 
new
�� !
List
��" &
<
��& '
EsquemaData
��' 2
>
��2 3
(
��3 4
)
��4 5
;
��5 6
List
�� 
<
�� 
int
�� 
>
�� 
deletedRecordIds
�� *
=
��+ ,
records
��- 4
.
��4 5
Select
��5 ;
(
��; <
r
��< =
=>
��> @
r
��A B
.
��B C
IdEsquemaData
��C P
)
��P Q
.
��Q R
ToList
��R X
(
��X Y
)
��Y Z
;
��Z [
var
�� '
deletedCanFullTextRecords
�� -
=
��. /
context
��0 7
.
��7 8
EsquemaFullText
��8 G
.
��G H
Where
��H M
(
��M N
o
��N O
=>
��P R
deletedRecordIds
��S c
.
��c d
Contains
��d l
(
��l m
o
��m n
.
��n o
IdEsquemaData
��o |
)
��| }
)
��} ~
.
��~ 
ToList�� �
(��� �
)��� �
;��� �
context
�� 
.
�� 
EsquemaFullText
�� '
.
��' (
RemoveRange
��( 3
(
��3 4'
deletedCanFullTextRecords
��4 M
)
��M N
;
��N O
context
�� 
.
�� 
SaveChanges
�� #
(
��# $
)
��$ %
;
��% &
context
�� 
.
�� 
EsquemaData
�� #
.
��# $
RemoveRange
��$ /
(
��/ 0
records
��0 7
)
��7 8
;
��8 9
context
�� 
.
�� 
SaveChanges
�� #
(
��# $
)
��$ %
;
��% &
return
�� 
true
�� 
;
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
bool
�� '
DeleteByExcludingVistaIds
�� -
(
��- .
List
��. 2
<
��2 3
string
��3 9
>
��9 :
idsVista
��; C
,
��C D
string
��E K
idEnte
��L R
,
��R S
int
��T W

idConexion
��X b
,
��b c
int
��d g
idEsquemaData
��h u
)
��u v
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
var
�� 
records
�� 
=
�� 
new
�� !
List
��" &
<
��& '
EsquemaData
��' 2
>
��2 3
(
��3 4
)
��4 5
;
��5 6
List
�� 
<
�� 
int
�� 
>
�� 
deletedRecordIds
�� *
=
��+ ,
records
��- 4
.
��4 5
Select
��5 ;
(
��; <
r
��< =
=>
��> @
r
��A B
.
��B C
IdEsquemaData
��C P
)
��P Q
.
��Q R
ToList
��R X
(
��X Y
)
��Y Z
;
��Z [
var
�� '
deletedCanFullTextRecords
�� -
=
��. /
context
��0 7
.
��7 8
EsquemaFullText
��8 G
.
��G H
Where
��H M
(
��M N
o
��N O
=>
��P R
deletedRecordIds
��S c
.
��c d
Contains
��d l
(
��l m
o
��m n
.
��n o
IdEsquemaData
��o |
)
��| }
)
��} ~
.
��~ 
ToList�� �
(��� �
)��� �
;��� �
context
�� 
.
�� 
EsquemaFullText
�� '
.
��' (
RemoveRange
��( 3
(
��3 4'
deletedCanFullTextRecords
��4 M
)
��M N
;
��N O
context
�� 
.
�� 
SaveChanges
�� #
(
��# $
)
��$ %
;
��% &
context
�� 
.
�� 
EsquemaData
�� #
.
��# $
RemoveRange
��$ /
(
��/ 0
records
��0 7
)
��7 8
;
��8 9
context
�� 
.
�� 
SaveChanges
�� #
(
��# $
)
��$ %
;
��% &
return
�� 
true
�� 
;
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
}
�� 
}�� ��
SC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\DynamicRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

class 
DynamicRepository "
:# $
BaseRepository% 3
,3 4
IDynamicRepository5 G
{ 
private 
readonly *
IConectionStringBuilderService 7+
_connectionStringBuilderService8 W
;W X
private 
readonly 
IDbContextFactory *
_dbContextFactory+ <
;< =
private 
readonly 
ILogger  
<  !
DynamicRepository! 2
>2 3
_logger4 ;
;; <
private 
readonly 
	IMigrador "
	_migrador# ,
;, -
public 
DynamicRepository  
(  !
IDbContextFactory
 
dbContextFactory ,
,, -
ILogger
 
< 
DynamicRepository #
># $
logger% +
,+ ,&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
,> ?*
IConectionStringBuilderService
 (*
connectionStringBuilderService) G
,G H
	IMigrador
 
migrador 
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	+
_connectionStringBuilderService +
=, -*
connectionStringBuilderService. L
;L M
_dbContextFactory 
= 
dbContextFactory  0
;0 1
_logger 
= 
logger 
; 
	_migrador 
= 
migrador  
;  !
}   	
public!! 
List!! 
<!! 
PropiedadesTablaDto!! '
>!!' (
GetProperties!!) 6
(!!6 7
int!!7 :
idONA!!; @
,!!@ A
string!!B H
viewName!!I Q
)!!Q R
{"" 	
var## 
conexion## 
=## 
GetConexion## &
(##& '
idONA##' ,
)##, -
;##- .
using$$ 
var$$ 
context$$ 
=$$ 

GetContext$$  *
($$* +
conexion$$+ 3
)$$3 4
;$$4 5
using%% 
var%% 

connection%%  
=%%! "
context%%# *
.%%* +
Database%%+ 3
.%%3 4
GetDbConnection%%4 C
(%%C D
)%%D E
;%%E F

connection&& 
.&& 
Open&& 
(&& 
)&& 
;&& 
var(( 
columnNames(( 
=(( 
new(( !
List((" &
<((& '
PropiedadesTablaDto((' :
>((: ;
(((; <
)((< =
;((= >
using)) 
var)) 
command)) 
=)) 

connection))  *
.))* +
CreateCommand))+ 8
())8 9
)))9 :
;)): ;
command** 
.** 
CommandText** 
=**  !
$"**" $
$str**$ 8
{**8 9
viewName**9 A
}**A B
"**B C
;**C D
using++ 
var++ 
reader++ 
=++ 
command++ &
.++& '
ExecuteReader++' 4
(++4 5
CommandBehavior++5 D
.++D E

SchemaOnly++E O
)++O P
;++P Q
var,, 
schemaTable,, 
=,, 
reader,, $
.,,$ %
GetSchemaTable,,% 3
(,,3 4
),,4 5
;,,5 6
if.. 
(.. 
schemaTable.. 
==.. 
null.. #
)..# $
{// 
_logger00 
.00 

LogWarning00 "
(00" #
$"00# %
$str00% Q
{00Q R
viewName00R Z
}00Z [
"00[ \
)00\ ]
;00] ^
return11 
columnNames11 "
;11" #
}22 
foreach44 
(44 
DataRow44 
row44  
in44! #
schemaTable44$ /
.44/ 0
Rows440 4
)444 5
{55 
columnNames66 
.66 
Add66 
(66  
new66  #
PropiedadesTablaDto66$ 7
{77 
NombreColumna88 !
=88" #
row88$ '
[88' (
$str88( 4
]884 5
.885 6
ToString886 >
(88> ?
)88? @
}99 
)99 
;99 
}:: 
return<< 
columnNames<< 
;<< 
}== 	
public>> 
List>> 
<>> 
PropiedadesTablaDto>> '
>>>' (
GetValueColumna>>) 8
(>>8 9
int>>9 <
idONA>>= B
,>>B C
string>>D J
valueColumn>>K V
,>>V W
string>>X ^
viewName>>_ g
)>>g h
{?? 	
var@@ 
conexion@@ 
=@@ 
GetConexion@@ &
(@@& '
idONA@@' ,
)@@, -
;@@- .
usingAA 
varAA 
contextAA 
=AA 

GetContextAA  *
(AA* +
conexionAA+ 3
)AA3 4
;AA4 5
usingBB 
varBB 

connectionBB  
=BB! "
contextBB# *
.BB* +
DatabaseBB+ 3
.BB3 4
GetDbConnectionBB4 C
(BBC D
)BBD E
;BBE F

connectionCC 
.CC 
OpenCC 
(CC 
)CC 
;CC 
varEE 
columnNamesEE 
=EE 
newEE !
ListEE" &
<EE& '
PropiedadesTablaDtoEE' :
>EE: ;
(EE; <
)EE< =
;EE= >
usingFF 
varFF 
commandFF 
=FF 

connectionFF  *
.FF* +
CreateCommandFF+ 8
(FF8 9
)FF9 :
;FF: ;
commandGG 
.GG 
CommandTextGG 
=GG  !
$"GG" $
$strGG$ 1
{GG1 2
valueColumnGG2 =
}GG= >
$strGG> D
{GGD E
viewNameGGE M
}GGM N
"GGN O
;GGO P
usingHH 
varHH 
readerHH 
=HH 
commandHH &
.HH& '
ExecuteReaderHH' 4
(HH4 5
CommandBehaviorHH5 D
.HHD E

SchemaOnlyHHE O
)HHO P
;HHP Q
varII 
schemaTableII 
=II 
readerII $
.II$ %
GetSchemaTableII% 3
(II3 4
)II4 5
;II5 6
ifKK 
(KK 
schemaTableKK 
==KK 
nullKK #
)KK# $
{LL 
_loggerMM 
.MM 

LogWarningMM "
(MM" #
$"MM# %
$strMM% Q
{MMQ R
viewNameMMR Z
}MMZ [
"MM[ \
)MM\ ]
;MM] ^
returnNN 
columnNamesNN "
;NN" #
}OO 
foreachQQ 
(QQ 
DataRowQQ 
rowQQ  
inQQ! #
schemaTableQQ$ /
.QQ/ 0
RowsQQ0 4
)QQ4 5
{RR 
columnNamesSS 
.SS 
AddSS 
(SS  
newSS  #
PropiedadesTablaDtoSS$ 7
{TT 
NombreColumnaUU !
=UU" #
rowUU$ '
[UU' (
$strUU( 4
]UU4 5
.UU5 6
ToStringUU6 >
(UU> ?
)UU? @
}VV 
)VV 
;VV 
}WW 
returnYY 
columnNamesYY 
;YY 
}ZZ 	
public[[ 
List[[ 
<[[ 
string[[ 
>[[ 
GetViewNames[[ (
([[( )
int[[) ,
idONA[[- 2
)[[2 3
{\\ 	
var]] 
conexion]] 
=]] 
GetConexion]] &
(]]& '
idONA]]' ,
)]], -
;]]- .
using^^ 
var^^ 
context^^ 
=^^ 

GetContext^^  *
(^^* +
conexion^^+ 3
)^^3 4
;^^4 5
using__ 
var__ 

connection__  
=__! "
context__# *
.__* +
Database__+ 3
.__3 4
GetDbConnection__4 C
(__C D
)__D E
;__E F

connection`` 
.`` 
Open`` 
(`` 
)`` 
;`` 
varbb 
	viewNamesbb 
=bb 
newbb 
Listbb  $
<bb$ %
stringbb% +
>bb+ ,
(bb, -
)bb- .
;bb. /
usingcc 
varcc 
commandcc 
=cc 

connectioncc  *
.cc* +
CreateCommandcc+ 8
(cc8 9
)cc9 :
;cc: ;
switchee 
(ee 
conexionee 
.ee 
OrigenDatosee (
)ee( )
{ff 
casegg 
$strgg 
:gg 
commandhh 
.hh 
CommandTexthh '
=hh( )
$strhh* {
;hh{ |
breakii 
;ii 
casejj 
$strjj 
:jj  
commandkk 
.kk 
CommandTextkk '
=kk( )
$strkk* y
;kky z
breakll 
;ll 
defaultmm 
:mm 
commandnn 
.nn 
CommandTextnn '
=nn( )
$strnn* [
;nn[ \
breakoo 
;oo 
}pp 
usingrr 
varrr 
readerrr 
=rr 
commandrr &
.rr& '
ExecuteReaderrr' 4
(rr4 5
)rr5 6
;rr6 7
whiless 
(ss 
readerss 
.ss 
Readss 
(ss 
)ss  
)ss  !
{tt 
	viewNamesuu 
.uu 
Adduu 
(uu 
readeruu $
.uu$ %
	GetStringuu% .
(uu. /
$numuu/ 0
)uu0 1
)uu1 2
;uu2 3
}vv 
returnxx 
	viewNamesxx 
;xx 
}yy 	
privatezz 
	DbContextzz 

GetContextzz $
(zz$ %
ONAConexionzz% 0
conexionzz1 9
)zz9 :
{{{ 	
var|| 
connectionString||  
=||! "+
_connectionStringBuilderService||# B
.||B C!
BuildConnectionString||C X
(||X Y
conexion||Y a
)||a b
;||b c
return}} 
conexion}} 
.}} 
OrigenDatos}} '
switch}}( .
{~~ 
$str 
=> 
_dbContextFactory ,
., -
CreateDbContext- <
(< =
connectionString= M
,M N
DatabaseTypeO [
.[ \
MYSQL\ a
)a b
,b c
_
�� 
=>
�� 
_dbContextFactory
�� &
.
��& '
CreateDbContext
��' 6
(
��6 7
connectionString
��7 G
,
��G H
DatabaseType
��I U
.
��U V
	SQLSERVER
��V _
)
��_ `
}
�� 
;
�� 
}
�� 	
public
�� 
ONAConexion
�� 
GetConexion
�� &
(
��& '
int
��' *
idONA
��+ 0
)
��0 1
{
�� 	
var
�� 
conexion
�� 
=
��  
ExecuteDbOperation
�� -
(
��- .
context
��. 5
=>
��6 8
context
��9 @
.
��@ A
ONAConexion
��A L
.
��L M
AsNoTracking
��M Y
(
��Y Z
)
��Z [
.
��[ \
FirstOrDefault
��\ j
(
��j k
u
��k l
=>
��m o
u
��p q
.
��q r
IdONA
��r w
==
��x z
idONA��{ �
)��� �
)��� �
;��� �
if
�� 
(
�� 
conexion
�� 
==
�� 
null
��  
)
��  !
{
�� 
var
�� 
message
�� 
=
�� 
$"
��  
$str
��  G
{
��G H
idONA
��H M
}
��M N
"
��N O
;
��O P
_logger
�� 
.
�� 

LogWarning
�� "
(
��" #
message
��# *
)
��* +
;
��+ ,
throw
�� 
new
�� 
	Exception
�� #
(
��# $
message
��$ +
)
��+ ,
;
��, -
}
�� 
return
�� 
conexion
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� 
EsquemaVistaDto
�� #
>
��# $'
GetListaValidacionEsquema
��% >
(
��> ?
int
��? B
idONA
��C H
,
��H I
int
��J M
	idEsquema
��N W
)
��W X
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
var
�� 
idEsquemaVista
�� "
=
��# $
context
��% ,
.
��, -
EsquemaVista
��- 9
.
�� 
Where
�� 
(
�� 
v
�� 
=>
�� 
v
��  !
.
��! "
IdONA
��" '
==
��( *
idONA
��+ 0
&&
��1 3
v
��4 5
.
��5 6
	IdEsquema
��6 ?
==
��@ B
	idEsquema
��C L
&&
��M O
v
��P Q
.
��Q R
Estado
��R X
==
��Y [

Constantes
��\ f
.
��f g
ESTADO_USUARIO_A
��g w
)
��w x
.
�� 
Select
�� 
(
�� 
v
�� 
=>
��  
v
��! "
.
��" #
IdEsquemaVista
��# 1
)
��1 2
.
�� 
FirstOrDefault
�� #
(
��# $
)
��$ %
;
��% &
if
�� 
(
�� 
idEsquemaVista
�� "
==
��# %
$num
��& '
)
��' (
{
�� 
return
�� 
new
�� 
List
�� #
<
��# $
EsquemaVistaDto
��$ 3
>
��3 4
(
��4 5
)
��5 6
;
��6 7
}
�� 
return
�� 
(
�� 
from
�� 
c
�� 
in
�� !
context
��" )
.
��) *!
EsquemaVistaColumna
��* =
where
�� 
c
�� 
.
��  
IdEsquemaVista
��  .
==
��/ 1
idEsquemaVista
��2 @
&&
��A C
c
��D E
.
��E F
Estado
��F L
==
��M O

Constantes
��P Z
.
��Z [
ESTADO_USUARIO_A
��[ k
select
�� 
new
�� "
EsquemaVistaDto
��# 2
{
�� 
NombreEsquema
�� )
=
��* +
c
��, -
.
��- .
ColumnaEsquema
��. <
,
��< =
NombreVista
�� '
=
��( )
c
��* +
.
��+ ,
ColumnaVista
��, 8
}
�� 
)
�� 
.
�� 
ToList
�� !
(
��! "
)
��" #
;
��# $
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
bool
�� $
TestDatabaseConnection
�� *
(
��* +
ONAConexion
��+ 6
conexion
��7 ?
)
��? @
{
�� 	
try
�� 
{
�� 
var
�� 
connectionString
�� $
=
��% &-
_connectionStringBuilderService
��' F
.
��F G#
BuildConnectionString
��G \
(
��\ ]
conexion
��] e
)
��e f
;
��f g
if
�� 
(
�� 
string
�� 
.
��  
IsNullOrWhiteSpace
�� -
(
��- .
connectionString
��. >
)
��> ?
)
��? @
{
�� 
_logger
�� 
.
�� 
LogError
�� $
(
��$ %
$str
��% M
)
��M N
;
��N O
return
�� 
false
��  
;
��  !
}
�� 
using
�� 
IDbConnection
�� #

connection
��$ .
=
��/ 0
conexion
��1 9
.
��9 :
OrigenDatos
��: E
.
��E F
ToUpper
��F M
(
��M N
)
��N O
switch
��P V
{
�� 
$str
�� 
=>
��  "
new
��# &
	Microsoft
��' 0
.
��0 1
Data
��1 5
.
��5 6
	SqlClient
��6 ?
.
��? @
SqlConnection
��@ M
(
��M N
connectionString
��N ^
)
��^ _
,
��_ `
$str
�� 
=>
�� 
new
�� "
MySqlConnection
��# 2
(
��2 3
connectionString
��3 C
)
��C D
,
��D E
$str
�� 
=>
�� !
new
��" %
Npgsql
��& ,
.
��, -
NpgsqlConnection
��- =
(
��= >
connectionString
��> N
)
��N O
,
��O P
_
�� 
=>
�� 
throw
�� 
new
�� "#
NotSupportedException
��# 8
(
��8 9
$"
��9 ;
$str
��; R
{
��R S
conexion
��S [
.
��[ \
OrigenDatos
��\ g
}
��g h
$str
��h w
"
��w x
)
��x y
}
�� 
;
�� 

connection
�� 
.
�� 
Open
�� 
(
��  
)
��  !
;
��! "
using
�� 
var
�� 
command
�� !
=
��" #

connection
��$ .
.
��. /
CreateCommand
��/ <
(
��< =
)
��= >
;
��> ?
command
�� 
.
�� 
CommandText
�� #
=
��$ %
$str
��& 0
;
��0 1
var
�� 
result
�� 
=
�� 
command
�� $
.
��$ %
ExecuteScalar
��% 2
(
��2 3
)
��3 4
;
��4 5
if
�� 
(
�� 
result
�� 
!=
�� 
null
�� "
&&
��# %
result
��& ,
!=
��- /
DBNull
��0 6
.
��6 7
Value
��7 <
&&
��= ?
Convert
��@ G
.
��G H
ToInt32
��H O
(
��O P
result
��P V
)
��V W
==
��X Z
$num
��[ \
)
��\ ]
{
�� 
_logger
�� 
.
�� 
LogInformation
�� *
(
��* +
$str
��+ [
)
��[ \
;
��\ ]
return
�� 
true
�� 
;
��  
}
�� 
_logger
�� 
.
�� 

LogWarning
�� "
(
��" #
$str
��# T
)
��T U
;
��U V
return
�� 
false
�� 
;
�� 
}
�� 
catch
�� 
(
�� 
MySqlException
�� !
ex
��" $
)
��$ %
{
�� 
Console
�� 
.
�� 
	WriteLine
�� !
(
��! "
$"
��" $
$str
��$ 4
{
��4 5
ex
��5 7
.
��7 8
Number
��8 >
}
��> ?
$str
��? B
{
��B C
ex
��C E
.
��E F
Message
��F M
}
��M N
"
��N O
)
��O P
;
��P Q
if
�� 
(
�� 
ex
�� 
.
�� 
Number
�� 
==
��  
$num
��! %
)
��% &
{
�� 
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$str
��& O
)
��O P
;
��P Q
}
�� 
else
�� 
if
�� 
(
�� 
ex
�� 
.
�� 
Number
�� "
==
��# %
$num
��& *
)
��* +
{
�� 
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$str
��& I
)
��I J
;
��J K
}
�� 
else
�� 
if
�� 
(
�� 
ex
�� 
.
�� 
Number
�� "
==
��# %
$num
��& *
)
��* +
{
�� 
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$str
��& b
)
��b c
;
��c d
}
�� 
return
�� 
false
�� 
;
�� 
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
Console
�� 
.
�� 
	WriteLine
�� !
(
��! "
$"
��" $
$str
��$ 3
{
��3 4
ex
��4 6
.
��6 7
Message
��7 >
}
��> ?
"
��? @
)
��@ A
;
��A B
return
�� 
false
�� 
;
�� 
}
�� 
}
�� 	
public
�� 
async
�� 
Task
�� 
<
�� 
bool
�� 
>
�� !
MigrarConexionAsync
��  3
(
��3 4
int
��4 7
idONA
��8 =
)
��= >
{
�� 	
try
�� 
{
�� 
var
�� 
conexion
�� 
=
�� 
GetConexion
�� *
(
��* +
idONA
��+ 0
)
��0 1
;
��1 2
if
�� 
(
�� 
conexion
�� 
==
�� 
null
��  $
)
��$ %
{
�� 
_logger
�� 
.
�� 

LogWarning
�� &
(
��& '
$"
��' )
$str
��) L
{
��L M
idONA
��M R
}
��R S
"
��S T
)
��T U
;
��U V
return
�� 
false
��  
;
��  !
}
�� 
bool
�� 
	resultado
�� 
=
��  
await
��! &
	_migrador
��' 0
.
��0 1
MigrarAsync
��1 <
(
��< =
conexion
��= E
)
��E F
;
��F G
if
�� 
(
�� 
	resultado
�� 
)
�� 
{
�� 
_logger
�� 
.
�� 
LogInformation
�� *
(
��* +
$"
��+ -
$str
��- W
{
��W X
idONA
��X ]
}
��] ^
"
��^ _
)
��_ `
;
��` a
}
�� 
else
�� 
{
�� 
_logger
�� 
.
�� 

LogWarning
�� &
(
��& '
$"
��' )
$str
��) V
{
��V W
idONA
��W \
}
��\ ]
"
��] ^
)
��^ _
;
��_ `
}
�� 
return
�� 
	resultado
��  
;
��  !
}
�� 
catch
�� 
(
�� 
	Exception
�� 
ex
�� 
)
��  
{
�� 
_logger
�� 
.
�� 
LogError
��  
(
��  !
$"
��! #
$str
��# H
{
��H I
idONA
��I N
}
��N O
$str
��O Q
{
��Q R
ex
��R T
.
��T U
Message
��U \
}
��\ ]
"
��] ^
)
��^ _
;
��_ `
return
�� 
false
�� 
;
�� 
}
�� 
}
�� 	
}
�� 
}�� ƈ
UC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\CatalogosRepository.cs
	namespace		 	

DataAccess		
 
.		 
Repositories		 !
{

 
public 

class 
CatalogosRepository $
:% &
BaseRepository' 5
,5 6 
ICatalogosRepository7 K
{ 
public 
CatalogosRepository "
(" #
ILogger
 
< 
CatalogosRepository %
>% &
logger' -
,- .&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
List 
< 
VwGrilla 
> 
ObtenerVwGrilla -
(- .
). /
{ 	
return   
ExecuteDbOperation   %
(  % &
context  & -
=>  . 0
context!! 
.!! 
VwGrilla!! 
."" 
AsNoTracking"" 
("" 
)"" 
.## 
OrderBy## 
(## 
c## 
=>## 
c## 
.##  
MostrarWebOrden##  /
)##/ 0
.$$ 
ToList$$ 
($$ 
)$$ 
)$$ 
;$$ 
}%% 	
public(( 
List(( 
<(( 
VwFiltro(( 
>(( 
ObtenerVwFiltro(( -
(((- .
)((. /
{)) 	
return** 
ExecuteDbOperation** %
(**% &
context**& -
=>**. 0
context++ 
.++ 
VwFiltro++ 
.,, 
AsNoTracking,, 
(,, 
),, 
.-- 
OrderBy-- 
(-- 
c-- 
=>-- 
c-- 
.--  
MostrarWebOrden--  /
)--/ 0
... 
ToList.. 
(.. 
).. 
).. 
;.. 
}// 	
public11 
List11 
<11 
vw_FiltrosAnidados11 &
>11& '"
ObtenerFiltrosAnidados11( >
(11> ?
List11? C
<11C D'
FiltrosBusquedaSeleccionDto11D _
>11_ ` 
filtrosSeleccionados11a u
)11u v
{22 	
return33 
ExecuteDbOperation33 %
(33% &
context33& -
=>33. 0
{44 
var55 
query55 
=55 
context55 #
.55# $
VwFiltroAnidados55$ 4
.554 5
AsQueryable555 @
(55@ A
)55A B
;55B C
foreach77 
(77 
var77 
filtro77 #
in77$ & 
filtrosSeleccionados77' ;
)77; <
{88 
switch99 
(99 
filtro99 "
.99" #
CodigoHomologacion99# 5
)995 6
{:: 
case;; 
$str;; *
:;;* +
query<< !
=<<" #
query<<$ )
.<<) *
Where<<* /
(<</ 0
q<<0 1
=><<2 4
filtro<<5 ;
.<<; <
	Seleccion<<< E
.<<E F
Contains<<F N
(<<N O
q<<O P
.<<P Q
KEY_FIL_ONA<<Q \
)<<\ ]
)<<] ^
;<<^ _
break== !
;==! "
case>> 
$str>> *
:>>* +
query?? !
=??" #
query??$ )
.??) *
Where??* /
(??/ 0
q??0 1
=>??2 4
filtro??5 ;
.??; <
	Seleccion??< E
.??E F
Contains??F N
(??N O
q??O P
.??P Q
KEY_FIL_PAI??Q \
)??\ ]
)??] ^
;??^ _
break@@ !
;@@! "
caseAA 
$strAA *
:AA* +
queryBB !
=BB" #
queryBB$ )
.BB) *
WhereBB* /
(BB/ 0
qBB0 1
=>BB2 4
filtroBB5 ;
.BB; <
	SeleccionBB< E
.BBE F
ContainsBBF N
(BBN O
qBBO P
.BBP Q
KEY_FIL_ESTBBQ \
)BB\ ]
)BB] ^
;BB^ _
breakCC !
;CC! "
caseDD 
$strDD *
:DD* +
queryEE !
=EE" #
queryEE$ )
.EE) *
WhereEE* /
(EE/ 0
qEE0 1
=>EE2 4
filtroEE5 ;
.EE; <
	SeleccionEE< E
.EEE F
ContainsEEF N
(EEN O
qEEO P
.EEP Q
KEY_FIL_ESQEEQ \
)EE\ ]
)EE] ^
;EE^ _
breakFF !
;FF! "
caseGG 
$strGG *
:GG* +
queryHH !
=HH" #
queryHH$ )
.HH) *
WhereHH* /
(HH/ 0
qHH0 1
=>HH2 4
filtroHH5 ;
.HH; <
	SeleccionHH< E
.HHE F
ContainsHHF N
(HHN O
qHHO P
.HHP Q
KEY_FIL_NORHHQ \
)HH\ ]
)HH] ^
;HH^ _
breakII !
;II! "
caseJJ 
$strJJ *
:JJ* +
queryKK !
=KK" #
queryKK$ )
.KK) *
WhereKK* /
(KK/ 0
qKK0 1
=>KK2 4
filtroKK5 ;
.KK; <
	SeleccionKK< E
.KKE F
ContainsKKF N
(KKN O
qKKO P
.KKP Q
KEY_FIL_RECKKQ \
)KK\ ]
)KK] ^
;KK^ _
breakLL !
;LL! "
}MM 
}NN 
returnPP 
queryPP 
.QQ 
AsNoTrackingQQ !
(QQ! "
)QQ" #
.RR 
SelectRR 
(RR 
fRR 
=>RR  
newRR! $
vw_FiltrosAnidadosRR% 7
{SS 
KEY_FIL_ONATT #
=TT$ %
fTT& '
.TT' (
KEY_FIL_ONATT( 3
,TT3 4
KEY_FIL_PAIUU #
=UU$ %
fUU& '
.UU' (
KEY_FIL_PAIUU( 3
,UU3 4
KEY_FIL_ESTVV #
=VV$ %
fVV& '
.VV' (
KEY_FIL_ESTVV( 3
,VV3 4
KEY_FIL_ESQWW #
=WW$ %
fWW& '
.WW' (
KEY_FIL_ESQWW( 3
,WW3 4
KEY_FIL_NORXX #
=XX$ %
fXX& '
.XX' (
KEY_FIL_NORXX( 3
,XX3 4
KEY_FIL_RECYY #
=YY$ %
fYY& '
.YY' (
KEY_FIL_RECYY( 3
}ZZ 
)ZZ 
.[[ 
ToList[[ 
([[ 
)[[ 
;[[ 
}\\ 
)\\ 
;\\ 
}]] 	
public`` 
List`` 
<`` 
vw_FiltrosAnidados`` &
>``& '%
ObtenerFiltrosAnidadosAll``( A
(``A B
)``B C
{aa 	
returnbb 
ExecuteDbOperationbb %
(bb% &
contextbb& -
=>bb. 0
{cc 
vardd 
querydd 
=dd 
contextdd #
.dd# $
VwFiltroAnidadosdd$ 4
.dd4 5
AsQueryabledd5 @
(dd@ A
)ddA B
;ddB C
returnff 
queryff 
.gg 
AsNoTrackinggg !
(gg! "
)gg" #
.hh 
Selecthh 
(hh 
fhh 
=>hh  
newhh! $
vw_FiltrosAnidadoshh% 7
{ii 
KEY_FIL_ONAjj #
=jj$ %
fjj& '
.jj' (
KEY_FIL_ONAjj( 3
,jj3 4
KEY_FIL_PAIkk #
=kk$ %
fkk& '
.kk' (
KEY_FIL_PAIkk( 3
,kk3 4
KEY_FIL_ESTll #
=ll$ %
fll& '
.ll' (
KEY_FIL_ESTll( 3
,ll3 4
KEY_FIL_ESQmm #
=mm$ %
fmm& '
.mm' (
KEY_FIL_ESQmm( 3
,mm3 4
KEY_FIL_NORnn #
=nn$ %
fnn& '
.nn' (
KEY_FIL_NORnn( 3
,nn3 4
KEY_FIL_RECoo #
=oo$ %
foo& '
.oo' (
KEY_FIL_RECoo( 3
}pp 
)pp 
.qq 
ToListqq 
(qq 
)qq 
;qq 
}rr 
)rr 
;rr 
}ss 	
publicxx 
Listxx 
<xx 
VwDimensionxx 
>xx  
ObtenerVwDimensionxx! 3
(xx3 4
)xx4 5
{yy 	
returnzz 
ExecuteDbOperationzz %
(zz% &
contextzz& -
=>zz. 0
context{{ 
.{{ 
VwDimension{{ !
.|| 
AsNoTracking|| 
(|| 
)|| 
.}} 
OrderBy}} 
(}} 
c}} 
=>}} 
c}} 
.}}  
MostrarWebOrden}}  /
)}}/ 0
.~~ 
ToList~~ 
(~~ 
)~~ 
)~~ 
;~~ 
} 	
public
�� 
List
�� 
<
�� 
Homologacion
��  
>
��  !
ObtenerGrupos
��" /
(
��/ 0
)
��0 1
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� 
Homologacion
�� "
.
�� 
AsNoTracking
�� 
(
�� 
)
�� 
.
�� 
Where
�� 
(
�� 
c
�� 
=>
�� 
c
�� 
.
�� !
IdHomologacionGrupo
�� 1
==
��2 4
null
��5 9
&&
��: <
c
��= >
.
��> ?
Estado
��? E
==
��F H

Constantes
��I S
.
��S T
ESTADO_USUARIO_A
��T d
)
��d e
.
�� 
OrderBy
�� 
(
�� 
c
�� 
=>
�� 
c
�� 
.
��  
MostrarWebOrden
��  /
)
��/ 0
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� !
VwHomologacionGrupo
�� "
?
��" #
FindVwHGByCode
��$ 2
(
��2 3
string
��3 9 
codigoHomologacion
��: L
)
��L M
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� !
VwHomologacionGrupo
�� +
.
�� 
AsNoTracking
�� 
(
��  
)
��  !
.
�� 
Where
�� 
(
�� 
c
�� 
=>
�� 
c
�� 
.
��   
CodigoHomologacion
��  2
==
��3 5 
codigoHomologacion
��6 H
)
��H I
.
�� 
FirstOrDefault
�� !
(
��! "
)
��" #
)
��# $
;
��$ %
}
�� 	
public
�� 
List
�� 
<
�� 
vwFiltroDetalle
�� #
>
��# $#
ObtenerFiltroDetalles
��% :
(
��: ;
string
��; A
codigo
��B H
)
��H I
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� 
vwFiltroDetalle
�� $
.
�� 
AsNoTracking
�� 
(
�� 
)
�� 
.
�� 
Where
�� 
(
�� 
c
�� 
=>
�� 
c
�� 
.
��  
CodigoHomologacion
�� /
==
��0 2
codigo
��3 9
)
��9 :
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� 
VwRol
�� 
>
�� 
ObtenerVwRol
�� '
(
��' (
)
��( )
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� 
VwRol
�� 
.
�� 
AsNoTracking
�� 
(
�� 
)
�� 
.
�� 
OrderBy
�� 
(
�� 
c
�� 
=>
�� 
c
�� 
.
��  
Rol
��  #
)
��# $
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
VwRol
�� 
FindVwRolByHId
�� #
(
��# $
int
��$ '
idHomologacionRol
��( 9
)
��9 :
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� 
VwRol
�� 
.
�� 
AsNoTracking
�� 
(
�� 
)
�� 
.
�� 
FirstOrDefault
�� 
(
��  
c
��  !
=>
��" $
c
��% &
.
��& '
IdHomologacionRol
��' 8
==
��9 ;
idHomologacionRol
��< M
)
��M N
)
��N O
;
��O P
}
�� 	
public
�� 
List
�� 
<
�� !
VwHomologacionGrupo
�� '
>
��' ((
ObtenerVwHomologacionGrupo
��) C
(
��C D
)
��D E
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� !
VwHomologacionGrupo
�� )
.
�� 
AsNoTracking
�� 
(
�� 
)
�� 
.
�� 
OrderBy
�� 
(
�� 
c
�� 
=>
�� 
c
�� 
.
��  
MostrarWebOrden
��  /
)
��/ 0
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� 
VwMenu
�� 
>
�� 
ObtenerVwMenu
�� )
(
��) *
)
��* +
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� 
VwMenu
�� 
.
�� 
AsNoTracking
�� 
(
�� 
)
�� 
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� 
ONA
�� 
>
�� 

ObtenerOna
�� #
(
��# $
)
��$ %
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� 
ONA
�� 
.
�� 
AsNoTracking
�� 
(
�� 
)
�� 
.
�� 
OrderBy
�� 
(
�� 
c
�� 
=>
�� 
c
�� 
.
��  
IdONA
��  %
)
��% &
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� 

vwPanelONA
�� 
>
�� 
ObtenerVwPanelOna
��  1
(
��1 2
)
��2 3
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� 

vwPanelONA
��  
.
�� 
AsNoTracking
�� 
(
�� 
)
�� 
.
�� 
OrderBy
�� 
(
�� 
c
�� 
=>
�� 
c
�� 
.
��  
NroOrg
��  &
)
��& '
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� 
vwONA
�� 
>
�� 
ObtenervwOna
�� '
(
��' (
)
��( )
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� 
vwONA
�� 
.
�� 
AsNoTracking
�� 
(
�� 
)
�� 
.
�� 
OrderBy
�� 
(
�� 
c
�� 
=>
�� 
c
�� 
.
��  
IdONA
��  %
)
��% &
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� 
vwEsquemaOrganiza
�� %
>
��% &&
ObtenervwEsquemaOrganiza
��' ?
(
��? @
)
��@ A
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
context
�� 
.
�� 
vwEsquemaOrganiza
�� )
.
�� 
AsNoTracking
�� 
(
�� 
)
�� 
.
�� 
OrderBy
�� 
(
�� 
c
�� 
=>
�� 
c
�� 
.
��  
ONAPais
��  '
)
��' (
.
�� 
ToList
�� 
(
�� 
)
�� 
)
�� 
;
�� 
}
�� 	
}
�� 
}�� ��
TC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\BuscadorRepository.cs
	namespace

 	

DataAccess


 
.

 
Repositories

 !
{ 
public 

class 
BuscadorRepository #
:$ %
BaseRepository& 4
,4 5
IBuscadorRepository6 I
{ 
public 
BuscadorRepository !
(! "
ILogger" )
<) *
BuscadorRepository* <
>< =
logger> D
,D E&
ISqlServerDbContextFactory
 $%
sqlServerDbContextFactory% >
) 	
:
 
base 
( %
sqlServerDbContextFactory *
,* +
logger, 2
)2 3
{ 	
} 	
public 
BuscadorDto 
PsBuscarPalabra *
(* +
string+ 1
	paramJSON2 ;
,; <
int= @

PageNumberA K
,K L
intM P
RowsPerPageQ \
)\ ]
{ 	
return 
ExecuteDbOperation %
(% &
context& -
=>. 0
{ 
var 
	rowsTotal 
= 
new  #
SqlParameter$ 0
{ 
ParameterName !
=" #
$str$ 0
,0 1
	SqlDbType 
= 
	SqlDbType  )
.) *
Int* -
,- .
	Direction 
= 
ParameterDirection  2
.2 3
Output3 9
} 
; 
var 
panelONAjson  
=! "
new# &
SqlParameter' 3
{ 
ParameterName   !
=  " #
$str  $ 5
,  5 6
	SqlDbType!! 
=!! 
	SqlDbType!!  )
.!!) *
NVarChar!!* 2
,!!2 3
Size"" 
="" 
-"" 
$num"" 
,"" 
	Direction## 
=## 
ParameterDirection##  2
.##2 3
Output##3 9
}$$ 
;$$ 
var'' 
lstTem'' 
='' 
context'' $
.''$ %
Database''% -
.''- .
SqlQueryRaw''. 9
<''9 :!
BuscadorResultadoData'': O
>''O P
(''P Q
$str(( q
,((q r
new)) 
SqlParameter)) #
())# $
$str))$ 0
,))0 1
	paramJSON))2 ;
))); <
,))< =
new** 
SqlParameter** #
(**# $
$str**$ 1
,**1 2

PageNumber**3 =
)**= >
,**> ?
new++ 
SqlParameter++ #
(++# $
$str++$ 2
,++2 3
RowsPerPage++4 ?
)++? @
,++@ A
	rowsTotal,, 
,,, 
panelONAjson-- 
).. 
... 
AsNoTracking.. 
(..  
)..  !
...! "
ToList.." (
(..( )
)..) *
;..* +
var00 
panelONAData00  
=00! "
string00# )
.00) *
IsNullOrEmpty00* 7
(007 8
panelONAjson008 D
.00D E
Value00E J
as00K M
string00N T
)00T U
?11 
new11 
List11 "
<11" #

vwPanelONA11# -
>11- .
(11. /
)11/ 0
:22 
JsonConvert22 %
.22% &
DeserializeObject22& 7
<227 8
List228 <
<22< =

vwPanelONA22= G
>22G H
>22H I
(22I J
panelONAjson22J V
.22V W
Value22W \
.22\ ]
ToString22] e
(22e f
)22f g
)22g h
;22h i
var44 
panelONADataDto44 #
=44$ %
panelONAData44& 2
.442 3
Select443 9
(449 :
o44: ;
=>44< >
new44? B
vwPanelONADto44C P
{55 
Sigla66 
=66 
o66 
.66 
Sigla66 #
,66# $
Pais77 
=77 
o77 
.77 
Pais77 !
,77! "
Icono88 
=88 
o88 
.88 
Icono88 #
,88# $
NroOrg99 
=99 
o99 
.99 
NroOrg99 %
}:: 
):: 
.:: 
ToList:: 
(:: 
):: 
;:: 
return== 
new== 
BuscadorDto== &
{>> 
Data?? 
=?? 
lstTem?? !
.??! "
Select??" (
(??( )
c??) *
=>??+ -
new??. 1$
BuscadorResultadoDataDto??2 J
(??J K
)??K L
{@@ 
IdONAAA 
=AA 
cAA  !
.AA! "
IdONAAA" '
,AA' (
SiglasBB 
=BB  
cBB! "
.BB" #
SiglasBB# )
,BB) *
TextoCC 
=CC 
cCC  !
.CC! "
TextoCC" '
,CC' (
VistaPKDD 
=DD  !
cDD" #
.DD# $
VistaPKDD$ +
,DD+ ,
VistaFKEE 
=EE  !
cEE" #
.EE# $
VistaFKEE$ +
,EE+ ,
	IdEsquemaFF !
=FF" #
cFF$ %
.FF% &
	IdEsquemaFF& /
,FF/ 0
IdEsquemaVistaGG &
=GG' (
cGG) *
.GG* +
IdEsquemaVistaGG+ 9
,GG9 :
IdEsquemaDataHH %
=HH& '
cHH( )
.HH) *
IdEsquemaDataHH* 7
,HH7 8
DataEsquemaJsonII '
=II( )
JsonConvertII* 5
.II5 6
DeserializeObjectII6 G
<IIG H
ListIIH L
<IIL M
ColumnaEsquemaIIM [
>II[ \
>II\ ]
(II] ^
cII^ _
.II_ `
DataEsquemaJsonII` o
??IIp r
$strIIs w
)IIw x
}JJ 
)JJ 
.JJ 
ToListJJ 
(JJ 
)JJ 
,JJ  

TotalCountKK 
=KK  
(KK! "
intKK" %
)KK% &
	rowsTotalKK& /
.KK/ 0
ValueKK0 5
,KK5 6
PanelONALL 
=LL 
panelONADataDtoLL .
}MM 
;MM 
}NN 
)NN 
;NN 
}OO 	
publicPP 
ListPP 
<PP 

EsquemaDtoPP 
>PP %
FnHomologacionEsquemaTodoPP  9
(PP9 :
stringPP: @
VistaFKPPA H
,PPH I
intPPJ M
idOnaPPN S
)PPS T
{QQ 	
returnRR 
ExecuteDbOperationRR %
(RR% &
contextRR& -
=>RR. 0
{SS 
returnTT 
contextTT 
.TT 
DatabaseTT '
.TT' (
SqlQueryTT( 0
<TT0 1

EsquemaDtoTT1 ;
>TT; <
(TT< =
$"TT= ?
$strTT? [
{TT[ \
VistaFKTT\ c
}TTc d
$strTTd e
{TTe f
idOnaTTf k
}TTk l
$strTTl m
"TTm n
)TTn o
.TTo p
AsNoTrackingTTp |
(TT| }
)TT} ~
.TT~ 
OrderBy	TT �
(
TT� �
c
TT� �
=>
TT� �
c
TT� �
.
TT� �
MostrarWebOrden
TT� �
)
TT� �
.
TT� �
ToList
TT� �
(
TT� �
)
TT� �
;
TT� �
}UU 
)UU 
;UU 
}VV 	
publicXX 
FnEsquemaDtoXX 
?XX !
FnHomologacionEsquemaXX 2
(XX2 3
intXX3 6
	idEsquemaXX7 @
)XX@ A
{YY 	
returnZZ 
ExecuteDbOperationZZ %
(ZZ% &
contextZZ& -
=>ZZ. 0
{[[ 
return\\ 
context\\ 
.\\ 
Database\\ '
.\\' (
SqlQuery\\( 0
<\\0 1
FnEsquemaDto\\1 =
>\\= >
(\\> ?
$"\\? A
$str\\A Y
{\\Y Z
	idEsquema\\Z c
}\\c d
$str\\d e
"\\e f
)\\f g
.\\g h
AsNoTracking\\h t
(\\t u
)\\u v
.\\v w
FirstOrDefault	\\w �
(
\\� �
)
\\� �
;
\\� �
}]] 
)]] 
;]] 
}^^ 	
public``  
fnEsquemaCabeceraDto`` #
?``# $
FnEsquemaCabecera``% 6
(``6 7
int``7 :
IdEsquemadata``; H
)``H I
{aa 	
returnbb 
ExecuteDbOperationbb %
(bb% &
contextbb& -
=>bb. 0
{cc 
returndd 
contextdd 
.dd 
Databasedd '
.dd' (
SqlQuerydd( 0
<dd0 1 
fnEsquemaCabeceraDtodd1 E
>ddE F
(ddF G
$"ddG I
$strddI i
{ddi j
IdEsquemadataddj w
}ddw x
$strddx y
"ddy z
)ddz {
.dd{ |
AsNoTracking	dd| �
(
dd� �
)
dd� �
.
dd� �
FirstOrDefault
dd� �
(
dd� �
)
dd� �
;
dd� �
}ee 
)ee 
;ee 
}ff 	
publicgg 
Listgg 
<gg (
FnHomologacionEsquemaDataDtogg 0
>gg0 1%
FnHomologacionEsquemaDatogg2 K
(ggK L
intggL O
	idEsquemaggP Y
,ggY Z
stringgg[ a
VistaFKggb i
,ggi j
intggk n
idOnaggo t
)ggt u
{hh 	
returnii 
ExecuteDbOperationii %
(ii% &
contextii& -
=>ii. 0
{jj 
varkk 
lstTemkk 
=kk 
contextkk $
.kk$ %
Databasekk% -
.kk- .
SqlQuerykk. 6
<kk6 7%
FnHomologacionEsquemaDatakk7 P
>kkP Q
(kkQ R
$"kkR T
$strkkT p
{kkp q
	idEsquemakkq z
}kkz {
$strkk{ |
{kk| }
VistaFK	kk} �
}
kk� �
$str
kk� �
{
kk� �
idOna
kk� �
}
kk� �
$str
kk� �
"
kk� �
)
kk� �
.ll. /
AsNoTrackingll/ ;
(ll; <
)ll< =
.mm. /
ToListmm/ 5
(mm5 6
)mm6 7
;mm7 8
returnoo 
lstTemoo 
.oo 
Selectoo $
(oo$ %
coo% &
=>oo' )
{pp 
Listqq 
<qq 
ColumnaEsquemaqq '
>qq' (
dataEsquemaqq) 4
=qq5 6
newqq7 :
Listqq; ?
<qq? @
ColumnaEsquemaqq@ N
>qqN O
(qqO P
)qqP Q
;qqQ R
tryss 
{tt 
dataEsquemauu #
=uu$ %
JsonConvertuu& 1
.uu1 2
DeserializeObjectuu2 C
<uuC D
ListuuD H
<uuH I
ColumnaEsquemauuI W
>uuW X
>uuX Y
(uuY Z
cuuZ [
.uu[ \
DataEsquemaJsonuu\ k
??uul n
$struuo s
)uus t
;uut u
}vv 
catchww 
(ww 
JsonReaderExceptionww .
exww/ 1
)ww1 2
{xx 
Consoleyy 
.yy  
	WriteLineyy  )
(yy) *
$"yy* ,
$stryy, H
{yyH I
exyyI K
.yyK L
MessageyyL S
}yyS T
"yyT U
)yyU V
;yyV W
Consolezz 
.zz  
	WriteLinezz  )
(zz) *
$"zz* ,
$strzz, ;
{zz; <
czz< =
.zz= >
DataEsquemaJsonzz> M
}zzM N
"zzN O
)zzO P
;zzP Q
}{{ 
return}} 
new}} (
FnHomologacionEsquemaDataDto}} ;
(}}; <
)}}< =
{~~ 
IdEsquemaData %
=& '
c( )
.) *
IdEsquemaData* 7
,7 8
	IdEsquema
�� !
=
��" #
c
��$ %
.
��% &
	IdEsquema
��& /
,
��/ 0
DataEsquemaJson
�� '
=
��( )
dataEsquema
��* 5
}
�� 
;
�� 
}
�� 
)
�� 
.
�� 
ToList
�� 
(
�� 
)
�� 
;
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� %
FnEsquemaDataBuscadoDto
�� +
>
��+ ,!
FnEsquemaDatoBuscar
��- @
(
��@ A
int
��A D
IdEsquemadata
��E R
,
��R S
string
��T Z
TextoBuscar
��[ f
)
��f g
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
try
�� 
{
�� 
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$"
��& (
$str
��( U
{
��U V
IdEsquemadata
��V c
}
��c d
$str
��d r
{
��r s
TextoBuscar
��s ~
}
��~ 
"�� �
)��� �
;��� �
var
��  
paramIdEsquemadata
�� *
=
��+ ,
new
��- 0
SqlParameter
��1 =
(
��= >
$str
��> N
,
��N O
	SqlDbType
��P Y
.
��Y Z
Int
��Z ]
)
��] ^
{
��_ `
Value
��a f
=
��g h
IdEsquemadata
��i v
}
��w x
;
��x y
var
�� 
paramTextoBuscar
�� (
=
��) *
new
��+ .
SqlParameter
��/ ;
(
��; <
$str
��< J
,
��J K
	SqlDbType
��L U
.
��U V
NVarChar
��V ^
,
��^ _
$num
��` c
)
��c d
{
��e f
Value
��g l
=
��m n
TextoBuscar
��o z
??
��{ }
(
��~ 
object�� �
)��� �
DBNull��� �
.��� �
Value��� �
}��� �
;��� �
var
�� 
lstTem
�� 
=
��  
context
��! (
.
��( )
Database
��) 1
.
��1 2
SqlQueryRaw
��2 =
<
��= >"
FnEsquemaDataBuscado
��> R
>
��R S
(
��S T
$str
�� Z
,
��Z [ 
paramIdEsquemadata
�� *
,
��* +
paramTextoBuscar
��, <
)
�� 
.
�� 
AsNoTracking
�� "
(
��" #
)
��# $
.
��$ %
ToList
��% +
(
��+ ,
)
��, -
;
��- .
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$"
��& (
$str
��( D
{
��D E
lstTem
��E K
.
��K L
Count
��L Q
}
��Q R
"
��R S
)
��S T
;
��T U
var
�� 
	resultado
�� !
=
��" #
lstTem
��$ *
.
��* +
Select
��+ 1
(
��1 2
c
��2 3
=>
��4 6
{
�� 
Console
�� 
.
��  
	WriteLine
��  )
(
��) *
$"
��* ,
$str
��, O
{
��O P
c
��P Q
.
��Q R
IdEsquemaData
��R _
}
��_ `
"
��` a
)
��a b
;
��b c
List
�� 
<
�� 
ColumnaEsquema
�� +
>
��+ ,
jsonData
��- 5
;
��5 6
try
�� 
{
�� 
jsonData
�� $
=
��% &
JsonConvert
��' 2
.
��2 3
DeserializeObject
��3 D
<
��D E
List
��E I
<
��I J
ColumnaEsquema
��J X
>
��X Y
>
��Y Z
(
��Z [
c
��[ \
.
��\ ]
DataEsquemaJson
��] l
??
��m o
$str
��p t
)
��t u
;
��u v
}
�� 
catch
�� 
(
�� 
	Exception
�� (
ex
��) +
)
��+ ,
{
�� 
Console
�� #
.
��# $
	WriteLine
��$ -
(
��- .
$"
��. 0
$str
��0 L
{
��L M
ex
��M O
.
��O P
Message
��P W
}
��W X
"
��X Y
)
��Y Z
;
��Z [
jsonData
�� $
=
��% &
new
��' *
List
��+ /
<
��/ 0
ColumnaEsquema
��0 >
>
��> ?
(
��? @
)
��@ A
;
��A B
}
�� 
return
�� 
new
�� "%
FnEsquemaDataBuscadoDto
��# :
(
��: ;
)
��; <
{
�� 
IdEsquemaData
�� )
=
��* +
c
��, -
.
��- .
IdEsquemaData
��. ;
,
��; <
	IdEsquema
�� %
=
��& '
c
��( )
.
��) *
	IdEsquema
��* 3
,
��3 4
DataEsquemaJson
�� +
=
��, -
jsonData
��. 6
}
�� 
;
�� 
}
�� 
)
�� 
.
�� 
ToList
�� 
(
�� 
)
�� 
;
��  
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$"
��& (
$str
��( H
{
��H I
	resultado
��I R
.
��R S
Count
��S X
}
��X Y
"
��Y Z
)
��Z [
;
��[ \
return
�� 
	resultado
�� $
;
��$ %
}
�� 
catch
�� 
(
�� 
	Exception
��  
ex
��! #
)
��# $
{
�� 
Console
�� 
.
�� 
	WriteLine
�� %
(
��% &
$"
��& (
$str
��( E
{
��E F
ex
��F H
.
��H I
Message
��I P
}
��P Q
"
��Q R
)
��R S
;
��S T
return
�� 
new
�� 
List
�� #
<
��# $%
FnEsquemaDataBuscadoDto
��$ ;
>
��; <
(
��< =
)
��= >
;
��> ?
}
�� 
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
List
�� 
<
�� 
FnPredictWordsDto
�� %
>
��% &
FnPredictWords
��' 5
(
��5 6
string
��6 <
word
��= A
)
��A B
{
�� 	
return
��  
ExecuteDbOperation
�� %
(
��% &
context
��& -
=>
��. 0
{
�� 
return
�� 
context
�� 
.
�� 
Database
�� '
.
��' (
SqlQuery
��( 0
<
��0 1
FnPredictWordsDto
��1 B
>
��B C
(
��C D
$"
��D F
$str
��F b
{
��b c
word
��c g
}
��g h
$str
��h i
"
��i j
)
��j k
.
��k l
AsNoTracking
��l x
(
��x y
)
��y z
.
��z {
OrderBy��{ �
(��� �
c��� �
=>��� �
c��� �
.��� �
Word��� �
)��� �
.��� �
ToList��� �
(��� �
)��� �
;��� �
}
�� 
)
�� 
;
�� 
}
�� 	
public
�� 
bool
�� 
ValidateWords
�� !
(
��! "
List
��" &
<
��& '
string
��' -
>
��- .
words
��/ 4
)
��4 5
{
�� 	
if
�� 
(
�� 
words
�� 
==
�� 
null
�� 
||
��  
words
��! &
.
��& '
Count
��' ,
==
��- /
$num
��0 1
)
��1 2
return
�� 
false
�� 
;
�� 
bool
�� 
valor
�� 
=
��  
ExecuteDbOperation
�� +
(
��+ ,
context
��, 3
=>
��4 6
{
�� 
return
�� 
context
�� 
.
�� 
EsquemaFullText
�� .
.
��. /
Any
��/ 2
(
��2 3
e
��3 4
=>
��5 7
words
��8 =
.
��= >
Contains
��> F
(
��F G
e
��G H
.
��H I
FullTextData
��I U
)
��U V
)
��V W
;
��W X
}
�� 
)
�� 
;
�� 
return
�� 
valor
�� 
;
�� 
}
�� 	
public
�� 
int
�� 
AddEventTracking
�� #
(
��# $
EventTrackingDto
��$ 4
eventTracking
��5 B
)
��B C
{
�� 	
_
�� 
=
��  
ExecuteDbOperation
�� "
<
��" #
int
��# &
>
��& '
(
��' (
context
��( /
=>
��0 2
{
�� 
var
�� #
codigoHomologacionRol
�� )
=
��* +
new
��, /
SqlParameter
��0 <
(
��< =
$str
��= U
,
��U V
	SqlDbType
��W `
.
��` a
NVarChar
��a i
,
��i j
$num
��k m
)
��m n
{
��o p
Value
��q v
=
��w x
eventTracking��y �
.��� �%
CodigoHomologacionRol��� �
}��� �
;��� �
var
�� 
	idUsuario
�� 
=
�� 
new
��  #
SqlParameter
��$ 0
(
��0 1
$str
��1 =
,
��= >
	SqlDbType
��? H
.
��H I
Int
��I L
)
��L M
{
��N O
Value
��P U
=
��V W
eventTracking
��X e
.
��e f
	idUsuario
��f o
}
��p q
;
��q r
var
�� $
codigoHomologacionMenu
�� *
=
��+ ,
new
��- 0
SqlParameter
��1 =
(
��= >
$str
��> W
,
��W X
	SqlDbType
��Y b
.
��b c
NVarChar
��c k
,
��k l
$num
��m p
)
��p q
{
��r s
Value
��t y
=
��z {
eventTracking��| �
.��� �&
CodigoHomologacionMenu��� �
}��� �
;��� �
var
�� 
nombreControl
�� !
=
��" #
new
��$ '
SqlParameter
��( 4
(
��4 5
$str
��5 E
,
��E F
	SqlDbType
��G P
.
��P Q
NVarChar
��Q Y
,
��Y Z
$num
��[ ^
)
��^ _
{
��` a
Value
��b g
=
��h i
eventTracking
��j w
.
��w x
NombreControl��x �
}��� �
;��� �
var
�� 
nombreAccion
��  
=
��! "
new
��# &
SqlParameter
��' 3
(
��3 4
$str
��4 C
,
��C D
	SqlDbType
��E N
.
��N O
NVarChar
��O W
,
��W X
$num
��Y \
)
��\ ]
{
��^ _
Value
��` e
=
��f g
eventTracking
��h u
.
��u v
NombreAccion��v �
}��� �
;��� �
var
�� 
ubicacionJson
�� !
=
��" #
new
��$ '
SqlParameter
��( 4
(
��4 5
$str
��5 E
,
��E F
	SqlDbType
��G P
.
��P Q
NVarChar
��Q Y
,
��Y Z
-
��[ \
$num
��\ ]
)
��] ^
{
��_ `
Value
��a f
=
��g h
eventTracking
��i v
.
��v w
UbicacionJson��w �
}��� �
;��� �
var
�� 
parametroJson
�� !
=
��" #
new
��$ '
SqlParameter
��( 4
(
��4 5
$str
��5 E
,
��E F
	SqlDbType
��G P
.
��P Q
NVarChar
��Q Y
,
��Y Z
-
��[ \
$num
��\ ]
)
��] ^
{
�� 
Value
�� 
=
�� 
string
�� "
.
��" #
IsNullOrEmpty
��# 0
(
��0 1
eventTracking
��1 >
.
��> ?
ParametroJson
��? L
)
��L M
?
��N O
(
��P Q
object
��Q W
)
��W X
DBNull
��X ^
.
��^ _
Value
��_ d
:
��e f
eventTracking
��g t
.
��t u
ParametroJson��u �
}
�� 
;
�� 
return
�� 
context
�� 
.
�� 
Database
�� '
.
��' (
ExecuteSqlRaw
��( 5
(
��5 6
$str�� �
,��� �
new
�� 
[
�� 
]
�� 
{
�� 
	idUsuario
�� %
,
��% &#
codigoHomologacionRol
��' <
,
��< =$
codigoHomologacionMenu
��> T
,
��T U
nombreControl
��V c
,
��c d
nombreAccion
��e q
,
��q r
ubicacionJson��s �
,��� �
parametroJson��� �
}��� �
)
�� 
;
�� 
}
�� 
)
�� 
;
�� 
return
�� 
$num
�� 
;
�� 
}
�� 	
}
�� 
}�� �2
PC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Repositories\BaseRepository.cs
	namespace		 	

DataAccess		
 
.		 
Repositories		 !
{

 
public 
abstract	 
class 
BaseRepository &
{ 
public 

readonly 
ILogger 
_logger #
;# $
private 
readonly &
ISqlServerDbContextFactory /&
_sqlServerDbContextFactory0 J
;J K
	protected 
BaseRepository 
( &
ISqlServerDbContextFactory 7%
sqlServerDbContextFactory8 Q
,Q R
ILoggerS Z
logger[ a
)a b
{ 
_logger 
= 
logger 
; &
_sqlServerDbContextFactory  
=! "%
sqlServerDbContextFactory# <
;< =
} 
	protected 
TResult 
ExecuteDbOperation ,
<, -
TResult- 4
>4 5
(5 6
Func6 :
<: ;
SqlServerDbContext; M
,M N
TResultO V
>V W
	operationX a
)a b
{ 	
try 
{ 
using 
( 
var 
context "
=# $&
_sqlServerDbContextFactory% ?
.? @
CreateDbContext@ O
(O P
)P Q
)Q R
{ 
return 
	operation $
($ %
context% ,
), -
;- .
} 
} 
catch 
( !
SqlNullValueException (
ex) +
)+ ,
{ 
_logger 
. 
LogError  
(  !
ex! #
,# $
$str% H
)H I
;I J
throw   
new   
	Exception   #
(  # $
$str  $ \
,  \ ]
ex  ^ `
)  ` a
;  a b
}!! 
catch"" 
("" 
	Exception"" 
ex"" 
)""  
{## 
_logger$$ 
.$$ 
LogError$$  
($$  !
ex$$! #
,$$# $
$str$$% I
)$$I J
;$$J K
throw%% 
new%% 
	Exception%% #
(%%# $
$str%%$ ?
,%%? @
ex%%A C
)%%C D
;%%D E
}&& 
}'' 	
	protected(( 
async(( 
Task(( 
<(( 
TResult(( $
>(($ %#
ExecuteDbOperationAsync((& =
<((= >
TResult((> E
>((E F
(((F G
Func((G K
<((K L
SqlServerDbContext((L ^
,((^ _
Task((` d
<((d e
TResult((e l
>((l m
>((m n
	operation((o x
)((x y
{)) 
try** 	
{++ 
using,, 
(,, 
var,, 
context,, 
=,, &
_sqlServerDbContextFactory,, 7
.,,7 8
CreateDbContext,,8 G
(,,G H
),,H I
),,I J
{-- 	
return..
 
await.. 
	operation..  
(..  !
context..! (
)..( )
;..) *
}// 	
}00 
catch11 
(11 
	Exception11 
ex11 
)11 
{22 
_logger33 
.33 
LogError33 
(33 
ex33 
,33 
$str33 A
)33A B
;33B C
throw44 
new44 
	Exception44 
(44 
$str44 7
,447 8
ex449 ;
)44; <
;44< =
}55 
}66 
	protected77 
TEntity77 !
MergeEntityProperties77 +
<77+ ,
TEntity77, 3
>773 4
(774 5
	DbContext775 >
context77? F
,77F G
TEntity77H O
entity77P V
,77V W
Func77X \
<77\ ]
TEntity77] d
,77d e
bool77f j
>77j k
	predicate77l u
)77u v
where77w |
TEntity	77} �
:
77� �
class
77� �
{88 
var99 	
existingEntity99
 
=99 
context99 "
.99" #
Set99# &
<99& '
TEntity99' .
>99. /
(99/ 0
)990 1
.991 2
AsNoTracking992 >
(99> ?
)99? @
.99@ A
FirstOrDefault99A O
(99O P
	predicate99P Y
)99Y Z
;99Z [
if:: 
(::	 

existingEntity::
 
==:: 
null::  
)::  !
{;; 
throw<< 
new<< 
	Exception<< 
(<< 
$"<< 
{<< 
typeof<< %
(<<% &
TEntity<<& -
)<<- .
.<<. /
Name<</ 3
}<<3 4
$str<<4 >
"<<> ?
)<<? @
;<<@ A
}== 
PropertyInfo?? 
[?? 
]?? 

properties?? 
=??  !
typeof??" (
(??( )
TEntity??) 0
)??0 1
.??1 2
GetProperties??2 ?
(??? @
)??@ A
;??A B
foreach@@ 
(@@ 
PropertyInfo@@ 
property@@ $
in@@% '

properties@@( 2
)@@2 3
{AA 
varBB 
newValueBB 
=BB 
propertyBB 
.BB  
GetValueBB  (
(BB( )
entityBB) /
)BB/ 0
;BB0 1
varCC 
oldValueCC 
=CC 
propertyCC 
.CC  
GetValueCC  (
(CC( )
existingEntityCC) 7
)CC7 8
;CC8 9
ifEE 

(EE 
newValueEE 
!=EE 
nullEE 
&&EE 
!EE  !
EqualsEE! '
(EE' (
newValueEE( 0
,EE0 1
oldValueEE2 :
)EE: ;
)EE; <
{FF 	
propertyGG
 
.GG 
SetValueGG 
(GG 
existingEntityGG *
,GG* +
newValueGG, 4
)GG4 5
;GG5 6
}HH 	
}II 
returnKK 
existingEntityKK 
;KK 
}LL 
}MM 
}NN �	
NC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\vw_FiltrosAnidados.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
vw_FiltrosAnidados #
{ 
public 
string 
KEY_FIL_ONA !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
string 
KEY_FIL_PAI !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
string 
KEY_FIL_EST !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
string 
KEY_FIL_ESQ !
{" #
get$ '
;' (
set) ,
;, -
}. /
public		 
string		 
KEY_FIL_NOR		 !
{		" #
get		$ '
;		' (
set		) ,
;		, -
}		. /
public

 
string

 
KEY_FIL_REC

 !
{

" #
get

$ '
;

' (
set

) ,
;

, -
}

. /
} 
} �
AC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwRol.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 
( 	
$str	 
) 
] 
public 
class	 
VwRol 
{ 
[		 
Key		 
]		 	
public

 

int

 
IdHomologacionRol

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
public 

string 
? 
Rol 
{ 
get 
; 
set !
;! "
}# $
public 

string 
? 
CodigoHomologacion %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
} 
} �
LC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwProfesionalOna.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
]  
public 

class 
VwProfesionalOna !
{ 
public 
string 
Ona 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* ,
;, -
public		 
int		 
Profesionales		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
}

 
} �
NC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwProfesionalFecha.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str  
)  !
]! "
public 

class 
VwProfesionalFecha #
{ 
public 
string 
Fecha 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public		 
int		 
Profesionales		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
}

 
} �
PC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwProfesionalEsquema.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str "
)" #
]# $
public 

class  
VwProfesionalEsquema %
{ 
public 
string 
Esquema 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
public		 
int		 
Profesionales		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
}

 
} �
SC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwProfesionalCalificado.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str %
)% &
]& '
public 

class #
VwProfesionalCalificado (
{ 
public 
string 
Calificacion "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
public		 
int		 
Profesionales		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
}

 
} �
FC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\vwPanelONA.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 

vwPanelONA 
{ 
public 
string 
Sigla 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
Pais 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
Icono 
{ 
get !
;! "
set# &
;& '
}( )
public 
int 
NroOrg 
{ 
get 
;  
set! $
;$ %
}& '
}		 
}

 �
BC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwPais.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
] 
public 

class 
VwPais 
{ 
[		 	
Key			 
]		 
public

 
int

 
IdHomologacionPais

 %
{

& '
get

( +
;

+ ,
set

- 0
;

0 1
}

2 3
public 
string 
? 
Pais 
{ 
get !
;! "
set# &
;& '
}( )
} 
} �
QC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwOrganizacionEsquema.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str #
)# $
]$ %
public 

class !
VwOrganizacionEsquema &
{ 
public 
string 
Esquema 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
public		 
int		 
Organizacion		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
}

 
} �
QC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwOrganismoRegistrado.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str #
)# $
]$ %
public 

class !
VwOrganismoRegistrado &
{ 
public 
string 
Fecha 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public		 
int		 
Profesionales		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
}

 
} �
PC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwOrganismoActividad.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str "
)" #
]# $
public 

class  
VwOrganismoActividad %
{ 
public 
string 

Organismos  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
public		 
int		 
	Consultas		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
}

 
} �
AC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\vwONA.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
vwONA 
{ 
public 
int 
IdONA 
{ 
get 
; 
set  #
;# $
}% &
public 
string 
? 
Pais 
{ 
get !
;! "
set# &
;& '
}( )
public		 
string		 
?		 
RazonSocial		 "
{		# $
get		% (
;		( )
set		* -
;		- .
}		/ 0
public

 
string

 
?

 
Siglas

 
{

 
get

  #
;

# $
set

% (
;

( )
}

* +
public 
string 
? 
Ciudad 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
? 
Correo 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
? 
	Direccion  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
string 
? 
	PaginaWeb  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
string 
? 
Telefono 
{  !
get" %
;% &
set' *
;* +
}, -
public 
string 
? 
UrlIcono 
{  !
get" %
;% &
set' *
;* +
}, -
public 
string 
? 
UrlLogo 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
} �
EC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwOecPais.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
] 
public 

class 
	VwOecPais 
{ 
public 
string 
Pais 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public		 
int		 
Organizacion		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
}

 
} �
FC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwOecFecha.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
] 
public 

class 

VwOecFecha 
{ 
public 
string 
Fecha 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public		 
int		 
Organizacion		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
}

 
} �
BC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwMenu.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
] 
public 

class 
VwMenu 
{ 
public

 
int

 
MostrarWebOrden

 "
{

# $
get

% (
;

( )
set

* -
;

- .
}

/ 0
public 
string 

MostrarWeb  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
string 

TooltipWeb  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
string 
Icono 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
href 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
CodigoHomologacion (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
public 
string !
CodigoHomologacionRol +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
} 
} �
OC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwHomologacionGrupo.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str  
)  !
]! "
public 

class 
VwHomologacionGrupo $
{ 
[		 	
Key			 
]		 
public

 
int

 
IdHomologacion

 !
{

" #
get

$ '
;

' (
set

) ,
;

, -
}

. /
public 
int 
? 
IdHomologacionGrupo '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 
string 
? 

MostrarWeb !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
$str2 4
;4 5
public 
string 
? 

TooltipWeb !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
$str2 4
;4 5
public 
int 
? 
MostrarWebOrden #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
$num4 5
;5 6
public 
string 
? 
CodigoHomologacion )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
=8 9
$str: <
;< =
public 
string 
? 
Estado 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
} 
} �
JC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwHomologacion.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
] 
public 

class 
VwHomologacion 
{ 
[		 	
Key			 
]		 
public

 
int

 
IdHomologacion

 !
{

" #
get

$ '
;

' (
set

) ,
;

, -
}

. /
public 
int 
? 
IdHomologacionGrupo '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 
string 
? 
Indexar 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
? 

MostrarWeb !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
string 
? 

TooltipWeb !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
int 
? 
MostrarWebOrden #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
string 
? 
MascaraDato "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
string 
? 
SiNoHayDato "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
string 
? 
NombreHomologado '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 
string 
? 
CodigoHomologacion )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 
string 
? !
CodigoHomologacionKEY ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
} 
} �
DC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwGrilla.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 
( 	
$str	 
) 
] 
public 
class	 
VwGrilla 
{ 
[		 
Key		 
]		 	
public

 

int

 
IdHomologacion

 
{

 
get

  #
;

# $
set

% (
;

( )
}

* +
public 

string 
? 

MostrarWeb 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
? 

TooltipWeb 
{ 
get  #
;# $
set% (
;( )
}* +
public 

int 
MostrarWebOrden 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
} �
KC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\vwFiltroDetalle.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
vwFiltroDetalle  
{ 
[ 	
Key	 
] 
public 
int 
IdHomologacion !
{" #
get$ '
;' (
set) ,
;, -
}. /
public		 
string		 
?		 

MostrarWeb		 !
{		" #
get		$ '
;		' (
set		) ,
;		, -
}		. /
public

 
string

 
?

 
CodigoHomologacion

 )
{

* +
get

, /
;

/ 0
set

1 4
;

4 5
}

6 7
} 
} �	
DC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwFiltro.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
] 
public 

class 
VwFiltro 
{ 
[		 	
Key			 
]		 
public

 
int

 
IdHomologacion

 !
{

" #
get

$ '
;

' (
set

) ,
;

, -
}

. /
public 
string 
? 

MostrarWeb !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
string 
? 

TooltipWeb !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
int 
MostrarWebOrden "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
string 
? 
CodigoHomologacion )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
} 
} �
JC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwEventUserAll.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
VwEventUserAll 
{ 
public 
string 
? 
vw_Text 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
? 
vw_EventUser #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} 
} �
KC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwEstadoEsquema.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
] 
public 

class 
VwEstadoEsquema  
{ 
public 
string 
Esquema 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
public		 
string		 
Estado		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
=		+ ,
$str		- /
;		/ 0
public

 
int

 
Organizacion

 
{

  !
get

" %
;

% &
set

' *
;

* +
}

, -
} 
} �
IC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwEsquemaPais.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
] 
public 

class 
VwEsquemaPais 
{ 
public 
string 
Esquema 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
public		 
string		 
Pais		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
=		) *
$str		+ -
;		- .
public

 
int

 
Organizacion

 
{

  !
get

" %
;

% &
set

' *
;

* +
}

, -
} 
} �$
MC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\vwEsquemaOrganiza.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
vwEsquemaOrganiza "
{ 
public 
string 
? 
PK 
{ 
get 
;  
set! $
;$ %
}& '
public 
int 
IdEsquemaData  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
int 
	IdEsquema 
{ 
get "
;" #
set$ '
;' (
}) *
public 
int 
ONAIdONA 
{ 
get !
;! "
set# &
;& '
}( )
public		 
string		 
?		 
ONAPais		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
public

 
string

 
?

 
ONAUrlIcono

 "
{

# $
get

% (
;

( )
set

* -
;

- .
}

/ 0
public 
string 
? 
	ONASiglas  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
string 
? 
OrgNombreComercial )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 
string 
? 
OrgRazonSocial %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 
string 
? 
OrgPais 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
? 
	OrgCiudad  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
string 
? 
OrgDireccion #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
string 
? 
OrgTelefono "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
string 
? 
OrgWeb 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
? 
	OrgCorreo  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
string 
? 
OrgEstadoAcreditado *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
public 
string 
?  
OrgEsquemaAcreditado +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
public 
string 
? 
OrgNormaAcreditada )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 
string 
? 
OrgReconocimiento (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
public 
string 
? (
OrgFechaEfectivaAcreditacion 3
{4 5
get6 9
;9 :
set; >
;> ?
}@ A
public 
string 
? 
OrgPeriodoVigencia )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 
string 
? !
OrgFechaActualizacion ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
public 
string 
? !
OrgCodigoAcreditacion ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
public 
string 
? 
OrgUrlCertificado (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
public 
DateTime 
? 
	DataFecha "
{# $
get% (
;( )
set* -
;- .
}/ 0
} 
}   �
GC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwDimension.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 
( 	
$str	 
) 
] 
public 
class	 
VwDimension 
{ 
[		 
Key		 
]		 	
public

 

int

 
IdHomologacion

 
{

 
get

  #
;

# $
set

% (
;

( )
}

* +
public 

string 
? 
NombreHomologado #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

string 
? 

MostrarWeb 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
? 

TooltipWeb 
{ 
get  #
;# $
set% (
;( )
}* +
public 

int 
MostrarWebOrden 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

string 
? 
MascaraDato 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

string 
? 
SiNoHayDato 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

string 
? 
CustomMostrarWeb #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} 
} �
OC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwCalificaUbicacion.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str !
)! "
]" #
public 

class 
VwCalificaUbicacion $
{ 
public 
string 
Pais 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public		 
int		 
Calificados		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
}

 
} �
OC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwBusquedaUbicacion.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str !
)! "
]" #
public 

class 
VwBusquedaUbicacion $
{ 
public 
string 
Pais 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public		 
string		 
Ciudad		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
=		+ ,
$str		- /
;		/ 0
public

 
int

 
Busqueda

 
{

 
get

 !
;

! "
set

# &
;

& '
}

( )
} 
} �
LC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwBusquedaFiltro.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
]  
public 

class 
VwBusquedaFiltro !
{ 
public 
string 
	FiltroPor 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
public		 
int		 
Busqueda		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
}

 
} �
KC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwBusquedaFecha.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
] 
public 

class 
VwBusquedaFecha  
{ 
public 
string 
Fecha 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public		 
int		 
Busqueda		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
}

 
} �
NC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwActualizacionONA.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str  
)  !
]! "
public 

class 
VwActualizacionONA #
{ 
public 
string 
Fecha 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public		 
string		 
ONA		 
{		 
get		 
;		  
set		! $
;		$ %
}		& '
=		( )
$str		* ,
;		, -
public

 
int

 
Actualizaciones

 "
{

# $
get

% (
;

( )
set

* -
;

- .
}

/ 0
} 
} �
MC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwAcreditacionOna.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
)  
]  !
public 

class 
VwAcreditacionOna "
{ 
public 
string 
Pais 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public		 
string		 
ONA		 
{		 
get		 
;		  
set		! $
;		$ %
}		& '
=		( )
$str		* ,
;		, -
public

 
int

 
Organizacion

 
{

  !
get

" %
;

% &
set

' *
;

* +
}

, -
} 
} �	
LC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwAcreditacionOA.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str 
) 
] 
public 

class 
VwAcreditacionOA !
{ 
public

 
string

 
?

 
Pais

 
{

 
get

 !
;

! "
set

# &
;

& '
}

( )
public 
string 
? 
ONA 
{ 
get  
;  !
set" %
;% &
}' (
public 
int 
? 
Organizaciones "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
double 
Latitude 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
double 
	Longitude 
{  !
get" %
;% &
set' *
;* +
}, -
} 
} �
QC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\VwAcreditacionEsquema.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
Table 

(
 
$str #
)# $
]$ %
public 

class !
VwAcreditacionEsquema &
{ 
public 
string 
Esquema 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
public		 
int		 
Organizacion		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
}

 
} �
KC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\UsuarioEndpoint.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
UsuarioEndpoint 
:  

BaseEntity! +
{ 
[		 
Key		 
]		 	
public

 

int

 
IdUsuarioEndPoint

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
[ 
Required 
] 
public 

int "
IdHomologacionEndPoint %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
[ 
Required 
] 
public 

int 
	IdUsuario 
{ 
get 
; 
set  #
;# $
}% &
[ 
Required 
] 
public 

string 
? 
Accion 
{ 
get 
;  
set! $
;$ %
}& '
[ 
Required 
] 
public 

string 
Estado 
{ 
get 
; 
set  #
;# $
}% &
=' (

Constantes) 3
.3 4
ESTADO_USUARIO_A4 D
;D E
[ 

ForeignKey 
( 
$str 
) 
] 
public 

Usuario 
? 
Usuario 
{ 
get !
;! "
set# &
;& '
}( )
[ 

ForeignKey 
( 
$str (
)( )
]) *
public 

Homologacion 
? 
Homologacion %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
} 
} �
CC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\Usuario.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
Usuario 
: 

BaseEntity #
{ 
[ 
Key 
] 	
public		 

int		 
	IdUsuario		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
public 

int 
IdHomologacionRol  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

int 
IdONA 
{ 
get 
; 
set 
;  
}! "
[ 
Required 
] 
public 

string 
? 
Nombre 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* ,
;, -
[ 	
Required	 
] 
public 

string 
? 
Apellido 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
[ 	
Required	 
] 
public 

string 
? 
Telefono 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
[ 	
Required	 
] 
public 

string 
? 
Email 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
[ 	
Required	 
] 
public 

string 
? 
Clave 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
[ 	
Required	 
] 
public 

string 
? 
Estado 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* ,
;, -
[ 	

ForeignKey	 
( 
$str '
)' (
]( )
public 

Homologacion 
? 
Homologacion %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 
DateTime 
? 
FechaModifica &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
=5 6
DateTime7 ?
.? @
Now@ C
;C D
public 
int 
? 
IdUserModifica "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$num3 4
;4 5
} 
} �
EC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\Thesaurus.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
[ 
XmlRoot 
( 
$str 
, 
	Namespace #
=$ %
$str& =
)= >
]> ?
public 

class 
	Thesaurus 
{ 
[ 	

XmlElement	 
( 
$str *
)* +
]+ ,
public		 
int		 
DiacriticsSensitive		 &
{		' (
get		) ,
;		, -
set		. 1
;		1 2
}		3 4
[ 	

XmlElement	 
( 
$str 
)  
]  !
public 
List 
< 
	Expansion 
> 

Expansions )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
=8 9
new: =
(= >
)> ?
;? @
[ 	

XmlElement	 
( 
$str !
)! "
]" #
public 
List 
< 
Replacement 
>  
Replacements! -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
=< =
new> A
(A B
)B C
;C D
} 
public 

class 
	Expansion 
{ 
[ 	

XmlElement	 
( 
$str 
) 
] 
public 
List 
< 
string 
> 
Substitutes '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
=6 7
new8 ;
(; <
)< =
;= >
} 
public 

class 
Replacement 
{ 
[ 	

XmlElement	 
( 
$str 
) 
] 
public 
List 
< 
string 
> 
Patterns $
{% &
get' *
;* +
set, /
;/ 0
}1 2
=3 4
new5 8
(8 9
)9 :
;: ;
[ 	

XmlElement	 
( 
$str 
) 
] 
public 
List 
< 
string 
> 
Substitutes '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
=6 7
new8 ;
(; <
)< =
;= >
} 
}   �
KC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\PsBuscarPalabra.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
PsBuscarPalabra 
{  
[ 
Key 
] 	
public 

string 
? 
IdEnte 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
? 
IdVista 
{ 
get  
;  !
set" %
;% &
}' (
public		 

int		 
IdHomologacion		 
{		 
get		  #
;		# $
set		% (
;		( )
}		* +
public

 

string

 
?

 
DataEsquemaJson

 "
{

# $
get

% (
;

( )
set

* -
;

- .
}

/ 0
} 
} �
GC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\ONAConexion.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
ONAConexion 
: 

BaseEntity )
{ 
[ 	
Key	 
] 
public		 
int		 
IdONA		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
public 
string 
? 
Host 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public 
int 
? 
Puerto 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$num+ ,
;, -
public 
string 
? 
Usuario 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
public 
string 
? 
Contrasenia "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
public 
string 
? 
	BaseDatos  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
public 
string 
? 
OrigenDatos "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
public 
string 
? 
Migrar 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
public 
string 
? 
Estado 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
public 
int 
? 
IdUserCreacion "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$num3 4
;4 5
public 
int 
? 
IdUserModifica "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$num3 4
;4 5
public 
DateTime 
? 
FechaCreacion &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
=5 6
DateTime7 ?
.? @
Now@ C
;C D
public!! 
DateTime!! 
?!! 
FechaModifica!! &
{!!' (
get!!) ,
;!!, -
set!!. 1
;!!1 2
}!!3 4
=!!5 6
DateTime!!7 ?
.!!? @
Now!!@ C
;!!C D
[## 	

ForeignKey##	 
(## 
$str## 
)## 
]## 
public$$ 
virtual$$ 
ONA$$ 
?$$ 
ONA$$ 
{$$  !
get$$" %
;$$% &
set$$' *
;$$* +
}$$, -
}%% 
}&& � 
?C:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\ONA.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
ONA 
: 

BaseEntity 
{ 
[ 
Key 
] 	
[		 
DatabaseGenerated		 
(		 #
DatabaseGeneratedOption		 .
.		. /
Identity		/ 7
)		7 8
]		8 9
public

 

int

 
IdONA

 
{

 
get

 
;

 
set

 
;

  
}

! "
public 
int 
? 
IdHomologacionPais &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
=5 6
$num7 8
;8 9
[ 
Required 
] 
public 

string 
? 
RazonSocial 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
[ 	
Required	 
] 
public 

string 
? 
Siglas 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* ,
;, -
[ 	
Required	 
] 
public 

string 
? 
Ciudad 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* ,
;, -
public 
string 
? 
Correo 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
public 
string 
? 
	Direccion  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
public 
string 
? 
	PaginaWeb  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
public 
string 
? 
Telefono 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
public 
string 
? 
UrlIcono 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
public 
string 
? 
UrlLogo 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
[ 	
Required	 
] 
public 

string 
? 
InfoExtraJson  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
[ 	
Required	 
] 
public 
string 
? 
Estado 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
[ 
Required 
] 
public 

int 
? 
IdUserCreacion 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$num/ 0
;0 1
[ 	
Required	 
] 
public   

int   
?   
IdUserModifica   
{    
get  ! $
;  $ %
set  & )
;  ) *
}  + ,
=  - .
$num  / 0
;  0 1
}"" 
}## �
JC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\MigracionExcel.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
MigracionExcel 
{ 
[ 
Key 
] 	
[		 
DatabaseGenerated		 
(		 #
DatabaseGeneratedOption		 .
.		. /
Identity		/ 7
)		7 8
]		8 9
public

 

int

 
IdMigracionExcel

 
{

  !
get

" %
;

% &
set

' *
;

* +
}

, -
public 

int 
? 
MigracionNumero 
{  !
get" %
;% &
set' *
;* +
}, -
public 

string 
? 
MigracionEstado "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

string 
? 
ExcelFileName  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

string 
? 
MensageError 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
public 

DateTime 
? 
FechaCreacion "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
DateTime3 ;
.; <
Now< ?
;? @
public 

int 
IdUserCreacion 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$num. /
;/ 0
} 
} �
AC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\Menus.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
Menus 
{ 
[ 	
Key	 
] 
[		 	
DatabaseGenerated			 
(		 #
DatabaseGeneratedOption		 2
.		2 3
Identity		3 ;
)		; <
]		< =
public

 
int

 
	IdMenuRol

 
{

 
get

 "
;

" #
set

$ '
;

' (
}

) *
public 
int 
? 
IdHRol 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
? 
Rol 
{ 
get  
;  !
set" %
;% &
}' (
public 
int 
? 
IdHMenu 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
? 
Menu 
{ 
get !
;! "
set# &
;& '
}( )
[ 	
Required	 
] 
public 
string 
? 
Estado 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	
Required	 
] 
public 
DateTime 
? 
FechaCreacion &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
=5 6
DateTime7 ?
.? @
Now@ C
;C D
} 
} �

CC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\MenuRol.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
MenuRol 
{ 
[ 	
Key	 
] 
[		 	
DatabaseGenerated			 
(		 #
DatabaseGeneratedOption		 2
.		2 3
Identity		3 ;
)		; <
]		< =
public

 
int

 
	IdMenuRol

 
{

 
get

 "
;

" #
set

$ '
;

' (
}

) *
public 
int 
? 
IdHRol 
{ 
get  
;  !
set" %
;% &
}' (
public 
int 
? 
IdHMenu 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
? 
Estado 
{ 
get  #
;# $
set% (
;( )
}* +
public 
DateTime 
? 
FechaCreacion &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
=5 6
DateTime7 ?
.? @
Now@ C
;C D
} 
} �
FC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\MenuPagina.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 

MenuPagina 
{ 
public 
int 
IdHomologacion !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
string 
? 

MostrarWeb !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} �
EC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\LogScript.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
	LogScript 
: 

BaseEntity %
{ 
[ 
Key 
] 	
[		 
DatabaseGenerated		 
(		 #
DatabaseGeneratedOption		 .
.		. /
Identity		/ 7
)		7 8
]		8 9
public

 

int

 
IdLogScript

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
[ 
Required 
] 
public 

string 
? 
StateLog 
{ 
get !
;! "
set# &
;& '
}( )
[ 
Required 
] 
public 

string 
? 
TextLog 
{ 
get  
;  !
set" %
;% &
}' (
[ 
Required 
] 
public 

string 
? 
TimeRun 
{ 
get  
;  !
set" %
;% &
}' (
[ 
Required 
] 
public 

string 
? 

NameScript 
{ 
get  #
;# $
set% (
;( )
}* +
[ 
Required 
] 
public 

DateTime 
? 
TimeLog 
{ 
get "
;" #
set$ '
;' (
}) *
[ 
Required 
] 
public 

string 
? 
HostName 
{ 
get !
;! "
set# &
;& '
}( )
[ 
Required 
] 
public 

string 
? 
LoggedInUser 
{  !
get" %
;% &
set' *
;* +
}, -
[ 
Required 
] 
public 

bool 

IdLogTrace 
{ 
get  
;  !
set" %
;% &
}' (
} 
} �.
HC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\LogMigracion.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
LogMigracion 
{ 
[		 
Key		 
]		 	
[

 
DatabaseGenerated

 
(

 #
DatabaseGeneratedOption

 .
.

. /
Identity

/ 7
)

7 8
]

8 9
public 

int 
IdLogMigracion 
{ 
get  #
;# $
set% (
;( )
}* +
[ 
Required 
] 
public 

int 
IdONA 
{ 
get 
; 
set 
;  
}! "
[ 
Required 
] 
public 

string 
? 
Host 
{ 
get 
; 
set "
;" #
}$ %
=& '
$str( *
;* +
[ 
Required 
] 
public 

int 
Puerto 
{ 
get 
; 
set  
;  !
}" #
=$ %
$num& '
;' (
[ 
Required 
] 
public 

string 
? 
Usuario 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
[ 
Required 
] 
public 

string 
? 
	BaseDatos 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
[ 
Required 
] 
public 

string 
? 
OrigenDatos 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 6
;6 7
[ 
Required 
] 
public 

string 
? 
Migrar 
{ 
get 
;  
set! $
;$ %
}& '
=( )

Constantes* 4
.4 5
CONEXION_MIGRAR_S5 F
;F G
[ 
DatabaseGenerated 
( #
DatabaseGeneratedOption .
.. /
Computed/ 7
)7 8
]8 9
public 

int 
	Migracion 
{ 
get 
; 
set  #
;# $
}% &
=' (
$num) *
;* +
[ 
Required 
] 
public 

string 
? 
Estado 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* 1
;1 2
[ 
Required 
] 
public 

int 
	EsquemaId 
{ 
get 
; 
set  #
;# $
}% &
=' (
$num) *
;* +
[   
Required   
]   
public!! 

string!! 
?!! 
EsquemaVista!! 
{!!  !
get!!" %
;!!% &
set!!' *
;!!* +
}!!, -
=!!. /
$str!!0 2
;!!2 3
["" 
Required"" 
]"" 
public## 

int## 
EsquemaFilas## 
{## 
get## !
;##! "
set### &
;##& '
}##( )
=##* +
$num##, -
;##- .
[$$ 
Required$$ 
]$$ 
public%% 

string%% 
VistaOrigen%% 
{%% 
get%%  #
;%%# $
set%%% (
;%%( )
}%%* +
=%%, -
$str%%. 0
;%%0 1
[&& 
Required&& 
]&& 
public'' 

int'' 

VistaFilas'' 
{'' 
get'' 
;''  
set''! $
;''$ %
}''& '
=''( )
$num''* +
;''+ ,
[(( 
DatabaseGenerated(( 
((( #
DatabaseGeneratedOption(( .
.((. /
Computed((/ 7
)((7 8
]((8 9
public)) 

string)) 
?)) 
Tiempo)) 
{)) 
get)) 
;))  
set))! $
;))$ %
}))& '
=))( )
$str))* ,
;)), -
public** 

DateTime** 
?** 
Inicio** 
{** 
get** !
;**! "
set**# &
;**& '
}**( )
=*** +
DateTime**, 4
.**4 5
Now**5 8
;**8 9
public++ 

DateTime++ 
?++ 
Final++ 
{++ 
get++  
;++  !
set++" %
;++% &
}++' (
=++) *
DateTime+++ 3
.++3 4
Now++4 7
;++7 8
public,, 

DateTime,, 
?,, 
Fecha,, 
{,, 
get,,  
;,,  !
set,," %
;,,% &
},,' (
=,,) *
DateTime,,+ 3
.,,3 4
Now,,4 7
;,,7 8
public-- 

string-- 
Observacion-- 
{-- 
get--  #
;--# $
set--% (
;--( )
}--* +
=--, -
$str--. 0
;--0 1
public.. 

string.. 
?.. 
ExcelFileName..  
{..! "
get..# &
;..& '
set..( +
;..+ ,
}..- .
=../ 0
$str..1 3
;..3 4
}// 
}00 �
OC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\LogMigracionDetalle.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
LogMigracionDetalle "
{ 
public 

LogMigracionDetalle 
( 
)  
{! "
SetDefaults# .
(. /
)/ 0
;0 1
}2 3
public 

LogMigracionDetalle 
( 
LogMigracion +
logMigracion, 8
)8 9
{		 
SetDefaults 
( 
) 
; 
} 
[ 
Key 
] 	
public 

int !
IdLogMigracionDetalle $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 

int 
? 
IdLogMigracion 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

int 
? 
NroMigracion 
{ 
get "
;" #
set$ '
;' (
}) *
public 

int 
? 
IdEsquemaVista 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

int 
? 
ColumnaEsquemaIdH !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

string 
? 
ColumnaEsquema !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

string 
? 
ColumnaVista 
{  !
get" %
;% &
set' *
;* +
}, -
public 

bool 
ColumnaVistaPK 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

DateTime 
Fecha 
{ 
get 
;  
set! $
;$ %
}& '
=( )
DateTime* 2
.2 3
Now3 6
;6 7
private 
void 
SetDefaults 
( 
) 
{  
}%% 
}&& 
}'' �
HC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\Homologacion.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
Homologacion 
: 

BaseEntity  *
{ 
[ 	
Key	 
] 
public 
int 
IdHomologacion !
{" #
get$ '
;' (
set) ,
;, -
}. /
public		 
int		 
?		 
IdHomologacionGrupo		 '
{		( )
get		* -
;		- .
set		/ 2
;		2 3
}		4 5
=		6 7
$num		8 9
;		9 :
public 
int 
?  
IdHomologacionFiltro (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
=7 8
null9 =
;= >
[ 	
Required	 
] 
public 
string 
? 
Mostrar 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
[ 	
Required	 
] 
public 
int 
MostrarWebOrden "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$num3 4
;4 5
[ 	
Required	 
] 
public 
string 
? 

MostrarWeb !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
$str2 4
;4 5
[ 	
Required	 
] 
public 
string 
? 

TooltipWeb !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
$str2 4
;4 5
[ 	
Required	 
] 
public 
string 
? 
MascaraDato "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
[ 	
Required	 
] 
public 
string 
? 
SiNoHayDato "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
[ 	
Required	 
] 
public 
string 
? 
InfoExtraJson $
{% &
get' *
;* +
set, /
;/ 0
}1 2
=3 4
$str5 7
;7 8
[ 	
Required	 
] 
public 
string 
? 
CodigoHomologacion )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
=8 9
$str: <
;< =
[ 	
Required	 
] 
public 
string 
? 
NombreHomologado '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
=6 7
$str8 :
;: ;
[ 	
Required	 
] 
public   
string   
?   
Estado   
{   
get    #
;  # $
set  % (
;  ( )
}  * +
=  , -
$str  . 0
;  0 1
[!! 	
Required!!	 
]!! 
public"" 
string"" 
?"" 
Indexar"" 
{""  
get""! $
;""$ %
set""& )
;"") *
}""+ ,
=""- .
$str""/ 1
;""1 2
}$$ 
}%% �
EC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\EventUser.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
	EventUser 
{ 
public 
int 
CodigoEvento 
{  !
get" %
;% &
set' *
;* +
}, -
public 
int 
CodigoUsuario  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
string 
	OnaSiglas 
{  !
get" %
;% &
set' *
;* +
}, -
public 
string 
Nombre 
{ 
get "
;" #
set$ '
;' (
}) *
public		 
string		 
Apellido		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
public

 
string

 
UsuarioEmail

 "
{

# $
get

% (
;

( )
set

* -
;

- .
}

/ 0
public 
string 
UsuarioTipo !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
string 
Pagina 
{ 
get "
;" #
set$ '
;' (
}) *
public 
string 
PaginaControl #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
string 
PaginaAccion "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
string 
	UsuarioIP 
{  !
get" %
;% &
set' *
;* +
}, -
public 
string 
UsuarioPais !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
string 
UsuarioCiudad #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
string 
? 
ExactaBuscar #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
string 
? 
TextoBuscar "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
string 
? 

FiltroPais !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
string 
? 
	FiltroOna  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
string 
? 
FiltroEsquema $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 
string 
? 
FiltroNorma "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
string 
? 
FiltroEstado #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
string 
?  
FiltroRecomocimiento +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
public 
string 
ErrorTracking #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
DateTime 
FechaCreacion %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
} 
} �
IC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\EventTracking.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
EventTracking 
{ 
[ 	
Key	 
] 
public		 
int		 
IdEventTracking		 "
{		# $
get		% (
;		( )
set		* -
;		- .
}		/ 0
[ 	
Required	 
] 
public 
string !
CodigoHomologacionRol +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
=: ;
string< B
.B C
EmptyC H
;H I
[ 	
Required	 
] 
public 
string 
NombreUsuario #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
string4 :
.: ;
Empty; @
;@ A
[ 	
Required	 
] 
public 
string "
CodigoHomologacionMenu ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
=; <
string= C
.C D
EmptyD I
;I J
[ 	
Required	 
] 
public 
string 
NombreControl #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
string4 :
.: ;
Empty; @
;@ A
[ 	
Required	 
] 
public 
string 
NombreAccion "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
string3 9
.9 :
Empty: ?
;? @
[ 	
Required	 
] 
public 
string 
UbicacionJson #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
$str4 8
;8 9
[ 	
Required	 
] 
public 
string 
ParametroJson #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
$str4 8
;8 9
[   	
Required  	 
]   
public!! 
string!! 
ErrorTracking!! #
{!!$ %
get!!& )
;!!) *
set!!+ .
;!!. /
}!!0 1
=!!2 3
string!!4 :
.!!: ;
Empty!!; @
;!!@ A
[## 	
Required##	 
]## 
public$$ 
DateTime$$ 
FechaCreacion$$ %
{$$& '
get$$( +
;$$+ ,
set$$- 0
;$$0 1
}$$2 3
=$$4 5
DateTime$$6 >
.$$> ?
UtcNow$$? E
;$$E F
}%% 
}&& �
OC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\EsquemaVistaColumna.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
EsquemaVistaColumna "
:# $

BaseEntity% /
{ 
[ 
Key 
] 	
[		 
DatabaseGenerated		 
(		 #
DatabaseGeneratedOption		 .
.		. /
Identity		/ 7
)		7 8
]		8 9
public

 

int

 !
IdEsquemaVistaColumna

 $
{

% &
get

' *
;

* +
set

, /
;

/ 0
}

1 2
[ 
Required 
] 
public 

int 
IdEsquemaVista 
{ 
get  #
;# $
set% (
;( )
}* +
[ 
Required 
] 
public 

int 
ColumnaEsquemaIdH  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 
Required 
] 
public 

string 
? 
ColumnaEsquema !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 
Required 
] 
public 

string 
? 
ColumnaVista 
{  !
get" %
;% &
set' *
;* +
}, -
[ 
Required 
] 
public 

bool 
ColumnaVistaPK 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 
Required 
] 
public 

string 
? 
Estado 
{ 
get 
;  
set! $
;$ %
}& '
[ 

ForeignKey 
( 
$str  
)  !
]! "
public 

EsquemaVista 
? 
EsquemaVista %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
} 
} �
HC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\EsquemaVista.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 

class 
EsquemaVista 
: 

BaseEntity  *
{ 
[		 	
Key			 
]		 
[

 	
DatabaseGenerated

	 
(

 #
DatabaseGeneratedOption

 2
.

2 3
Identity

3 ;
)

; <
]

< =
public 
int 
IdEsquemaVista !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
int 
IdONA 
{ 
get 
; 
set  #
;# $
}% &
public 
int 
	IdEsquema 
{ 
get "
;" #
set$ '
;' (
}) *
[ 	
Required	 
] 
public 
string 
VistaOrigen !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
$str2 4
;4 5
[ 	
Required	 
] 
public 
string 
Estado 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,

Constantes- 7
.7 8
ESTADO_USUARIO_A8 H
;H I
[ 	

ForeignKey	 
( 
$str 
) 
] 
public 
ONA 
? 
ONA 
{ 
get 
; 
set "
;" #
}$ %
[ 	

ForeignKey	 
( 
$str 
)  
]  !
public 
Esquema 
? 
Esquema 
{  !
get" %
;% &
set' *
;* +
}, -
} 
} �	
KC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\EsquemaFullText.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
EsquemaFullText 
{ 
[ 
Key 
] 	
[		 
DatabaseGenerated		 
(		 #
DatabaseGeneratedOption		 .
.		. /
Identity		/ 7
)		7 8
]		8 9
public

 

int

 
IdEsquemaFullText

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
[ 
Required 
] 
public 

int 
IdEsquemaData 
{ 
get  #
;# $
set% (
;( )
}* +
[ 
Required 
] 
public 

int 
IdHomologacion 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
? 
FullTextData 
{  !
get" %
;% &
set' *
;* +
}, -
} 
} �
GC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\EsquemaData.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
EsquemaData 
{ 
[ 
Key 
] 	
[		 
DatabaseGenerated		 
(		 #
DatabaseGeneratedOption		 .
.		. /
Identity		/ 7
)		7 8
]		8 9
public

 

int

 
IdEsquemaData

 
{

 
get

 "
;

" #
set

$ '
;

' (
}

) *
[ 
Required 
] 
public 

int 
IdEsquemaVista 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
? 
VistaFK 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
[ 
Required 
] 
public 

string 
? 
VistaPK 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
[ 
Required 
] 
public 

string 
DataEsquemaJson !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
$str2 6
;6 7
[ 
Required 
] 
public 

DateTime 
	DataFecha 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
DateTime. 6
.6 7
Now7 :
;: ;
} 
} �
CC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\Esquema.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
class	 
Esquema 
: 

BaseEntity #
{ 
[		 
Key		 
]		 	
[

 
DatabaseGenerated

 
(

 #
DatabaseGeneratedOption

 .
.

. /
Identity

/ 7
)

7 8
]

8 9
public 

int 
	IdEsquema 
{ 
get 
; 
set  #
;# $
}% &
[ 
Required 
] 
public 

int 
MostrarWebOrden 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 
Required 
] 
public 

string 

MostrarWeb 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
[ 
Required 
] 
public 

string 

TooltipWeb 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
[ 
Required 
] 
public 

string 
EsquemaVista 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
[ 
Required 
] 
public 

string 
EsquemaJson 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
[ 
Required 
] 
public 

string 
Estado 
{ 
get 
; 
set  #
;# $
}% &
=' (

Constantes) 3
.3 4
ESTADO_USUARIO_A4 D
;D E
} 
} �	
FC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Models\BaseEntity.cs
	namespace 	

DataAccess
 
. 
Models 
{ 
public 
abstract	 
class 

BaseEntity "
{ 
public 

DateTime 
? 
FechaCreacion "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
DateTime3 ;
.; <
Now< ?
;? @
public 

DateTime 
? 
FechaModifica "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
DateTime3 ;
.; <
Now< ?
;? @
public 

int 
IdUserCreacion 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$num. /
;/ 0
public 

int 
IdUserModifica 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$num. /
;/ 0
}		 
}

 �
RC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IUsuarioRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 
IUsuarioRepository %
{ 
Usuario 
? 
FindById 
( 
int 
	idUsuario '
)' (
;( )
Usuario 
? 
FindByEmail 
( 
string #
email$ )
)) *
;* +
bool 
Create 
( 
Usuario 
usuario #
)# $
;$ %
bool"" 
Update"" 
("" 
Usuario"" 
usuario"" #
)""# $
;""$ %
bool)) 
IsUniqueUser)) 
()) 
string))  
usuario))! (
)))( )
;))) *
ICollection// 
<// 

UsuarioDto// 
>// 
FindAll//  '
(//' (
)//( )
;//) *
Result66 
<66 
bool66 
>66 
ChangePasswd66 !
(66! "
string66" (
clave66) .
,66. /
string660 6

claveNueva667 A
,66A B
int66C F
	idUsuario66G P
,66P Q
string66R X
nueva66Y ^
)66^ _
;66_ `
}88 
}99 �
ZC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IUsuarioEndpointRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 &
IUsuarioEndpointRepository -
{ 
ICollection 
< 
UsuarioEndpoint #
># $
FindAll% ,
(, -
)- .
;. /
UsuarioEndpoint 
? 
FindByEndpointId )
() *
int* -

endpointId. 8
)8 9
;9 :
bool 
Create 
( 
UsuarioEndpoint #
UsuarioEndpoint$ 3
)3 4
;4 5
} 
} �
WC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IUsuarioEmailRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 #
IUsuarioEmailRepository *
{ 
UserEmailDto 
ObtenerUsuario #
(# $
string$ *
User+ /
)/ 0
;0 1
List 
< 
UserEmailDto 
> 
ObtenerUsuarios *
(* +
int+ .
IdOna/ 4
)4 5
;5 6
} 
} �
TC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IThesaurusRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface  
IThesaurusRepository )
{ 
	Thesaurus 
ObtenerThesaurus "
(" #
)# $
;$ %
void 
GuardarThesaurus 
( 
	Thesaurus '
	thesaurus( 1
)1 2
;2 3
void 
EjecutarArchivoBat 
(  
)  !
;! "
string 
ResetSQLServer 
( 
) 
;  
} 
} �
ZC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\ISqlServerDbContextFactory.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 &
ISqlServerDbContextFactory -
{ 
SqlServerDbContext 
CreateDbContext *
(* +
)+ ,
;, -
} 
} �
RC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IReporteRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface 
IReporteRepository '
{ 
VwHomologacion 
findByVista "
(" #
string# )
codigoHomologacion* <
)< =
;= >
List 
< 
VwAcreditacionOna 
> $
ObtenerVwAcreditacionOna  8
(8 9
)9 :
;: ;
List 
< !
VwAcreditacionEsquema "
>" #(
ObtenerVwAcreditacionEsquema$ @
(@ A
)A B
;B C
List 
< 
VwEstadoEsquema 
> "
ObtenerVwEstadoEsquema 4
(4 5
)5 6
;6 7
List$$ 
<$$ 
	VwOecPais$$ 
>$$ 
ObtenerVwOecPais$$ (
($$( )
)$$) *
;$$* +
List** 
<** 
VwEsquemaPais** 
>**  
ObtenerVwEsquemaPais** 0
(**0 1
)**1 2
;**2 3
List00 
<00 

VwOecFecha00 
>00 
ObtenerVwOecFecha00 *
(00* +
)00+ ,
;00, -
List66 
<66 #
VwProfesionalCalificado66 $
>66$ %*
ObtenerVwProfesionalCalificado66& D
(66D E
)66E F
;66F G
List<< 
<<< 
VwProfesionalOna<< 
><< #
ObtenerVwProfesionalOna<< 6
(<<6 7
)<<7 8
;<<8 9
ListBB 
<BB  
VwProfesionalEsquemaBB !
>BB! "'
ObtenerVwProfesionalEsquemaBB# >
(BB> ?
)BB? @
;BB@ A
ListHH 
<HH 
VwProfesionalFechaHH 
>HH  %
ObtenerVwProfesionalFechaHH! :
(HH: ;
)HH; <
;HH< =
ListNN 
<NN 
VwCalificaUbicacionNN  
>NN  !&
ObtenerVwCalificaUbicacionNN" <
(NN< =
)NN= >
;NN> ?
ListUU 
<UU 
VwBusquedaFechaUU 
>UU "
ObtenerVwBusquedaFechaUU 4
(UU4 5
)UU5 6
;UU6 7
List[[ 
<[[ 
VwBusquedaFiltro[[ 
>[[ #
ObtenerVwBusquedaFiltro[[ 6
([[6 7
)[[7 8
;[[8 9
Listaa 
<aa 
VwBusquedaUbicacionaa  
>aa  !&
ObtenerVwBusquedaUbicacionaa" <
(aa< =
)aa= >
;aa> ?
Listgg 
<gg 
VwActualizacionONAgg 
>gg  %
ObtenerVwActualizacionONAgg! :
(gg: ;
)gg; <
;gg< =
Listmm 
<mm !
VwOrganismoRegistradomm "
>mm" #(
ObtenerVwOrganismoRegistradomm$ @
(mm@ A
)mmA B
;mmB C
Listss 
<ss !
VwOrganizacionEsquemass "
>ss" #(
ObtenerVwOrganizacionEsquemass$ @
(ss@ A
)ssA B
;ssB C
Listyy 
<yy  
VwOrganismoActividadyy !
>yy! "'
ObtenerVwOrganismoActividadyy# >
(yy> ?
)yy? @
;yy@ A
}{{ 
}|| �
]C:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IpaActualizarFiltroRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface )
IpaActualizarFiltroRepository 2
{ 
Task		 
<		 
bool		 
>		 !
ActualizarFiltroAsync		 (
(		( )
)		) *
;		* +
} 
} �
NC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IONARepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 
IONARepository !
{ 
bool 
Update 
( 
ONA 
data 
, 
int !
	userToken" +
)+ ,
;, -
bool 
Create 
( 
ONA 
data 
) 
; 
ONA 
? 
FindById 
( 
int 
Id 
) 
; 
ONA!! 
?!! 
FindBySiglas!! 
(!! 
string!!  
siglas!!! '
)!!' (
;!!( )
List'' 
<'' 
ONA'' 
>'' 
FindAll'' 
('' 
)'' 
;'' 
List-- 
<-- 
VwPais-- 
>-- 
FindAllPaises-- "
(--" #
)--# $
;--$ %
Task44 
<44 
ONA44 
?44 
>44 
FindByIdAsync44  
(44  !
int44! $
Id44% '
)44' (
;44( )
List;; 
<;; 
ONA;; 
>;; 
GetListByONAsAsync;; $
(;;$ %
int;;% (
idOna;;) .
);;. /
;;;/ 0
}>> 
}?? �
UC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IOnaMigrateRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface !
IOnaMigrateRepository *
{ 
List 
< 
OnaMigrateDto 
> 
postOnaMigrate *
(* +
int+ .
idOna/ 4
,4 5
int6 9
idEsquemaVista: H
,H I
stringJ P
jsonParameterQ ^
)^ _
;_ `
} 
}		 �
VC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IONAConexionRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface "
IONAConexionRepository +
{ 
bool 
Update 
( 
ONAConexion 
data  $
,$ %
int& )
	userToken* 3
)3 4
;4 5
bool 
Create 
( 
ONAConexion 
data  $
)$ %
;% &
ONAConexion 
? 
FindById 
( 
int !
Id" $
)$ %
;% &
ONAConexion!! 
?!! 
FindByIdONA!!  
(!!  !
int!!! $
IdONA!!% *
)!!* +
;!!+ ,
Task(( 
<(( 
ONAConexion(( 
?(( 
>(( 
FindByIdONAAsync(( +
(((+ ,
int((, /
IdONA((0 5
)((5 6
;((6 7
List.. 
<.. 
ONAConexion.. 
>.. 
FindAll.. !
(..! "
).." #
;..# $
List55 
<55 
ONAConexion55 
>55 (
GetOnaConexionByOnaListAsync55 6
(556 7
int557 :
IdONA55; @
)55@ A
;55A B
}77 
}88 �
IC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IMigrador.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface 
	IMigrador 
{ 
Task 
< 
bool 
> 
MigrarAsync 
( 
ONAConexion *
conexion+ 3
)3 4
;4 5
} 
} �	
YC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IMigracionExcelRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 %
IMigracionExcelRepository ,
{ 
bool 
Update 
( 
LogMigracion  
data! %
)% &
;& '
Task 
< 
bool 
> 
UpdateAsync 
( 
LogMigracion +
data, 0
)0 1
;1 2
LogMigracion 
Create 
( 
LogMigracion (
data) -
)- .
;. /
Task!! 
<!! 
LogMigracion!! 
>!! 
CreateAsync!! &
(!!& '
LogMigracion!!' 3
data!!4 8
)!!8 9
;!!9 :
MigracionExcel(( 
?(( 
FindById((  
(((  !
int((! $
Id((% '
)((' (
;((( )
List.. 
<.. 
MigracionExcel.. 
>.. 
FindAll.. $
(..$ %
)..% &
;..& '
}00 
}11 �
OC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IMenuRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface 
IMenuRepository $
{ 
bool 
Update 
( 
MenuRol 
data  
)  !
;! "
bool 
Create 
( 
MenuRol 
data  
)  !
;! "
Menus 
? 
FindDataById 
( 
int 
idHRol  &
,& '
int( +
idHMenu, 3
)3 4
;4 5
MenuRol## 
?## 
FindById## 
(## 
int## 
idHRol## $
,##$ %
int##& )
idHMenu##* 1
)##1 2
;##2 3
List)) 
<)) 
Menus)) 
>)) 
FindAll)) 
()) 
))) 
;)) 
List11 
<11 
Menus11 
>11 
GetListByMenusAsync11 '
(11' (
int11( +
idHRol11, 2
,112 3
int114 7
idHMenu118 ?
)11? @
;11@ A
List22 
<22 

MenuPagina22 
>22 %
ObtenerMenusPendingConfig22 2
(222 3
int223 6
idHomologacionRol227 H
)22H I
;22I J
}44 
}55 �
WC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\ILogMigracionRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 #
ILogMigracionRepository *
{ 
bool 
Update 
( 
LogMigracion  
data! %
)% &
;& '
Task 
< 
bool 
> 
UpdateAsync 
( 
LogMigracion +
data, 0
)0 1
;1 2
LogMigracion 
Create 
( 
LogMigracion (
data) -
)- .
;. /
Task!! 
<!! 
LogMigracion!! 
>!! 
CreateAsync!! &
(!!& '
LogMigracion!!' 3
data!!4 8
)!!8 9
;!!9 :
LogMigracion(( 
?(( 
FindById(( 
((( 
int(( "
Id((# %
)((% &
;((& '
List.. 
<.. 
LogMigracion.. 
>.. 
FindAll.. "
(.." #
)..# $
;..$ %
bool55 
UpdateDetalle55 
(55 
LogMigracionDetalle55 .
data55/ 3
)553 4
;554 5
LogMigracionDetalle== 
CreateDetalle== )
(==) *
LogMigracionDetalle==* =
data==> B
)==B C
;==C D
TaskDD 
<DD 
LogMigracionDetalleDD  
>DD  !
CreateDetalleAsyncDD" 4
(DD4 5
LogMigracionDetalleDD5 H
dataDDI M
)DDM N
;DDN O
ListJJ 
<JJ 
LogMigracionDetalleJJ  
>JJ  !
FindAllDetalleJJ" 0
(JJ0 1
)JJ1 2
;JJ2 3
ListQQ 
<QQ 
LogMigracionDetalleQQ  
>QQ  !
FindDetalleByIdQQ" 1
(QQ1 2
intQQ2 5
IdQQ6 8
)QQ8 9
;QQ9 :
}TT 
}UU �
SC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IImportarRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface 
IImportarRepository (
{ 
string  
buildSelectViewQuery #
(# $
int$ '
[' (
]( )
homologacionIds* 9
,9 :
string; A
[A B
]B C
selectFieldsD P
,P Q
stringR X
viewNameY a
)a b
;b c
bool 
executeQueryView 
( 
string $
selectQuery% 0
)0 1
;1 2
} 
} �
WC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IHomologacionRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface #
IHomologacionRepository ,
{ 
bool 
Update 
( 
Homologacion  
data! %
)% &
;& '
bool 
Create 
( 
Homologacion  
data! %
)% &
;& '
Homologacion 
? 
FindById 
( 
int "
id# %
)% &
;& '
ICollection   
<   
Homologacion    
>    !
FindByParent  " .
(  . /
)  / 0
;  0 1
List'' 
<'' 
Homologacion'' 
>'' 
	FindByIds'' $
(''$ %
int''% (
[''( )
]'') *
ids''+ .
)''. /
;''/ 0
List.. 
<.. 
VwHomologacion.. 
>.. *
ObtenerVwHomologacionPorCodigo.. ;
(..; <
string..< B
codigoHomologacion..C U
)..U V
;..V W
List44 
<44 
Homologacion44 
>44 
	FindByAll44 $
(44$ %
)44% &
;44& '
}77 
}88 �
XC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IEventTrackingRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public		 

	interface		 $
IEventTrackingRepository		 -
{

 
bool 
Create 
( !
paAddEventTrackingDto )
data* .
). /
;/ 0
string 
GetCodeByUser 
( 
string #
nombreUsuario$ 1
,1 2
string3 9!
CodigoHomologacionRol: O
,O P
stringQ W"
CodigoHomologacionMenuX n
)n o
;o p
Menus!! 
?!! 
FindDataById!! 
(!! 
int!! 
idHRol!!  &
,!!& '
int!!( +
idHMenu!!, 3
)!!3 4
;!!4 5
List(( 
<(( 
VwEventUserAll(( 
>(( 
GetEventUserAll(( ,
(((, -
)((- .
;((. /
List11 
<11 
	EventUser11 
>11 
GetEventAll11 #
(11# $
string11$ *
report11+ 1
,111 2
DateOnly113 ;
fini11< @
,11@ A
DateOnly11B J
ffin11K O
)11O P
;11P Q
bool99 
DeleteEventAll99 
(99 
DateOnly99 $
fini99% )
,99) *
DateOnly99+ 3
ffin994 8
)998 9
;999 :
bool@@ 
DeleteEventById@@ 
(@@ 
int@@  
id@@! #
)@@# $
;@@$ %
ListFF 
<FF %
VwEventTrackingSessionDtoFF &
>FF& '
GetEventSessionFF( 7
(FF7 8
)FF8 9
;FF9 :
ListLL 
<LL !
PaginasMasVisitadaDtoLL "
>LL" #
GetEventPagMasVisitLL$ 7
(LL7 8
)LL8 9
;LL9 :
ListRR 
<RR 
FiltrosMasUsadoDtoRR 
>RR   
GetEventFiltroMasUsaRR! 5
(RR5 6
)RR6 7
;RR7 8
}SS 
}TT �
WC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IEsquemaVistaRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 #
IEsquemaVistaRepository *
{ 
bool 
Update 
( 
EsquemaVista  
data! %
)% &
;& '
bool 
Create 
( 
EsquemaVista  
data! %
)% &
;& '
EsquemaVista 
? 
FindById 
( 
int "
Id# %
)% &
;& '
EsquemaVista!! 
?!! 
FindByIdEsquema!! %
(!!% &
int!!& )
	IdEsquema!!* 3
)!!3 4
;!!4 5
EsquemaVista)) 
?)) 
_FindByIdEsquema)) &
())& '
int))' *
	IdEsquema))+ 4
,))4 5
int))6 9
idOna)): ?
)))? @
;))@ A
Task11 
<11 
EsquemaVista11 
?11 
>11 !
_FindByIdEsquemaAsync11 1
(111 2
int112 5
	IdEsquema116 ?
,11? @
int11A D
idOna11E J
)11J K
;11K L
List77 
<77 
EsquemaVista77 
>77 
FindAll77 "
(77" #
)77# $
;77$ %
}:: 
};; �
^C:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IEsquemaVistaColumnaRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface *
IEsquemaVistaColumnaRepository 3
{ 
bool 
Update 
( 
EsquemaVistaColumna '
data( ,
), -
;- .
bool 
Create 
( 
EsquemaVistaColumna '
data( ,
), -
;- .
EsquemaVistaColumna$$ 
?$$ 
FindById$$ %
($$% &
int$$& )
Id$$* ,
)$$, -
;$$- .
List.. 
<.. 
EsquemaVistaColumna..  
>..  ! 
FindByIdEsquemaVista.." 6
(..6 7
int..7 :
IdEsquemaVista..; I
)..I J
;..J K
List99 
<99 
EsquemaVistaColumna99  
>99  !#
FindByIdEsquemaVistaOna99" 9
(999 :
int99: =
IdEsquemaVista99> L
,99L M
int99N Q
IdOna99R W
)99W X
;99X Y
TaskDD 
<DD 
ListDD 
<DD 
EsquemaVistaColumnaDD %
>DD% &
>DD& '(
FindByIdEsquemaVistaOnaAsyncDD( D
(DDD E
intDDE H
IdEsquemaVistaDDI W
,DDW X
intDDY \
IdOnaDD] b
)DDb c
;DDc d
ListMM 
<MM 
EsquemaVistaColumnaMM  
>MM  !
FindAllMM" )
(MM) *
)MM* +
;MM+ ,
}PP 
}QQ �
RC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IEsquemaRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 
IEsquemaRepository %
{ 
bool 
Update 
( 
Esquema 
data  
)  !
;! "
bool 
Create 
( 
Esquema 
data  
)  !
;! "
Esquema$$ 
?$$ 
FindById$$ 
($$ 
int$$ 
Id$$  
)$$  !
;$$! "
Esquema// 
?// 
FindByViewName// 
(//  
string//  &
esquemaVista//' 3
)//3 4
;//4 5
Task:: 
<:: 
Esquema:: 
?:: 
>:: 
FindByViewNameAsync:: *
(::* +
string::+ 1
esquemaVista::2 >
)::> ?
;::? @
ListCC 
<CC 
EsquemaCC 
>CC 
FindAllCC 
(CC 
)CC 
;CC  
ListLL 
<LL 
EsquemaLL 
>LL 
FindAllWithViewsLL &
(LL& '
)LL' (
;LL( )
ListVV 
<VV 
EsquemaVV 
>VV  
GetListaEsquemaByOnaVV *
(VV* +
intVV+ .
idONAVV/ 4
)VV4 5
;VV5 6
bool`` #
UpdateEsquemaValidacion`` $
(``$ %
EsquemaVista``% 1
data``2 6
)``6 7
;``7 8
booljj #
CreateEsquemaValidacionjj $
(jj$ %
EsquemaVistajj% 1
datajj2 6
)jj6 7
;jj7 8
booltt ;
/EliminarEsquemaVistaColumnaByIdEquemaVistaAsynctt <
(tt< =
inttt= @
idttA C
)ttC D
;ttD E!
EsquemaVistaColumna
�� 
?
�� 8
*GetEsquemaVistaColumnaByIdEquemaVistaAsync
�� G
(
��G H
int
��H K
idOna
��L Q
,
��Q R
int
��S V
	idEsquema
��W `
)
��` a
;
��a b
bool
�� -
GuardarListaEsquemaVistaColumna
�� ,
(
��, -
List
��- 1
<
��1 2!
EsquemaVistaColumna
��2 E
>
��E F&
listaEsquemaVistaColumna
��G _
,
��_ `
int
��a d
?
��d e
idOna
��f k
,
��k l
int
��m p
?
��p q
intidEsquema
��r ~
)
��~ 
;�� �
}
�� 
}�� �
ZC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IEsquemaFullTextRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 &
IEsquemaFullTextRepository -
{ 
EsquemaFullText 
Create 
( 
EsquemaFullText .
data/ 3
)3 4
;4 5
Task 
< 
EsquemaFullText 
> 
CreateAsync )
() *
EsquemaFullText* 9
data: >
)> ?
;? @
EsquemaFullText$$ 
?$$ 
FindById$$ !
($$! "
int$$" %
Id$$& (
)$$( )
;$$) *
}'' 
}(( �
VC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IEsquemaDataRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 "
IEsquemaDataRepository )
{ 
bool 
Update 
( 
EsquemaData 
data  $
)$ %
;% &
EsquemaData 
? 
Create 
( 
EsquemaData '
data( ,
), -
;- .
Task%% 
<%% 
EsquemaData%% 
?%% 
>%% 
CreateAsync%% &
(%%& '
EsquemaData%%' 2
data%%3 7
)%%7 8
;%%8 9
EsquemaData00 
?00 
FindById00 
(00 
int00 !
Id00" $
)00$ %
;00% &
ICollection99 
<99 
EsquemaData99 
>99  
FindAll99! (
(99( )
)99) *
;99* +
intBB 
	GetLastIdBB 
(BB 
)BB 
;BB 
boolMM 
DeleteOldRecordsMM 
(MM 
intMM !
idONAMM" '
)MM' (
;MM( )
TaskWW 
<WW 
boolWW 
>WW !
DeleteOldRecordsAsyncWW (
(WW( )
intWW) ,
IdEsquemaVistaWW- ;
)WW; <
;WW< =
booldd 
DeleteOldRecorddd 
(dd 
stringdd #
idVistadd$ +
,dd+ ,
stringdd- 3
idEntedd4 :
,dd: ;
intdd< ?

idConexiondd@ J
,ddJ K
intddL O!
idHomologacionEsquemaddP e
)dde f
;ddf g
boolqq %
DeleteByExcludingVistaIdsqq &
(qq& '
Listqq' +
<qq+ ,
stringqq, 2
>qq2 3
idsVistaqq4 <
,qq< =
stringqq> D
idEnteqqE K
,qqK L
intqqM P

idConexionqqQ [
,qq[ \
intqq] `
idEsquemaDataqqa n
)qqn o
;qqo p
bool{{ 
DeleteDataAntigua{{ 
({{ 
int{{ "
idONA{{# (
){{( )
;{{) *
}~~ 
} �
RC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IDynamicRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface 
IDynamicRepository '
{ 
List 
< 
PropiedadesTablaDto  
>  !
GetProperties" /
(/ 0
int0 3
idONA4 9
,9 :
string; A
viewNameB J
)J K
;K L
List 
< 
PropiedadesTablaDto  
>  !
GetValueColumna" 1
(1 2
int2 5
idONA6 ;
,; <
string= C
valueColumnD O
,O P
stringQ W
viewNameX `
)` a
;a b
List'' 
<'' 
string'' 
>'' 
GetViewNames'' !
(''! "
int''" %
idONA''& +
)''+ ,
;'', -
List22 
<22 
EsquemaVistaDto22 
>22 %
GetListaValidacionEsquema22 7
(227 8
int228 ;
idONA22< A
,22A B
int22C F
idEsquemaVista22G U
)22U V
;22V W
ONAConexion<< 
GetConexion<< 
(<<  
int<<  #
idONA<<$ )
)<<) *
;<<* +
boolFF "
TestDatabaseConnectionFF #
(FF# $
ONAConexionFF$ /
conexionFF0 8
)FF8 9
;FF9 :
TaskPP 
<PP 
boolPP 
>PP 
MigrarConexionAsyncPP &
(PP& '
intPP' *
idONAPP+ 0
)PP0 1
;PP1 2
}SS 
}TT �
QC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IDbContextFactory.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface 
IDbContextFactory &
{ 
	DbContext 
CreateDbContext !
(! "
string" (
connectionString) 9
,9 :
DatabaseType; G
databaseTypeH T
)T U
;U V
} 
} �
^C:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IConectionStringBuilderService.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 
	interface	 *
IConectionStringBuilderService 1
{ 
string !
BuildConnectionString $
($ %
ONAConexion% 0
conexion1 9
)9 :
;: ;
} 
} �
TC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\ICatalogosRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface  
ICatalogosRepository )
{ 
List 
< 
VwGrilla 
> 
ObtenerVwGrilla &
(& '
)' (
;( )
List 
< 
VwFiltro 
> 
ObtenerVwFiltro &
(& '
)' (
;( )
List"" 
<"" 
vw_FiltrosAnidados"" 
>""  "
ObtenerFiltrosAnidados""! 7
(""7 8
List""8 <
<""< ='
FiltrosBusquedaSeleccionDto""= X
>""X Y 
filtrosSeleccionados""Z n
)""n o
;""o p
List++ 
<++ 
vw_FiltrosAnidados++ 
>++  %
ObtenerFiltrosAnidadosAll++! :
(++: ;
)++; <
;++< =
List66 
<66 
VwDimension66 
>66 
ObtenerVwDimension66 ,
(66, -
)66- .
;66. /
List?? 
<?? 
Homologacion?? 
>?? 
ObtenerGrupos?? (
(??( )
)??) *
;??* +
VwHomologacionGrupoJJ 
?JJ 
FindVwHGByCodeJJ +
(JJ+ ,
stringJJ, 2
codigoHomologacionJJ3 E
)JJE F
;JJF G
ListTT 
<TT 
vwFiltroDetalleTT 
>TT !
ObtenerFiltroDetallesTT 3
(TT3 4
stringTT4 :
codigoTT; A
)TTA B
;TTB C
List]] 
<]] 
VwRol]] 
>]] 
ObtenerVwRol]]  
(]]  !
)]]! "
;]]" #
VwRolgg 
FindVwRolByHIdgg 
(gg 
intgg  
idHomologacionRolgg! 2
)gg2 3
;gg3 4
Listpp 
<pp 
VwMenupp 
>pp 
ObtenerVwMenupp "
(pp" #
)pp# $
;pp$ %
Listyy 
<yy 
ONAyy 
>yy 

ObtenerOnayy 
(yy 
)yy 
;yy 
List
�� 
<
�� 
vwONA
�� 
>
�� 
ObtenervwOna
��  
(
��  !
)
��! "
;
��" #
List
�� 
<
�� !
VwHomologacionGrupo
��  
>
��  !(
ObtenerVwHomologacionGrupo
��" <
(
��< =
)
��= >
;
��> ?
List
�� 
<
�� 

vwPanelONA
�� 
>
�� 
ObtenerVwPanelOna
�� *
(
��* +
)
��+ ,
;
��, -
List
�� 
<
�� 
vwEsquemaOrganiza
�� 
>
�� &
ObtenervwEsquemaOrganiza
��  8
(
��8 9
)
��9 :
;
��: ;
}
�� 
}�� �
SC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Interfaces\IBuscadorRepository.cs
	namespace 	

DataAccess
 
. 

Interfaces 
{ 
public 

	interface 
IBuscadorRepository (
{ 
BuscadorDto 
PsBuscarPalabra #
(# $
string$ *
	paramJSON+ 4
,4 5
int6 9

PageNumber: D
,D E
intF I
RowsPerPageJ U
)U V
;V W
List 
< 

EsquemaDto 
> %
FnHomologacionEsquemaTodo 2
(2 3
string3 9
VistaFK: A
,A B
intC F
idOnaG L
)L M
;M N
FnEsquemaDto&& 
?&& !
FnHomologacionEsquema&& +
(&&+ ,
int&&, /!
idHomologacionEsquema&&0 E
)&&E F
;&&F G
List22 
<22 (
FnHomologacionEsquemaDataDto22 )
>22) *%
FnHomologacionEsquemaDato22+ D
(22D E
int22E H
	idEsquema22I R
,22R S
string22T Z
VistaFK22[ b
,22b c
int22d g
idOna22h m
)22m n
;22n o
List== 
<== #
FnEsquemaDataBuscadoDto== $
>==$ %
FnEsquemaDatoBuscar==& 9
(==9 :
int==: =
IdEsquemaData==> K
,==K L
string==M S
TextoBuscar==T _
)==_ `
;==` a
ListGG 
<GG 
FnPredictWordsDtoGG 
>GG 
FnPredictWordsGG  .
(GG. /
stringGG/ 5
wordGG6 :
)GG: ;
;GG; <
boolQQ 
ValidateWordsQQ 
(QQ 
ListQQ 
<QQ  
stringQQ  &
>QQ& '
wordsQQ( -
)QQ- .
;QQ. / 
fnEsquemaCabeceraDto\\ 
?\\ 
FnEsquemaCabecera\\ /
(\\/ 0
int\\0 3
IdEsquemadata\\4 A
)\\A B
;\\B C
intcc 
AddEventTrackingcc 
(cc 
EventTrackingDtocc -
eventTrackingcc. ;
)cc; <
;cc< =
}ff 
}gg �

SC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Data\SqlServerDbContextFactory.cs
public 
class %
SqlServerDbContextFactory &
(& '
DbContextOptions' 7
<7 8
SqlServerDbContext8 J
>J K
optionsL S
)S T
:U V&
ISqlServerDbContextFactoryW q
{ 
private 
readonly 
DbContextOptions %
<% &
SqlServerDbContext& 8
>8 9
_options: B
=C D
optionsE L
;L M
public 

SqlServerDbContext 
CreateDbContext -
(- .
). /
{		 
var

 
context

 
=

 
new

 
SqlServerDbContext

 ,
(

, -
_options

- 5
)

5 6
;

6 7
context 
. 
ChangeTracker 
. !
QueryTrackingBehavior 3
=4 5!
QueryTrackingBehavior6 K
.K L

NoTrackingL V
;V W
context 
. 
ChangeTracker 
. 
LazyLoadingEnabled 0
=1 2
false3 8
;8 9
return 
context 
; 
} 
} ��
LC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Data\SqlServerDbContext.cs
	namespace 	

DataAccess
 
. 
Data 
{ 
public 

class 
SqlServerDbContext #
:$ %
	DbContext& /
{ 
public 
SqlServerDbContext !
(! "
DbContextOptions" 2
<2 3
SqlServerDbContext3 E
>E F
optionsG N
)N O
:P Q
baseR V
(V W
optionsW ^
)^ _
{` a
}b c
public 
DbSet 
< 
Esquema 
> 
Esquema %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 
DbSet 
< 
EsquemaData  
>  !
EsquemaData" -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
public 
DbSet 
< 
EsquemaFullText $
>$ %
EsquemaFullText& 5
{6 7
get8 ;
;; <
set= @
;@ A
}B C
public 
DbSet 
< 
EsquemaVista !
>! "
EsquemaVista# /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
public   
DbSet   
<   
EsquemaVistaColumna   (
>  ( )
EsquemaVistaColumna  * =
{  > ?
get  @ C
;  C D
set  E H
;  H I
}  J K
public## 
DbSet## 
<## 
Homologacion## !
>##! "
Homologacion### /
{##0 1
get##2 5
;##5 6
set##7 :
;##: ;
}##< =
public$$ 
DbSet$$ 
<$$ 
MenuRol$$ 
>$$ 
MenuRol$$ %
{$$& '
get$$( +
;$$+ ,
set$$- 0
;$$0 1
}$$2 3
public'' 
DbSet'' 
<'' 
LogMigracion'' !
>''! "
LogMigracion''# /
{''0 1
get''2 5
;''5 6
set''7 :
;'': ;
}''< =
public** 
DbSet** 
<** 
LogMigracionDetalle** (
>**( )
LogMigracionDetalle*** =
{**> ?
get**@ C
;**C D
set**E H
;**H I
}**J K
public-- 
DbSet-- 
<-- 
	LogScript-- 
>-- 
	LogScript--  )
{--* +
get--, /
;--/ 0
set--1 4
;--4 5
}--6 7
public00 
DbSet00 
<00 
MigracionExcel00 #
>00# $
MigracionExcel00% 3
{004 5
get006 9
;009 :
set00; >
;00> ?
}00@ A
public33 
DbSet33 
<33 
ONA33 
>33 
ONA33 
{33 
get33  #
;33# $
set33% (
;33( )
}33* +
public44 
DbSet44 
<44 
Menus44 
>44 
Menus44 !
{44" #
get44$ '
;44' (
set44) ,
;44, -
}44. /
public77 
DbSet77 
<77 
ONAConexion77  
>77  !
ONAConexion77" -
{77. /
get770 3
;773 4
set775 8
;778 9
}77: ;
public:: 
DbSet:: 
<:: 
Usuario:: 
>:: 
Usuario:: %
{::& '
get::( +
;::+ ,
set::- 0
;::0 1
}::2 3
public== 
DbSet== 
<== 
UsuarioEndpoint== $
>==$ %
UsuarioEndpoint==& 5
{==6 7
get==8 ;
;==; <
set=== @
;==@ A
}==B C
public@@ 
DbSet@@ 
<@@ 
VwDimension@@  
>@@  !
VwDimension@@" -
{@@. /
get@@0 3
;@@3 4
set@@5 8
;@@8 9
}@@: ;
publicCC 
DbSetCC 
<CC 
VwFiltroCC 
>CC 
VwFiltroCC '
{CC( )
getCC* -
;CC- .
setCC/ 2
;CC2 3
}CC4 5
publicFF 
DbSetFF 
<FF !
vw_FiltrosAnidadosDtoFF *
>FF* +
VwFiltroAnidadosFF, <
{FF= >
getFF? B
;FFB C
setFFD G
;FFG H
}FFI J
publicII 
DbSetII 
<II 
VwGrillaII 
>II 
VwGrillaII '
{II( )
getII* -
;II- .
setII/ 2
;II2 3
}II4 5
publicLL 
DbSetLL 
<LL 
VwRolLL 
>LL 
VwRolLL !
{LL" #
getLL$ '
;LL' (
setLL) ,
;LL, -
}LL. /
publicOO 
DbSetOO 
<OO 
VwPaisOO 
>OO 
VwPaisOO #
{OO$ %
getOO& )
;OO) *
setOO+ .
;OO. /
}OO0 1
publicRR 
DbSetRR 
<RR 
VwMenuRR 
>RR 
VwMenuRR #
{RR$ %
getRR& )
;RR) *
setRR+ .
;RR. /
}RR0 1
publicUU 
DbSetUU 
<UU 
vwONAUU 
>UU 
vwONAUU !
{UU" #
getUU$ '
;UU' (
setUU) ,
;UU, -
}UU. /
publicXX 
DbSetXX 
<XX 
VwHomologacionGrupoXX (
>XX( )
VwHomologacionGrupoXX* =
{XX> ?
getXX@ C
;XXC D
setXXE H
;XXH I
}XXJ K
publicYY 
DbSetYY 
<YY 
VwHomologacionYY #
>YY# $
VwHomologacionYY% 3
{YY4 5
getYY6 9
;YY9 :
setYY; >
;YY> ?
}YY@ A
public\\ 
DbSet\\ 
<\\ 
VwAcreditacionOna\\ &
>\\& '
VwAcreditacionOna\\( 9
{\\: ;
get\\< ?
;\\? @
set\\A D
;\\D E
}\\F G
public]] 
DbSet]] 
<]] !
VwAcreditacionEsquema]] *
>]]* +!
VwAcreditacionEsquema]], A
{]]B C
get]]D G
;]]G H
set]]I L
;]]L M
}]]N O
public^^ 
DbSet^^ 
<^^ 
VwEstadoEsquema^^ $
>^^$ %
VwEstadoEsquema^^& 5
{^^6 7
get^^8 ;
;^^; <
set^^= @
;^^@ A
}^^B C
public__ 
DbSet__ 
<__ 
	VwOecPais__ 
>__ 
	VwOecPais__  )
{__* +
get__, /
;__/ 0
set__1 4
;__4 5
}__6 7
public`` 
DbSet`` 
<`` 
VwEsquemaPais`` "
>``" #
VwEsquemaPais``$ 1
{``2 3
get``4 7
;``7 8
set``9 <
;``< =
}``> ?
publicaa 
DbSetaa 
<aa 

VwOecFechaaa 
>aa  

VwOecFechaaa! +
{aa, -
getaa. 1
;aa1 2
setaa3 6
;aa6 7
}aa8 9
publicdd 
DbSetdd 
<dd #
VwProfesionalCalificadodd ,
>dd, -#
VwProfesionalCalificadodd. E
{ddF G
getddH K
;ddK L
setddM P
;ddP Q
}ddR S
publicee 
DbSetee 
<ee 
VwProfesionalOnaee %
>ee% &
VwProfesionalOnaee' 7
{ee8 9
getee: =
;ee= >
setee? B
;eeB C
}eeD E
publicff 
DbSetff 
<ff  
VwProfesionalEsquemaff )
>ff) * 
VwProfesionalEsquemaff+ ?
{ff@ A
getffB E
;ffE F
setffG J
;ffJ K
}ffL M
publicgg 
DbSetgg 
<gg 
VwProfesionalFechagg '
>gg' (
VwProfesionalFechagg) ;
{gg< =
getgg> A
;ggA B
setggC F
;ggF G
}ggH I
publichh 
DbSethh 
<hh 
VwCalificaUbicacionhh (
>hh( )
VwCalificaUbicacionhh* =
{hh> ?
gethh@ C
;hhC D
sethhE H
;hhH I
}hhJ K
publickk 
DbSetkk 
<kk 
VwBusquedaFechakk $
>kk$ %
VwBusquedaFechakk& 5
{kk6 7
getkk8 ;
;kk; <
setkk= @
;kk@ A
}kkB C
publicll 
DbSetll 
<ll 
VwBusquedaFiltroll %
>ll% &
VwBusquedaFiltroll' 7
{ll8 9
getll: =
;ll= >
setll? B
;llB C
}llD E
publicmm 
DbSetmm 
<mm 
VwBusquedaUbicacionmm (
>mm( )
VwBusquedaUbicacionmm* =
{mm> ?
getmm@ C
;mmC D
setmmE H
;mmH I
}mmJ K
publicnn 
DbSetnn 
<nn 
VwActualizacionONAnn '
>nn' (
VwActualizacionONAnn) ;
{nn< =
getnn> A
;nnA B
setnnC F
;nnF G
}nnH I
publicqq 
DbSetqq 
<qq !
VwOrganismoRegistradoqq *
>qq* +!
VwOrganismoRegistradoqq, A
{qqB C
getqqD G
;qqG H
setqqI L
;qqL M
}qqN O
publicrr 
DbSetrr 
<rr !
VwOrganizacionEsquemarr *
>rr* +!
VwOrganizacionEsquemarr, A
{rrB C
getrrD G
;rrG H
setrrI L
;rrL M
}rrN O
publicss 
DbSetss 
<ss  
VwOrganismoActividadss )
>ss) * 
VwOrganismoActividadss+ ?
{ss@ A
getssB E
;ssE F
setssG J
;ssJ K
}ssL M
publicuu 
DbSetuu 
<uu 
vwFiltroDetalleuu $
>uu$ %
vwFiltroDetalleuu& 5
{uu6 7
getuu8 ;
;uu; <
setuu= @
;uu@ A
}uuB C
publicww 
DbSetww 
<ww 

vwPanelONAww 
>ww  

vwPanelONAww! +
{ww, -
getww. 1
;ww1 2
setww3 6
;ww6 7
}ww8 9
publicxx 
DbSetxx 
<xx 
vwEsquemaOrganizaxx &
>xx& '
vwEsquemaOrganizaxx( 9
{xx: ;
getxx< ?
;xx? @
setxxA D
;xxD E
}xxF G
publiczz 
DbSetzz 
<zz 
EventTrackingzz "
>zz" #
EventTrackingzz$ 1
{zz2 3
getzz4 7
;zz7 8
setzz9 <
;zz< =
}zz> ?
public|| 
DbSet|| 
<|| 
VwEventUserAll|| #
>||# $
VwEventUserAll||% 3
{||4 5
get||6 9
;||9 :
set||; >
;||> ?
}||@ A
public~~ 
DbSet~~ 
<~~ 
	EventUser~~ 
>~~ 
	EventUser~~  )
{~~* +
get~~, /
;~~/ 0
set~~1 4
;~~4 5
}~~6 7
public
�� 
DbSet
�� 
<
�� #
PaginasMasVisitadaDto
�� *
>
��* +
EventPagMasVisit
��, <
{
��= >
get
��? B
;
��B C
set
��D G
;
��G H
}
��I J
public
�� 
DbSet
�� 
<
��  
FiltrosMasUsadoDto
�� '
>
��' (!
EventFiltroMasUsado
��) <
{
��= >
get
��? B
;
��B C
set
��D G
;
��G H
}
��I J
public
�� 
DbSet
�� 
<
�� '
VwEventTrackingSessionDto
�� .
>
��. /
EventSession
��0 <
{
��= >
get
��? B
;
��B C
set
��D G
;
��G H
}
��I J
public
�� 
DbSet
�� 
<
�� 
OnaMigrateDto
�� "
>
��" #

onaMigrate
��$ .
{
��/ 0
get
��1 4
;
��4 5
set
��6 9
;
��9 :
}
��; <
	protected
�� 
override
�� 
void
�� 
OnModelCreating
��  /
(
��/ 0
ModelBuilder
��0 <
modelBuilder
��= I
)
��I J
{
�� 	
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
VwMenu
��  &
>
��& '
(
��' (
)
��( )
.
��) *
HasNoKey
��* 2
(
��2 3
)
��3 4
.
��4 5
ToView
��5 ;
(
��; <
$str
��< D
)
��D E
;
��E F
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
VwAcreditacionOna
��  1
>
��1 2
(
��2 3
)
��3 4
.
��4 5
HasNoKey
��5 =
(
��= >
)
��> ?
.
��? @
ToView
��@ F
(
��F G
$str
��G [
)
��[ \
;
��\ ]
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  #
VwAcreditacionEsquema
��  5
>
��5 6
(
��6 7
)
��7 8
.
��8 9
HasNoKey
��9 A
(
��A B
)
��B C
.
��C D
ToView
��D J
(
��J K
$str
��K c
)
��c d
;
��d e
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
VwEstadoEsquema
��  /
>
��/ 0
(
��0 1
)
��1 2
.
��2 3
HasNoKey
��3 ;
(
��; <
)
��< =
.
��= >
ToView
��> D
(
��D E
$str
��E W
)
��W X
;
��X Y
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
	VwOecPais
��  )
>
��) *
(
��* +
)
��+ ,
.
��, -
HasNoKey
��- 5
(
��5 6
)
��6 7
.
��7 8
ToView
��8 >
(
��> ?
$str
��? K
)
��K L
;
��L M
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
VwEsquemaPais
��  -
>
��- .
(
��. /
)
��/ 0
.
��0 1
HasNoKey
��1 9
(
��9 :
)
��: ;
.
��; <
ToView
��< B
(
��B C
$str
��C S
)
��S T
;
��T U
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  

VwOecFecha
��  *
>
��* +
(
��+ ,
)
��, -
.
��- .
HasNoKey
��. 6
(
��6 7
)
��7 8
.
��8 9
ToView
��9 ?
(
��? @
$str
��@ M
)
��M N
;
��N O
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  

vwPanelONA
��  *
>
��* +
(
��+ ,
)
��, -
.
��- .
HasNoKey
��. 6
(
��6 7
)
��7 8
.
��8 9
ToView
��9 ?
(
��? @
$str
��@ L
)
��L M
;
��M N
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
vwEsquemaOrganiza
��  1
>
��1 2
(
��2 3
)
��3 4
.
��4 5
HasNoKey
��5 =
(
��= >
)
��> ?
.
��? @
ToView
��@ F
(
��F G
$str
��G Z
)
��Z [
;
��[ \
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  %
VwProfesionalCalificado
��  7
>
��7 8
(
��8 9
)
��9 :
.
��: ;
HasNoKey
��; C
(
��C D
)
��D E
.
��E F
ToView
��F L
(
��L M
$str
��M g
)
��g h
;
��h i
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
VwProfesionalOna
��  0
>
��0 1
(
��1 2
)
��2 3
.
��3 4
HasNoKey
��4 <
(
��< =
)
��= >
.
��> ?
ToView
��? E
(
��E F
$str
��F Y
)
��Y Z
;
��Z [
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  "
VwProfesionalEsquema
��  4
>
��4 5
(
��5 6
)
��6 7
.
��7 8
HasNoKey
��8 @
(
��@ A
)
��A B
.
��B C
ToView
��C I
(
��I J
$str
��J a
)
��a b
;
��b c
modelBuilder
�� 
.
�� 
Entity
�� 
<
��   
VwProfesionalFecha
��  2
>
��2 3
(
��3 4
)
��4 5
.
��5 6
HasNoKey
��6 >
(
��> ?
)
��? @
.
��@ A
ToView
��A G
(
��G H
$str
��H ]
)
��] ^
;
��^ _
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  !
VwCalificaUbicacion
��  3
>
��3 4
(
��4 5
)
��5 6
.
��6 7
HasNoKey
��7 ?
(
��? @
)
��@ A
.
��A B
ToView
��B H
(
��H I
$str
��I _
)
��_ `
;
��` a
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
VwBusquedaFecha
��  /
>
��/ 0
(
��0 1
)
��1 2
.
��2 3
HasNoKey
��3 ;
(
��; <
)
��< =
.
��= >
ToView
��> D
(
��D E
$str
��E W
)
��W X
;
��X Y
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
VwBusquedaFiltro
��  0
>
��0 1
(
��1 2
)
��2 3
.
��3 4
HasNoKey
��4 <
(
��< =
)
��= >
.
��> ?
ToView
��? E
(
��E F
$str
��F Y
)
��Y Z
;
��Z [
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  !
VwBusquedaUbicacion
��  3
>
��3 4
(
��4 5
)
��5 6
.
��6 7
HasNoKey
��7 ?
(
��? @
)
��@ A
.
��A B
ToView
��B H
(
��H I
$str
��I _
)
��_ `
;
��` a
modelBuilder
�� 
.
�� 
Entity
�� 
<
��   
VwActualizacionONA
��  2
>
��2 3
(
��3 4
)
��4 5
.
��5 6
HasNoKey
��6 >
(
��> ?
)
��? @
.
��@ A
ToView
��A G
(
��G H
$str
��H ]
)
��] ^
;
��^ _
modelBuilder
�� 
.
�� 
Entity
�� 
<
��   
vw_FiltrosAnidados
��  2
>
��2 3
(
��3 4
)
��4 5
.
��5 6
HasNoKey
��6 >
(
��> ?
)
��? @
.
��@ A
ToView
��A G
(
��G H
$str
��H \
)
��\ ]
;
��] ^
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  #
VwOrganismoRegistrado
��  5
>
��5 6
(
��6 7
)
��7 8
.
��8 9
HasNoKey
��9 A
(
��A B
)
��B C
.
��C D
ToView
��D J
(
��J K
$str
��K c
)
��c d
;
��d e
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  #
VwOrganizacionEsquema
��  5
>
��5 6
(
��6 7
)
��7 8
.
��8 9
HasNoKey
��9 A
(
��A B
)
��B C
.
��C D
ToView
��D J
(
��J K
$str
��K c
)
��c d
;
��d e
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  "
VwOrganismoActividad
��  4
>
��4 5
(
��5 6
)
��6 7
.
��7 8
HasNoKey
��8 @
(
��@ A
)
��A B
.
��B C
ToView
��C I
(
��I J
$str
��J a
)
��a b
;
��b c
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
vwONA
��  %
>
��% &
(
��& '
)
��' (
.
��( )
HasNoKey
��) 1
(
��1 2
)
��2 3
.
��3 4
ToView
��4 :
(
��: ;
$str
��; B
)
��B C
;
��C D
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
VwEventUserAll
��  .
>
��. /
(
��/ 0
)
��0 1
.
��1 2
HasNoKey
��2 :
(
��: ;
)
��; <
.
��< =
ToView
��= C
(
��C D
$str
��D U
)
��U V
;
��V W
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
	EventUser
��  )
>
��) *
(
��* +
)
��+ ,
.
��, -
HasNoKey
��- 5
(
��5 6
)
��6 7
.
��7 8
ToView
��8 >
(
��> ?
$str
��? P
)
��P Q
;
��Q R
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
	EventUser
��  )
>
��) *
(
��* +
)
��+ ,
.
��, -
HasNoKey
��- 5
(
��5 6
)
��6 7
.
��7 8
ToView
��8 >
(
��> ?
$str
��? P
)
��P Q
;
��Q R
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
	EventUser
��  )
>
��) *
(
��* +
)
��+ ,
.
��, -
HasNoKey
��- 5
(
��5 6
)
��6 7
.
��7 8
ToView
��8 >
(
��> ?
$str
��? Q
)
��Q R
;
��R S
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
	EventUser
��  )
>
��) *
(
��* +
)
��+ ,
.
��, -
HasNoKey
��- 5
(
��5 6
)
��6 7
.
��7 8
ToView
��8 >
(
��> ?
$str
��? S
)
��S T
;
��T U
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  '
VwEventTrackingSessionDto
��  9
>
��9 :
(
��: ;
)
��; <
.
��< =
HasNoKey
��= E
(
��E F
)
��F G
.
��G H
ToView
��H N
(
��N O
$str
��O h
)
��h i
;
��i j
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  #
PaginasMasVisitadaDto
��  5
>
��5 6
(
��6 7
)
��7 8
.
��8 9
HasNoKey
��9 A
(
��A B
)
��B C
.
��C D

ToSqlQuery
��D N
(
��N O
$str
��O k
)
��k l
;
��l m
modelBuilder
�� 
.
�� 
Entity
�� 
<
��   
FiltrosMasUsadoDto
��  2
>
��2 3
(
��3 4
)
��4 5
.
��5 6
HasNoKey
��6 >
(
��> ?
)
��? @
.
��@ A

ToSqlQuery
��A K
(
��K L
$str
��L d
)
��d e
;
��e f
modelBuilder
�� 
.
�� 
Entity
�� 
<
��  
OnaMigrateDto
��  -
>
��- .
(
��. /
)
��/ 0
.
��0 1
HasNoKey
��1 9
(
��9 :
)
��: ;
.
��; <

ToSqlQuery
��< F
(
��F G
$str
��G [
)
��[ \
;
��\ ]
}
�� 	
}
�� 
}�� �
JC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Data\DynamicDbContext.cs
	namespace 	

DataAccess
 
. 
Data 
{ 
public 

class 
DynamicDbContext !
:" #
	DbContext$ -
{ 
public 
DynamicDbContext 
(  
DbContextOptions  0
<0 1
	DbContext1 :
>: ;
options< C
)C D
:E F
baseG K
(K L
optionsL S
)S T
{U V
}W X
} 
}		 �
JC:\Users\Dell\source\repos\BuscadorCan\DataAccess\Data\DbContextFactory.cs
	namespace 	

DataAccess
 
. 
Data 
{ 
public 

class 
DbContextFactory !
:" #
IDbContextFactory$ 5
{ 
public		 
	DbContext		 
CreateDbContext		 (
(		( )
string		) /
connectionString		0 @
,		@ A
DatabaseType		B N
databaseType		O [
)		[ \
{

 	
var 
optionsBuilder 
=  
new! $#
DbContextOptionsBuilder% <
<< =
	DbContext= F
>F G
(G H
)H I
;I J
switch 
( 
databaseType  
)  !
{ 
case 
DatabaseType !
.! "
	SQLSERVER" +
:+ ,
optionsBuilder "
." #
UseSqlServer# /
(/ 0
connectionString0 @
)@ A
;A B
break 
; 
case 
DatabaseType !
.! "
MYSQL" '
:' (
optionsBuilder "
." #
UseMySQL# +
(+ ,
connectionString, <
)< =
;= >
break 
; 
default 
: 
throw 
new '
ArgumentOutOfRangeException 9
(9 :
nameof: @
(@ A
databaseTypeA M
)M N
,N O
databaseTypeP \
,\ ]
null^ b
)b c
;c d
} 
return 
new 
DynamicDbContext '
(' (
optionsBuilder( 6
.6 7
Options7 >
)> ?
;? @
} 	
} 
} 