∏
IC:\Users\Dell\source\repos\BuscadorCan\Core\WorkerService\MigracionJob.cs
	namespace 	
WebApp
 
. 
WorkerService 
{ 
} Ì+
TC:\Users\Dell\source\repos\BuscadorCan\Core\WorkerService\BackgroundWorkerService.cs
	namespace 	
WebApp
 
. 
WorkerService 
{ 
public 

class #
BackgroundWorkerService (
:) *
BackgroundService+ <
{ 
private		 
enum		 
Country		 
{

 	
Ninguno 
= 
$num 
, 
Colombia !
=" #
$num$ %
,% &
Ecuador' .
=/ 0
$num1 2
,2 3
Peru4 8
=9 :
$num; <
,< =
Bolivia> E
=F G
$numH I
} 	
private 
int 
countProceso  
=! "
$num# $
;$ %
private 
readonly 
int 
_startGetDataHora .
=/ 0
$num1 3
;3 4
private 
readonly 
int 
_startGetDataMin -
=. /
$num0 1
;1 2
private 
readonly 
int 
_delayProcessMin -
=. /
$num0 1
;1 2
private 
Country 
pais 
= 
Country &
.& '
Ninguno' .
;. /
private 
readonly 
string 
?  
_configLogPath! /
;/ 0
private 
readonly 
IConfiguration '
?' (
_config) 0
;0 1
readonly 
ILogger 
< #
BackgroundWorkerService 0
>0 1
_logger2 9
;9 :
public #
BackgroundWorkerService &
(& '
ILogger' .
<. /#
BackgroundWorkerService/ F
>F G
loggerH N
,N O
IConfigurationP ^
config_ e
)e f
{ 	
_logger 
= 
logger 
; 
_logger 
. 
LogInformation "
(" #
$"# %
$str% N
{N O
DateTimeO W
.W X
NowX [
}[ \
"\ ]
)] ^
;^ _
_config 
= 
config 
; 
_configLogPath 
= 
_config $
?$ %
.% &
GetConnectionString& 9
(9 :
$str: C
)C D
==E G
nullH L
?M N
$strO Q
:R S
_configT [
?[ \
.\ ]
GetConnectionString] p
(p q
$strq z
)z {
;{ |
} 	
	protected 
async 
override  
Task! %
ExecuteAsync& 2
(2 3
CancellationToken3 D
stoppingTokenE R
)R S
{ 	
}	 

private%% 
void%% 
msgNextWorker%% "
(%%" #
TimeSpan%%# +
delay%%, 1
)%%1 2
{&& 	
string'' 
nextTime'' 
='' 
DateTime'' &
.''& '
Now''' *
.''* +
Add''+ .
(''. /
delay''/ 4
)''4 5
.''5 6
ToString''6 >
(''> ?
$str''? [
)''[ \
;''\ ]
_logger(( 
.(( 
LogInformation(( "
(((" #
$"((# %
$str((% ,
{((, -
pais((- 1
.((1 2
ToString((2 :
(((: ;
)((; <
.((< =
ToUpper((= D
(((D E
)((E F
}((F G
$str((G \
{((\ ]
nextTime((] e
}((e f
"((f g
)((g h
;((h i
})) 	
private00 
async00 
Task00 
<00 
TimeSpan00 #
>00# $!
GetDataProcessCountry00% :
(00: ;
)00; <
{11 	
var22 
	contenido22 
=22 
$"22 
$str22 "
{22" #
pais22# '
}22' (
$str22( C
{22C D
DateTime22D L
.22L M
Now22M P
:22P Q
$str22Q Y
}22Y Z
$str22Z \
"22\ ]
;22] ^
_logger33 
.33 
LogInformation33 "
(33" #
$"33# %
$str33% *
{33* +
	contenido33+ 4
}334 5
"335 6
)336 7
;337 8
countProceso44 
++44 
;44 
await55 
File55 
.55 
WriteAllTextAsync55 (
(55( )
$"55) +
{55+ ,
_configLogPath55, :
}55: ;
{55; <
countProceso55< H
}55H I
$str55I W
{55W X
pais55X \
}55\ ]
$str55] d
"55d e
,55e f
$str55g i
)55i j
;55j k
await66 
Task66 
.66 
Delay66 
(66 
$num66 !
*66" #
countProceso66$ 0
)660 1
;661 2
return88 
DateTime88 
.88 
Now88 
.88  

AddMinutes88  *
(88* +
_delayProcessMin88+ ;
)88; <
-88= >
DateTime88? G
.88G H
Now88H K
;88K L
}99 	
};; 
}<< ¬
SC:\Users\Dell\source\repos\BuscadorCan\Core\WorkerService\BackgroundExcelService.cs
	namespace 	
WebApp
 
. 
WorkerService 
{ 
} µ8
EC:\Users\Dell\source\repos\BuscadorCan\Core\Service\UsuarioService.cs
	namespace		 	
Core		
 
.		 
Service		 
{

 
public 

class 
UsuarioService 
:  !
IUsuarioService" 1
{ 
private 
readonly 
IUsuarioRepository +
_usuarioRepository, >
;> ?
private 
readonly 
IHashService %
_hashService& 2
;2 3
private 
readonly 
IJwtService $
_jwtService% 0
;0 1
private 
readonly 
IMapper  
mapper! '
;' (
public 
UsuarioService 
( 
IUsuarioRepository 0
usuarioRepository1 B
,B C
IHashService *
hashService+ 6
,6 7
IJwtService )

jwtService* 4
,4 5
IMapper %
mapper& ,
), -
{ 	
this 
. 
_usuarioRepository #
=$ %
usuarioRepository& 7
;7 8
this 
. 
_hashService 
= 
hashService  +
;+ ,
this 
. 
_jwtService 
= 

jwtService )
;) *
this 
. 
mapper 
= 
mapper  
;  !
} 	
public 
Result 
< 
bool 
> 
ChangePasswd (
(( )
string) /
clave0 5
,5 6
string7 =

claveNueva> H
)H I
{ 	
var 
actual 
= 
_hashService %
.% &
GenerateHash& 2
(2 3
clave3 8
)8 9
;9 :
var   
nueva   
=   
_hashService   $
.  $ %
GenerateHash  % 1
(  1 2

claveNueva  2 <
)  < =
;  = >
var!! 
	idUsuario!! 
=!! 
_jwtService!! '
.!!' (
GetUserIdFromToken!!( :
(!!: ;
_jwtService!!; F
.!!F G
GetTokenFromHeader!!G Y
(!!Y Z
)!!Z [
??!!\ ^
$str!!_ b
)!!b c
;!!c d
return## 
_usuarioRepository## %
.##% &
ChangePasswd##& 2
(##2 3
clave##3 8
,##8 9

claveNueva##: D
,##D E
	idUsuario##F O
,##O P
nueva##Q V
)##V W
;##W X
}$$ 	
public&& 
bool&& 
Create&& 
(&& 

UsuarioDto&& %
usuario&&& -
)&&- .
{'' 	
Usuario(( 
entity(( 
=(( 
mapper(( #
.((# $
Map(($ '
<((' (
Usuario((( /
>((/ 0
(((0 1
usuario((1 8
)((8 9
;((9 :
var)) 
clave)) 
=)) 
usuario)) 
.))  
Clave))  %
;))% &
entity** 
.** 
Clave** 
=** 
_hashService** '
.**' (
GenerateHash**( 4
(**4 5
clave**5 :
)**: ;
;**; <
entity++ 
.++ 
IdUserCreacion++ !
=++" #
_jwtService++$ /
.++/ 0
GetUserIdFromToken++0 B
(++B C
_jwtService++C N
.++N O
GetTokenFromHeader++O a
(++a b
)++b c
??++d f
$str++g i
)++i j
;++j k
entity,, 
.,, 
IdUserModifica,, !
=,," #
entity,,$ *
.,,* +
IdUserCreacion,,+ 9
;,,9 :
entity-- 
.-- 
Estado-- 
=-- 

Constantes-- &
.--& '
ESTADO_USUARIO_A--' 7
;--7 8
return// 
_usuarioRepository// %
.//% &
Create//& ,
(//, -
entity//- 3
)//3 4
;//4 5
}00 	
public22 
List22 
<22 

UsuarioDto22 
>22 
FindAll22  '
(22' (
)22( )
{33 	
return44 
_usuarioRepository44 %
.44% &
FindAll44& -
(44- .
)44. /
.44/ 0
ToList440 6
(446 7
)447 8
;448 9
}55 	
public77 
Usuario77 
?77 
FindByEmail77 #
(77# $
string77$ *
email77+ 0
)770 1
{88 	
return99 
_usuarioRepository99 %
.99% &
FindByEmail99& 1
(991 2
email992 7
)997 8
;998 9
}:: 	
public<< 

UsuarioDto<< 
?<< 
FindById<< #
(<<# $
int<<$ '
	idUsuario<<( 1
)<<1 2
{== 	
Usuario>> 
?>> 
usuario>> 
=>> 
_usuarioRepository>> 1
.>>1 2
FindById>>2 :
(>>: ;
	idUsuario>>; D
)>>D E
;>>E F
return?? 
mapper?? 
.?? 
Map?? 
<?? 

UsuarioDto?? (
>??( )
(??) *
usuario??* 1
)??1 2
;??2 3
}@@ 	
publicBB 
boolBB 
IsUniqueUserBB  
(BB  !
stringBB! '
usuarioBB( /
)BB/ 0
{CC 	
returnDD 
_usuarioRepositoryDD %
.DD% &
IsUniqueUserDD& 2
(DD2 3
usuarioDD3 :
)DD: ;
;DD; <
}EE 	
publicGG 
boolGG 
UpdateGG 
(GG 

UsuarioDtoGG %
usuarioGG& -
)GG- .
{HH 	
UsuarioII 
entityII 
=II 
mapperII #
.II# $
MapII$ '
<II' (
UsuarioII( /
>II/ 0
(II0 1
usuarioII1 8
)II8 9
;II9 :
returnJJ 
_usuarioRepositoryJJ %
.JJ% &
UpdateJJ& ,
(JJ, -
entityJJ- 3
)JJ3 4
;JJ4 5
}KK 	
publicMM 
boolMM 

DeactivateMM 
(MM 
intMM "
	idUsuarioMM# ,
)MM, -
{NN 	
varOO 
usuarioOO 
=OO 
FindByIdOO "
(OO" #
	idUsuarioOO# ,
)OO, -
;OO- .
ifQQ 
(QQ 
usuarioQQ 
==QQ 
nullQQ 
)QQ  
{RR 
returnSS 
falseSS 
;SS 
}TT 
usuarioVV 
.VV 
EstadoVV 
=VV 

ConstantesVV '
.VV' (
ESTADO_USUARIO_XVV( 8
;VV8 9
UpdateWW 
(WW 
usuarioWW 
)WW 
;WW 
returnXX 
trueXX 
;XX 
}YY 	
}ZZ 
}[[ ®
LC:\Users\Dell\source\repos\BuscadorCan\Core\Service\UsuarioEndpontService.cs
	namespace 	
Core
 
. 
Service 
{ 
public 

class !
UsuarioEndpontService &
:' ("
IUsuarioEndpontService) ?
{		 
private

 
readonly

 &
IUsuarioEndpointRepository

 3&
_usuarioEndpointRepository

4 N
;

N O
private 
readonly 
IJwtService $
_jwtService% 0
;0 1
public !
UsuarioEndpontService $
($ %&
IUsuarioEndpointRepository% ?%
usuarioEndpointRepository@ Y
,Y Z
IJwtService[ f

jwtServiceg q
)q r
{ 	
this 
. &
_usuarioEndpointRepository +
=, -%
usuarioEndpointRepository. G
;G H
this 
. 
_jwtService 
= 

jwtService )
;) *
} 	
public 
bool 
Create 
( 
UsuarioEndpoint *
usuarioEndpoint+ :
): ;
{ 	
usuarioEndpoint 
. 
IdUserCreacion *
=+ ,
_jwtService- 8
.8 9
GetUserIdFromToken9 K
(K L
_jwtServiceL W
.W X
GetTokenFromHeaderX j
(j k
)k l
??m o
$strp r
)r s
;s t
return &
_usuarioEndpointRepository -
.- .
Create. 4
(4 5
usuarioEndpoint5 D
)D E
;E F
} 	
public 
ICollection 
< 
UsuarioEndpoint *
>* +
FindAll, 3
(3 4
)4 5
{ 	
return &
_usuarioEndpointRepository ,
., -
FindAll- 4
(4 5
)5 6
;6 7
} 	
public 
UsuarioEndpoint 
? 
FindByEndpointId  0
(0 1
int1 4

endpointId5 ?
)? @
{ 	
return   &
_usuarioEndpointRepository   -
.  - .
FindByEndpointId  . >
(  > ?

endpointId  ? I
)  I J
;  J K
}!! 	
}"" 
}## Ω3
GC:\Users\Dell\source\repos\BuscadorCan\Core\Service\ThesaurusService.cs
	namespace 	
Core
 
. 
Service 
{ 
public		 

class		 
ThesaurusService		 !
:		" #
IThesaurusService		$ 5
{

 
private 
readonly  
IThesaurusRepository - 
_thesaurusRepository. B
;B C
private 
readonly 
IMapper  
mapper! '
;' (
public 
ThesaurusService 
(   
IThesaurusRepository  4
thesaurusRepository5 H
,H I
IMapperJ Q
mapperR X
)X Y
{ 	
this 
.  
_thesaurusRepository %
=& '
thesaurusRepository( ;
;; <
this 
. 
mapper 
= 
mapper  
;  !
} 	
public 
ThesaurusDto 
ObtenerThesaurus ,
(, -
)- .
{ 	
	Thesaurus 
	thesaurus 
=  ! 
_thesaurusRepository" 6
.6 7
ObtenerThesaurus7 G
(G H
)H I
;I J
return 
mapper 
. 
Map 
< 
ThesaurusDto *
>* +
(+ ,
	thesaurus, 5
)5 6
;6 7
} 	
public   
string   
AgregarExpansion   &
(  & '
List  ' +
<  + ,
string  , 2
>  2 3
	sinonimos  4 =
)  = >
{!! 	
try"" 
{## 
var$$ 
	thesaurus$$ 
=$$  
_thesaurusRepository$$  4
.$$4 5
ObtenerThesaurus$$5 E
($$E F
)$$F G
;$$G H
	thesaurus%% 
.%% 

Expansions%% $
.%%$ %
Add%%% (
(%%( )
new%%) ,
	Expansion%%- 6
{%%7 8
Substitutes%%9 D
=%%E F
	sinonimos%%G P
}%%Q R
)%%R S
;%%S T 
_thesaurusRepository&& $
.&&$ %
GuardarThesaurus&&% 5
(&&5 6
	thesaurus&&6 ?
)&&? @
;&&@ A
return'' 
$str'' 
;'' 
})) 
catch** 
{++ 
throw,, 
;,, 
}-- 
}// 	
public44 
string44  
AgregarSubAExpansion44 *
(44* +
string44+ 1
expansionExistente442 D
,44D E
string44F L
nuevoSub44M U
)44U V
{55 	
try66 
{77 
var88 
	thesaurus88 
=88  
_thesaurusRepository88  4
.884 5
ObtenerThesaurus885 E
(88E F
)88F G
;88G H
var:: 
	expansion:: 
=:: 
	thesaurus::  )
.::) *

Expansions::* 4
.::4 5
FirstOrDefault::5 C
(::C D
e::D E
=>::F H
e::I J
.::J K
Substitutes::K V
.::V W
Contains::W _
(::_ `
expansionExistente::` r
)::r s
)::s t
;::t u
if;; 
(;; 
	expansion;; 
!=;;  
null;;! %
);;% &
{<< 
	expansion== 
.== 
Substitutes== )
.==) *
Add==* -
(==- .
nuevoSub==. 6
)==6 7
;==7 8 
_thesaurusRepository>> (
.>>( )
GuardarThesaurus>>) 9
(>>9 :
	thesaurus>>: C
)>>C D
;>>D E
return?? 
$str?? 
;??  
}@@ 
returnBB 
$strBB B
;BBB C
}CC 
catchDD 
(DD 
	ExceptionDD 
exDD 
)DD  
{EE 
throwFF 
newFF 
	ExceptionFF #
(FF# $
$"FF$ &
$strFF& K
{FFK L
exFFL N
.FFN O
MessageFFO V
}FFV W
"FFW X
)FFX Y
;FFY Z
}GG 
}HH 	
publicMM 
stringMM 
ActualizarExpansionMM )
(MM) *
ListMM* .
<MM. /
ExpansionDtoMM/ ;
>MM; <

expansionsMM= G
)MMG H
{NN 	
tryOO 
{PP 
varQQ 
	thesaurusQQ 
=QQ  
_thesaurusRepositoryQQ  4
.QQ4 5
ObtenerThesaurusQQ5 E
(QQE F
)QQF G
;QQG H
	thesaurusRR 
.RR 

ExpansionsRR $
.RR$ %
ClearRR% *
(RR* +
)RR+ ,
;RR, -
foreachSS 
(SS 
varSS 
	expansionSS &
inSS' )

expansionsSS* 4
)SS4 5
{TT 
	thesaurusUU 
.UU 

ExpansionsUU (
.UU( )
AddUU) ,
(UU, -
newUU- 0
	ExpansionUU1 :
{UU; <
SubstitutesUU= H
=UUI J
	expansionUUK T
.UUT U
SubstitutesUUU `
}UUa b
)UUb c
;UUc d
}VV  
_thesaurusRepositoryXX $
.XX$ %
GuardarThesaurusXX% 5
(XX5 6
	thesaurusXX6 ?
)XX? @
;XX@ A
returnYY 
$strYY 
;YY 
}[[ 
catch\\ 
{]] 
throw^^ 
;^^ 
}__ 
}aa 	
publicff 
stringff 
EjecutarArchivoBatff (
(ff( )
)ff) *
{gg 	
tryhh 
{ii  
_thesaurusRepositoryjj $
.jj$ %
EjecutarArchivoBatjj% 7
(jj7 8
)jj8 9
;jj9 :
returnkk 
$strkk 
;kk 
}mm 
catchnn 
{oo 
throwpp 
;pp 
}qq 
}ss 	
publicxx 
stringxx 
ResetSQLServerxx $
(xx$ %
)xx% &
{yy 	
tryzz 
{{{ 
var|| 
mensaje|| 
=||  
_thesaurusRepository|| 2
.||2 3
ResetSQLServer||3 A
(||A B
)||B C
;||C D
return}} 
mensaje}} 
;}} 
} 
catch
ÄÄ 
{
ÅÅ 
throw
ÇÇ 
;
ÇÇ 
}
ÉÉ 
}
ÖÖ 	
}
áá 
}àà Úq
EC:\Users\Dell\source\repos\BuscadorCan\Core\Service\ReporteService.cs
	namespace 	
Core
 
. 
Service 
{ 
public		 

class		 
ReporteService		 
:		  !
IReporteService		" 1
{

 
private 
readonly 
IReporteRepository +
reporteRepository, =
;= >
private 
readonly 
IMapper  
mapper! '
;' (
public 
ReporteService 
( 
IReporteRepository 0
reporteRepository1 B
,B C
IMapperD K
mapperL R
)R S
{ 	
this 
. 
reporteRepository "
=# $
reporteRepository% 6
;6 7
this 
. 
mapper 
= 
mapper  
;  !
} 	
public 
VwHomologacionDto  
findByVista! ,
(, -
string- 3
codigoHomologacion4 F
)F G
{ 	
VwHomologacion 
vwHomologacion )
=* +
reporteRepository, =
.= >
findByVista> I
(I J
codigoHomologacionJ \
)\ ]
;] ^
return 
mapper 
. 
Map 
< 
VwHomologacionDto /
>/ 0
(0 1
vwHomologacion1 ?
)? @
;@ A
} 	
public 
List 
< $
VwAcreditacionEsquemaDto ,
>, -(
ObtenerVwAcreditacionEsquema. J
(J K
)K L
{ 	
List 
< !
VwAcreditacionEsquema &
>& '"
vwAcreditacionEsquemas( >
=? @
reporteRepositoryA R
.R S(
ObtenerVwAcreditacionEsquemaS o
(o p
)p q
;q r
return 
mapper 
. 
Map 
< 
List "
<" #$
VwAcreditacionEsquemaDto# ;
>; <
>< =
(= >"
vwAcreditacionEsquemas> T
)T U
;U V
} 	
public 
List 
<  
VwAcreditacionOnaDto (
>( )$
ObtenerVwAcreditacionOna* B
(B C
)C D
{ 	
List   
<   
VwAcreditacionOna   "
>  " #
vwAcreditacionOnas  $ 6
=  7 8
reporteRepository  9 J
.  J K$
ObtenerVwAcreditacionOna  K c
(  c d
)  d e
;  e f
return!! 
mapper!! 
.!! 
Map!! 
<!! 
List!! "
<!!" # 
VwAcreditacionOnaDto!!# 7
>!!7 8
>!!8 9
(!!9 :
vwAcreditacionOnas!!: L
)!!L M
;!!M N
}"" 	
public$$ 
List$$ 
<$$ !
VwActualizacionONADto$$ )
>$$) *%
ObtenerVwActualizacionONA$$+ D
($$D E
)$$E F
{%% 	
List&& 
<&& 
VwActualizacionONA&& #
>&&# $
vwActualizacionONAs&&% 8
=&&9 :
reporteRepository&&; L
.&&L M%
ObtenerVwActualizacionONA&&M f
(&&f g
)&&g h
;&&h i
return'' 
mapper'' 
.'' 
Map'' 
<'' 
List'' "
<''" #!
VwActualizacionONADto''# 8
>''8 9
>''9 :
('': ;
vwActualizacionONAs''; N
)''N O
;''O P
}(( 	
public** 
List** 
<** 
VwBusquedaFechaDto** &
>**& '"
ObtenerVwBusquedaFecha**( >
(**> ?
)**? @
{++ 	
List,, 
<,, 
VwBusquedaFecha,,  
>,,  !
vwBusquedaFechas,," 2
=,,3 4
reporteRepository,,5 F
.,,F G"
ObtenerVwBusquedaFecha,,G ]
(,,] ^
),,^ _
;,,_ `
return-- 
mapper-- 
.-- 
Map-- 
<-- 
List-- "
<--" #
VwBusquedaFechaDto--# 5
>--5 6
>--6 7
(--7 8
vwBusquedaFechas--8 H
)--H I
;--I J
}.. 	
public00 
List00 
<00 
VwBusquedaFiltroDto00 '
>00' (#
ObtenerVwBusquedaFiltro00) @
(00@ A
)00A B
{11 	
List22 
<22 
VwBusquedaFiltro22 !
>22! "
vwBusquedaFiltros22# 4
=225 6
reporteRepository227 H
.22H I#
ObtenerVwBusquedaFiltro22I `
(22` a
)22a b
;22b c
return33 
mapper33 
.33 
Map33 
<33 
List33 "
<33" #
VwBusquedaFiltroDto33# 6
>336 7
>337 8
(338 9
vwBusquedaFiltros339 J
)33J K
;33K L
}44 	
public66 
List66 
<66 "
VwBusquedaUbicacionDto66 *
>66* +&
ObtenerVwBusquedaUbicacion66, F
(66F G
)66G H
{77 	
List88 
<88 
VwBusquedaUbicacion88 $
>88$ % 
vwBusquedaUbicacions88& :
=88; <
reporteRepository88= N
.88N O&
ObtenerVwBusquedaUbicacion88O i
(88i j
)88j k
;88k l
return99 
mapper99 
.99 
Map99 
<99 
List99 "
<99" #"
VwBusquedaUbicacionDto99# 9
>999 :
>99: ;
(99; < 
vwBusquedaUbicacions99< P
)99P Q
;99Q R
}:: 	
public<< 
List<< 
<<< "
VwCalificaUbicacionDto<< *
><<* +&
ObtenerVwCalificaUbicacion<<, F
(<<F G
)<<G H
{== 	
List>> 
<>> 
VwCalificaUbicacion>> $
>>>$ % 
vwCalificaUbicacions>>& :
=>>; <
reporteRepository>>= N
.>>N O&
ObtenerVwCalificaUbicacion>>O i
(>>i j
)>>j k
;>>k l
return?? 
mapper?? 
.?? 
Map?? 
<?? 
List?? "
<??" #"
VwCalificaUbicacionDto??# 9
>??9 :
>??: ;
(??; < 
vwCalificaUbicacions??< P
)??P Q
;??Q R
}@@ 	
publicBB 
ListBB 
<BB 
VwEsquemaPaisDtoBB $
>BB$ % 
ObtenerVwEsquemaPaisBB& :
(BB: ;
)BB; <
{CC 	
ListDD 
<DD 
VwEsquemaPaisDD 
>DD 
vwEsquemaPaisDD  -
=DD. /
reporteRepositoryDD0 A
.DDA B 
ObtenerVwEsquemaPaisDDB V
(DDV W
)DDW X
;DDX Y
returnEE 
mapperEE 
.EE 
MapEE 
<EE 
ListEE "
<EE" #
VwEsquemaPaisDtoEE# 3
>EE3 4
>EE4 5
(EE5 6
vwEsquemaPaisEE6 C
)EEC D
;EED E
}FF 	
publicHH 
ListHH 
<HH 
VwEstadoEsquemaDtoHH &
>HH& '"
ObtenerVwEstadoEsquemaHH( >
(HH> ?
)HH? @
{II 	
ListJJ 
<JJ 
VwEstadoEsquemaJJ  
>JJ  !
vwEstadoEsquemasJJ" 2
=JJ3 4
reporteRepositoryJJ5 F
.JJF G"
ObtenerVwEstadoEsquemaJJG ]
(JJ] ^
)JJ^ _
;JJ_ `
returnKK 
mapperKK 
.KK 
MapKK 
<KK 
ListKK "
<KK" #
VwEstadoEsquemaDtoKK# 5
>KK5 6
>KK6 7
(KK7 8
vwEstadoEsquemasKK8 H
)KKH I
;KKI J
}LL 	
publicNN 
ListNN 
<NN 
VwOecFechaDtoNN !
>NN! "
ObtenerVwOecFechaNN# 4
(NN4 5
)NN5 6
{OO 	
ListPP 
<PP 

VwOecFechaPP 
>PP 
vwOecFechasPP (
=PP) *
reporteRepositoryPP+ <
.PP< =
ObtenerVwOecFechaPP= N
(PPN O
)PPO P
;PPP Q
returnQQ 
mapperQQ 
.QQ 
MapQQ 
<QQ 
ListQQ "
<QQ" #
VwOecFechaDtoQQ# 0
>QQ0 1
>QQ1 2
(QQ2 3
vwOecFechasQQ3 >
)QQ> ?
;QQ? @
}RR 	
publicTT 
ListTT 
<TT 
VwOecPaisDtoTT  
>TT  !
ObtenerVwOecPaisTT" 2
(TT2 3
)TT3 4
{UU 	
ListVV 
<VV 
	VwOecPaisVV 
>VV 
	vwOecPaisVV $
=VV% &
reporteRepositoryVV' 8
.VV8 9
ObtenerVwOecPaisVV9 I
(VVI J
)VVJ K
;VVK L
returnWW 
mapperWW 
.WW 
MapWW 
<WW 
ListWW "
<WW" #
VwOecPaisDtoWW# /
>WW/ 0
>WW0 1
(WW1 2
	vwOecPaisWW2 ;
)WW; <
;WW< =
}XX 	
publicZZ 
ListZZ 
<ZZ #
VwOrganismoActividadDtoZZ +
>ZZ+ ,'
ObtenerVwOrganismoActividadZZ- H
(ZZH I
)ZZI J
{[[ 	
List\\ 
<\\  
VwOrganismoActividad\\ %
>\\% &!
vwOrganismoActividads\\' <
=\\= >
reporteRepository\\? P
.\\P Q'
ObtenerVwOrganismoActividad\\Q l
(\\l m
)\\m n
;\\n o
return]] 
mapper]] 
.]] 
Map]] 
<]] 
List]] "
<]]" ##
VwOrganismoActividadDto]]# :
>]]: ;
>]]; <
(]]< =!
vwOrganismoActividads]]= R
)]]R S
;]]S T
}^^ 	
public`` 
List`` 
<`` $
VwOrganismoRegistradoDto`` ,
>``, -(
ObtenerVwOrganismoRegistrado``. J
(``J K
)``K L
{aa 	
Listbb 
<bb !
VwOrganismoRegistradobb &
>bb& '"
vwOrganismoRegistradosbb( >
=bb? @
reporteRepositorybbA R
.bbR S(
ObtenerVwOrganismoRegistradobbS o
(bbo p
)bbp q
;bbq r
returncc 
mappercc 
.cc 
Mapcc 
<cc 
Listcc "
<cc" #$
VwOrganismoRegistradoDtocc# ;
>cc; <
>cc< =
(cc= >"
vwOrganismoRegistradoscc> T
)ccT U
;ccU V
}dd 	
publicff 
Listff 
<ff $
VwOrganizacionEsquemaDtoff ,
>ff, -(
ObtenerVwOrganizacionEsquemaff. J
(ffJ K
)ffK L
{gg 	
Listhh 
<hh !
VwOrganizacionEsquemahh &
>hh& '"
vwOrganizacionEsquemashh( >
=hh? @
reporteRepositoryhhA R
.hhR S(
ObtenerVwOrganizacionEsquemahhS o
(hho p
)hhp q
;hhq r
returnii 
mapperii 
.ii 
Mapii 
<ii 
Listii "
<ii" #$
VwOrganizacionEsquemaDtoii# ;
>ii; <
>ii< =
(ii= >"
vwOrganizacionEsquemasii> T
)iiT U
;iiU V
}jj 	
publicll 
Listll 
<ll &
VwProfesionalCalificadoDtoll .
>ll. /*
ObtenerVwProfesionalCalificadoll0 N
(llN O
)llO P
{mm 	
Listnn 
<nn #
VwProfesionalCalificadonn (
>nn( )$
vwProfesionalCalificadosnn* B
=nnC D
reporteRepositorynnE V
.nnV W*
ObtenerVwProfesionalCalificadonnW u
(nnu v
)nnv w
;nnw x
returnoo 
mapperoo 
.oo 
Mapoo 
<oo 
Listoo "
<oo" #&
VwProfesionalCalificadoDtooo# =
>oo= >
>oo> ?
(oo? @$
vwProfesionalCalificadosoo@ X
)ooX Y
;ooY Z
}pp 	
publicrr 
Listrr 
<rr #
VwProfesionalEsquemaDtorr +
>rr+ ,'
ObtenerVwProfesionalEsquemarr- H
(rrH I
)rrI J
{ss 	
Listtt 
<tt  
VwProfesionalEsquematt %
>tt% &!
vwProfesionalEsquemastt( =
=tt> ?
reporteRepositorytt@ Q
.ttQ R'
ObtenerVwProfesionalEsquemattR m
(ttm n
)ttn o
;tto p
returnuu 
mapperuu 
.uu 
Mapuu 
<uu 
Listuu "
<uu" ##
VwProfesionalEsquemaDtouu# :
>uu: ;
>uu; <
(uu< =!
vwProfesionalEsquemasuu= R
)uuR S
;uuS T
}vv 	
publicxx 
Listxx 
<xx !
VwProfesionalFechaDtoxx )
>xx) *%
ObtenerVwProfesionalFechaxx+ D
(xxD E
)xxE F
{yy 	
Listzz 
<zz 
VwProfesionalFechazz #
>zz# $
vwProfesionalFechaszz% 8
=zz9 :
reporteRepositoryzz; L
.zzL M%
ObtenerVwProfesionalFechazzM f
(zzf g
)zzg h
;zzh i
return{{ 
mapper{{ 
.{{ 
Map{{ 
<{{ 
List{{ "
<{{" #!
VwProfesionalFechaDto{{# 8
>{{8 9
>{{9 :
({{: ;
vwProfesionalFechas{{; N
){{N O
;{{O P
}|| 	
public~~ 
List~~ 
<~~ 
VwProfesionalOnaDto~~ '
>~~' (#
ObtenerVwProfesionalOna~~) @
(~~@ A
)~~A B
{ 	
List
ÄÄ 
<
ÄÄ 
VwProfesionalOna
ÄÄ !
>
ÄÄ! "
vwProfesionalOnas
ÄÄ# 4
=
ÄÄ5 6
reporteRepository
ÄÄ7 H
.
ÄÄH I%
ObtenerVwProfesionalOna
ÄÄI `
(
ÄÄ` a
)
ÄÄa b
;
ÄÄb c
return
ÅÅ 
mapper
ÅÅ 
.
ÅÅ 
Map
ÅÅ 
<
ÅÅ 
List
ÅÅ "
<
ÅÅ" #!
VwProfesionalOnaDto
ÅÅ# 6
>
ÅÅ6 7
>
ÅÅ7 8
(
ÅÅ8 9
vwProfesionalOnas
ÅÅ9 J
)
ÅÅJ K
;
ÅÅK L
}
ÇÇ 	
}
ÉÉ 
}ÑÑ áW
IC:\Users\Dell\source\repos\BuscadorCan\Core\Service\RecoverUserService.cs
	namespace

 	
Core


 
.

 
Service

 
{ 
public 

class 
RecoverUserService #
:$ %
IRecoverUserService& 9
{ 
private 
readonly 
IUsuarioRepository +
_usuarioRepository, >
;> ?
private 
readonly $
IEventTrackingRepository 1$
_eventTrackingRepository2 J
;J K
private 
readonly  
ICatalogosRepository - 
_catalogosRepository. B
;B C
private 
readonly )
IRandomStringGeneratorService 6#
_randomGeneratorService7 N
;N O
private 
readonly 
IEmailService &
_emailService' 4
;4 5
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
public 
RecoverUserService !
(! "
IUsuarioRepository 
usuarioRepository 0
,0 1$
IEventTrackingRepository $#
eventTrackingRepository% <
,< = 
ICatalogosRepository  
catalogosRepository! 4
,4 5)
IRandomStringGeneratorService )"
randomGeneratorService* @
,@ A
IEmailService 
emailService &
,& '
IConfiguration 
configuration (
)( )
{ 	
_usuarioRepository   
=    
usuarioRepository  ! 2
;  2 3$
_eventTrackingRepository!! $
=!!% &#
eventTrackingRepository!!' >
;!!> ? 
_catalogosRepository""  
=""! "
catalogosRepository""# 6
;""6 7#
_randomGeneratorService## #
=##$ %"
randomGeneratorService##& <
;##< =
_emailService$$ 
=$$ 
emailService$$ (
;$$( )
_configuration%% 
=%% 
configuration%% *
;%%* +
}&& 	
public)) 
Result)) 
<)) 
bool)) 
>)) 
RecoverPassword)) +
())+ ,"
UsuarioRecuperacionDto)), B"
usuarioRecuperacionDto))C Y
)))Y Z
{** 	
try++ 
{,, 
var-- 
result-- 
=-- 
GetUser-- $
(--$ %"
usuarioRecuperacionDto--% ;
.--; <
Email--< A
)--A B
;--B C
if// 
(// 
!// 
result// 
.// 
	IsSuccess// %
)//% &
{00 !
GenerateEventTracking11 )
(11) *
dto11* -
:11- ."
usuarioRecuperacionDto11/ E
)11E F
;11F G
return22 
Result22 !
<22! "
bool22" &
>22& '
.22' (
Failure22( /
(22/ 0
result220 6
.226 7
ErrorMessage227 C
)22C D
;22D E
}33 
var55 
rol55 
=55  
_catalogosRepository55 .
.55. /
FindVwRolByHId55/ =
(55= >
result55> D
.55D E
Value55E J
.55J K
IdHomologacionRol55K \
)55\ ]
;55] ^!
GenerateEventTracking66 %
(66% &
usuario66& -
:66- .
result66/ 5
.665 6
Value666 ;
,66; <
rol66= @
:66@ A
rol66B E
)66E F
;66F G
string88 
clave88 
=88 #
_randomGeneratorService88 6
.886 7%
GenerateTemporaryPassword887 P
(88P Q
$num88Q R
)88R S
;88S T
result99 
.99 
Value99 
.99 
Clave99 "
=99# $
clave99% *
;99* +
var:: 
isSave:: 
=:: 
_usuarioRepository:: /
.::/ 0
Update::0 6
(::6 7
result::7 =
.::= >
Value::> C
)::C D
;::D E
if<< 
(<< 
isSave<< 
)<< 
{== 
var>> 
htmlBody>>  
=>>! ")
GenerateTemporaryKeyEmailBody>># @
(>>@ A
result>>A G
.>>G H
Value>>H M
,>>M N
clave>>O T
)>>T U
;>>U V
_?? 
=?? 
Task?? 
.?? 
Run??  
(??  !
async??! &
(??' (
)??( )
=>??* ,
{@@ 
tryAA 
{BB 
awaitCC !
_emailServiceCC" /
.CC/ 0
SendEmailAsyncCC0 >
(CC> ?
resultCC? E
.CCE F
ValueCCF K
.CCK L
EmailCCL Q
??CCR T
$strCCU W
,CCW X
$str	CCY Ö
,
CCÖ Ü
htmlBody
CCá è
)
CCè ê
;
CCê ë
}DD 
catchEE 
(EE 
	ExceptionEE (
exEE) +
)EE+ ,
{FF 
ConsoleGG #
.GG# $
	WriteLineGG$ -
(GG- .
$"GG. 0
$strGG0 H
{GGH I
exGGI K
.GGK L
MessageGGL S
}GGS T
"GGT U
)GGU V
;GGV W
}HH 
}II 
)II 
;II 
returnKK 
ResultKK !
<KK! "
boolKK" &
>KK& '
.KK' (
SuccessKK( /
(KK/ 0
trueKK0 4
)KK4 5
;KK5 6
}LL 
returnNN 
ResultNN 
<NN 
boolNN "
>NN" #
.NN# $
FailureNN$ +
(NN+ ,
$strNN, M
)NNM N
;NNN O
}OO 
catchPP 
(PP 
	ExceptionPP 
exPP 
)PP  
{QQ !
GenerateEventTrackingRR %
(RR% &
dtoRR& )
:RR) *"
usuarioRecuperacionDtoRR+ A
)RRA B
;RRB C
throwSS 
exSS 
;SS 
}TT 
}UU 	
private^^ 
Result^^ 
<^^ 
Usuario^^ 
>^^ 
GetUser^^  '
(^^' (
string^^( .
email^^/ 4
)^^4 5
{__ 	
if`` 
(`` 
string`` 
.`` 
IsNullOrEmpty`` $
(``$ %
email``% *
)``* +
)``+ ,
{aa 
returnbb 
Resultbb 
<bb 
Usuariobb %
>bb% &
.bb& '
Failurebb' .
(bb. /
$strbb/ \
)bb\ ]
;bb] ^
}cc 
varee 
usuarioee 
=ee 
_usuarioRepositoryee ,
.ee, -
FindByEmailee- 8
(ee8 9
emailee9 >
)ee> ?
;ee? @
ifgg 
(gg 
usuariogg 
==gg 
nullgg 
)gg  
{hh 
returnii 
Resultii 
<ii 
Usuarioii %
>ii% &
.ii& '
Failureii' .
(ii. /
$strii/ G
)iiG H
;iiH I
}jj 
returnll 
Resultll 
<ll 
Usuarioll !
>ll! "
.ll" #
Successll# *
(ll* +
usuarioll+ 2
)ll2 3
;ll3 4
}mm 	
privatevv 
voidvv !
GenerateEventTrackingvv *
(vv* +"
UsuarioRecuperacionDtovv+ A
?vvA B
dtovvC F
=vvG H
nullvvI M
,vvM N
UsuariovvO V
?vvV W
usuariovvX _
=vv` a
nullvvb f
,vvf g
VwRolvvh m
?vvm n
rolvvo r
=vvs t
nullvvu y
,vvy z
boolvv{ 
success
vvÄ á
=
vvà â
true
vvä é
)
vvé è
{ww 	
varxx 
eventTrackingDtoxx  
=xx! "
newxx# &!
paAddEventTrackingDtoxx' <
{yy !
CodigoHomologacionRolzz %
=zz& '
rolzz( +
?zz+ ,
.zz, -
CodigoHomologacionzz- ?
??zz@ B
$strzzC E
,zzE F
NombreUsuario{{ 
={{ 
usuario{{  '
?{{' (
.{{( )
Nombre{{) /
??{{0 2
dto{{3 6
?{{6 7
.{{7 8
Email{{8 =
,{{= >"
CodigoHomologacionMenu|| &
=||' (
$str||) :
,||: ;
NombreControl}} 
=}} 
$str}}  ,
,}}, -
NombreAccion~~ 
=~~ 
$str~~ ,
,~~, -
ParametroJson 
= 
JsonConvert  +
.+ ,
SerializeObject, ;
(; <
usuario< C
==D F
nullG K
?L M
dtoN Q
:R S
newT W
{
ÄÄ 
Email
ÅÅ 
=
ÅÅ 
usuario
ÅÅ #
?
ÅÅ# $
.
ÅÅ$ %
Email
ÅÅ% *
??
ÅÅ+ -
dto
ÅÅ. 1
?
ÅÅ1 2
.
ÅÅ2 3
Email
ÅÅ3 8
,
ÅÅ8 9
Success
ÇÇ 
=
ÇÇ 
success
ÇÇ %
}
ÉÉ 
)
ÉÉ 
}
ÑÑ 
;
ÑÑ &
_eventTrackingRepository
ÜÜ $
.
ÜÜ$ %
Create
ÜÜ% +
(
ÜÜ+ ,
eventTrackingDto
ÜÜ, <
)
ÜÜ< =
;
ÜÜ= >
}
áá 	
public
îî 
string
îî +
GenerateTemporaryKeyEmailBody
îî 3
(
îî3 4
Usuario
îî4 ;
usuario
îî< C
,
îîC D
string
îîE K
clave
îîL Q
)
îîQ R
{
ïï 	
string
ññ 
templatePath
ññ 
=
ññ  !
_configuration
ññ" 0
[
ññ0 1
$str
ññ1 K
]
ññK L
??
ññM O
$str
ññP R
;
ññR S
if
òò 
(
òò 
File
òò 
.
òò 
Exists
òò 
(
òò 
templatePath
òò (
)
òò( )
)
òò) *
{
ôô 
string
öö 
htmlBody
öö 
=
öö  !
File
öö" &
.
öö& '
ReadAllText
öö' 2
(
öö2 3
templatePath
öö3 ?
,
öö? @
Encoding
ööA I
.
ööI J
UTF8
ööJ N
)
ööN O
;
ööO P
return
õõ 
string
õõ 
.
õõ 
Format
õõ $
(
õõ$ %
htmlBody
õõ% -
,
õõ- .
usuario
õõ/ 6
.
õõ6 7
Nombre
õõ7 =
,
õõ= >
usuario
õõ? F
.
õõF G
Email
õõG L
,
õõL M
clave
õõN S
)
õõS T
;
õõT U
}
úú 
else
ùù 
{
ûû 
throw
üü 
new
üü #
FileNotFoundException
üü /
(
üü/ 0
$str
üü0 v
)
üüv w
;
üüw x
}
†† 
}
°° 	
}
¢¢ 
}££ û
SC:\Users\Dell\source\repos\BuscadorCan\Core\Service\RandomStringGeneratorService.cs
	namespace 	
Core
 
. 
Service 
{ 
public 

class (
RandomStringGeneratorService -
:. /)
IRandomStringGeneratorService0 M
{ 
private

 
const

 
string

 

ValidChars

 '
=

( )
$str

* i
;

i j
private 
const 
string 
ValidDigits (
=) *
$str+ 7
;7 8
public 
string %
GenerateTemporaryPassword /
(/ 0
int0 3
length4 :
): ;
{ 	
return 
Generate 
( 
length "
," #

ValidChars$ .
). /
;/ 0
} 	
public 
string !
GenerateTemporaryCode +
(+ ,
int, /
length0 6
)6 7
{ 	
return 
Generate 
( 
length "
," #
ValidDigits$ /
)/ 0
;0 1
} 	
private 
string 
Generate 
(  
int  #
length$ *
,* +
string, 2

validChars3 =
)= >
{   	
StringBuilder"" 
result""  
=""! "
new""# &
StringBuilder""' 4
(""4 5
)""5 6
;""6 7
using%% 
(%% !
RandomNumberGenerator%% (
rng%%) ,
=%%- .!
RandomNumberGenerator%%/ D
.%%D E
Create%%E K
(%%K L
)%%L M
)%%M N
{&& 
byte'' 
['' 
]'' 

uintBuffer'' !
=''" #
new''$ '
byte''( ,
['', -
sizeof''- 3
(''3 4
uint''4 8
)''8 9
]''9 :
;'': ;
while)) 
()) 
length)) 
--)) 
>))  !
$num))" #
)))# $
{** 
rng,, 
.,, 
GetBytes,,  
(,,  !

uintBuffer,,! +
),,+ ,
;,,, -
uint-- 
	randomNum-- "
=--# $
BitConverter--% 1
.--1 2
ToUInt32--2 :
(--: ;

uintBuffer--; E
,--E F
$num--G H
)--H I
;--I J
result.. 
... 
Append.. !
(..! "

validChars.." ,
[.., -
(..- .
int... 1
)..1 2
(..2 3
	randomNum..3 <
%..= >
(..? @
uint..@ D
)..D E

validChars..E O
...O P
Length..P V
)..V W
]..W X
)..X Y
;..Y Z
}// 
}00 
return33 
result33 
.33 
ToString33 "
(33" #
)33# $
;33$ %
}44 	
}55 
}66 à!
AC:\Users\Dell\source\repos\BuscadorCan\Core\Service\ONAService.cs
	namespace 	
Core
 
. 
Service 
{ 
public 

class 

ONAService 
: 
IONAService )
{		 
private

 
readonly

 
IONARepository

 '
oNARepository

( 5
;

5 6
private 
readonly 
IJwtService $
_jwtService% 0
;0 1
public 

ONAService 
( 
IONARepository (
oNARepository) 6
,6 7
IJwtService8 C

jwtServiceD N
)N O
{ 	
this 
. 
oNARepository 
=  
oNARepository! .
;. /
this 
. 
_jwtService 
= 

jwtService )
;) *
} 	
public 
bool 
Create 
( 
ONA 
data #
)# $
{ 	
data 
. 
IdUserCreacion 
=  !
_jwtService" -
.- .
GetUserIdFromToken. @
(@ A
_jwtServiceA L
.L M
GetTokenFromHeaderM _
(_ `
)` a
??b d
$stre g
)g h
;h i
return 
oNARepository  
.  !
Create! '
(' (
data( ,
), -
;- .
} 	
public 
List 
< 
ONA 
> 
FindAll  
(  !
)! "
{ 	
return 
oNARepository  
.  !
FindAll! (
(( )
)) *
;* +
} 	
public 
List 
< 
VwPais 
> 
FindAllPaises )
() *
)* +
{ 	
return 
oNARepository  
.  !
FindAllPaises! .
(. /
)/ 0
;0 1
}   	
public"" 
ONA"" 
?"" 
FindById"" 
("" 
int""  
Id""! #
)""# $
{## 	
return$$ 
oNARepository$$  
.$$  !
FindById$$! )
($$) *
Id$$* ,
)$$, -
;$$- .
}%% 	
public'' 
Task'' 
<'' 
ONA'' 
?'' 
>'' 
FindByIdAsync'' '
(''' (
int''( +
Id'', .
)''. /
{(( 	
return)) 
oNARepository))  
.))  !
FindByIdAsync))! .
()). /
Id))/ 1
)))1 2
;))2 3
}** 	
public,, 
ONA,, 
?,, 
FindBySiglas,,  
(,,  !
string,,! '
siglas,,( .
),,. /
{-- 	
return.. 
oNARepository..  
...  !
FindBySiglas..! -
(..- .
siglas... 4
)..4 5
;..5 6
}// 	
public11 
List11 
<11 
ONA11 
>11 
GetListByONAsAsync11 +
(11+ ,
int11, /
idOna110 5
)115 6
{22 	
return33 
oNARepository33  
.33  !
GetListByONAsAsync33! 3
(333 4
idOna334 9
)339 :
;33: ;
}44 	
public66 
bool66 
Update66 
(66 
ONA66 
data66 #
)66# $
{77 	
var88 
	userToken88 
=88 
_jwtService88 '
.88' (
GetUserIdFromToken88( :
(88: ;
_jwtService88; F
.88F G
GetTokenFromHeader88G Y
(88Y Z
)88Z [
??88\ ^
$str88_ a
)88a b
;88b c
return99 
oNARepository99  
.99  !
Update99! '
(99' (
data99( ,
,99, -
	userToken99. 7
)997 8
;998 9
}:: 	
};; 
}<< ﬂ$
HC:\Users\Dell\source\repos\BuscadorCan\Core\Service\OnaMigrateService.cs
	namespace 	
Core
 
. 
Service 
{ 
public		 

class		 
OnaMigrateService		 "
:		# $
IOnaMigrate		% 0
{

 
private 
readonly 

HttpClient #
_httpClient$ /
;/ 0
private 
readonly !
IOnaMigrateRepository ."
_ionaMigrateRepository/ E
;E F
private 
string 
UrlBase 
=  
$str! F
;F G
public 
OnaMigrateService  
(  !

HttpClient! +

httpClient, 6
,6 7!
IOnaMigrateRepository8 M!
IonaMigrateRepositoryN c
)c d
{ 	
this 
. 
_httpClient 
= 

httpClient )
;) *"
_ionaMigrateRepository "
=# $!
IonaMigrateRepository% :
;: ;
} 	
public!! 
async!! 
Task!! 
<!! 
List!! 
<!! 
OnaMigrateDto!! ,
>!!, -
>!!- .
postOnaMigrate!!/ =
(!!= >
string!!> D
view!!E I
,!!I J
int!!K N
idOna!!O T
,!!T U
int!!V Y
	idEsquema!!Z c
)!!c d
{"" 	
try## 
{$$ 
var%% 
url%% 
=%% 
$"%% 
{%% 
UrlBase%% $
}%%$ %
$str%%% >
{%%> ?
view%%? C
}%%C D
$str%%D b
"%%b c
;%%c d
var&& 
response&& 
=&& 
await&& $
_httpClient&&% 0
.&&0 1
GetAsync&&1 9
(&&9 :
url&&: =
)&&= >
;&&> ?
response(( 
.(( #
EnsureSuccessStatusCode(( 0
(((0 1
)((1 2
;((2 3
using** 
var** 
contentStream** '
=**( )
await*** /
response**0 8
.**8 9
Content**9 @
.**@ A
ReadAsStreamAsync**A R
(**R S
)**S T
;**T U
using++ 
var++ 
jsonDoc++ !
=++" #
await++$ )
JsonDocument++* 6
.++6 7

ParseAsync++7 A
(++A B
contentStream++B O
)++O P
;++P Q
if-- 
(-- 
!-- 
jsonDoc-- 
.-- 
RootElement-- (
.--( )
TryGetProperty--) 7
(--7 8
$str--8 ?
,--? @
out--A D
var--E H
datosElement--I U
)--U V
)--V W
{.. 
Console// 
.// 
	WriteLine// %
(//% &
$str//& a
)//a b
;//b c
return00 
null00 
;00  
}11 
var33 
result33 
=33 "
_ionaMigrateRepository33 3
.333 4
postOnaMigrate334 B
(33B C
idOna33C H
,33H I
	idEsquema33J S
,33S T
datosElement33U a
.33a b

GetRawText33b l
(33l m
)33m n
)33n o
;33o p
return55 
result55 
;55 
}66 
catch77 
(77  
HttpRequestException77 '
ex77( *
)77* +
{88 
Console99 
.99 
	WriteLine99 !
(99! "
$"99" $
$str99$ @
{99@ A
ex99A C
.99C D
Message99D K
}99K L
"99L M
)99M N
;99N O
return:: 
null:: 
;:: 
};; 
catch<< 
(<< 
JsonException<<  
ex<<! #
)<<# $
{== 
Console>> 
.>> 
	WriteLine>> !
(>>! "
$">>" $
$str>>$ >
{>>> ?
ex>>? A
.>>A B
Message>>B I
}>>I J
">>J K
)>>K L
;>>L M
return?? 
null?? 
;?? 
}@@ 
catchAA 
(AA 
	ExceptionAA 
exAA 
)AA  
{BB 
ConsoleCC 
.CC 
	WriteLineCC !
(CC! "
$"CC" $
$strCC$ M
{CCM N
exCCN P
.CCP Q
MessageCCQ X
}CCX Y
"CCY Z
)CCZ [
;CC[ \
returnDD 
nullDD 
;DD 
}EE 
}FF 	
}HH 
}II í6
IC:\Users\Dell\source\repos\BuscadorCan\Core\Service\ONAConexionService.cs
	namespace		 	
Core		
 
.		 
Service		 
{

 
public 

class 
ONAConexionService #
:$ %
IONAConexionService& 9
{ 
private 
readonly "
IONAConexionRepository /"
_oNAConexionRepository0 F
;F G
private 
readonly 
IJwtService $
_jwtService% 0
;0 1
private 
readonly 
IMapper  
mapper! '
;' (
public 
ONAConexionService !
(! ""
IONAConexionRepository" 8!
oNAConexionRepository9 N
,N O
IJwtServiceP [

jwtService\ f
,f g
IMapperh o
mapperp v
)v w
{ 	
this 
. "
_oNAConexionRepository '
=( )!
oNAConexionRepository* ?
;? @
this 
. 
_jwtService 
= 

jwtService )
;) *
this 
. 
mapper 
= 
mapper  
;  !
} 	
public 
bool 
Create 
( 
ONAConexionDto )
data* .
). /
{ 	
ONAConexion 
oNA 
= 
mapper $
.$ %
Map% (
<( )
ONAConexion) 4
>4 5
(5 6
data6 :
): ;
;; <
oNA 
. 
IdUserCreacion 
=  
_jwtService! ,
., -
GetUserIdFromToken- ?
(? @
_jwtService@ K
.K L
GetTokenFromHeaderL ^
(^ _
)_ `
??a c
$strd f
)f g
;g h
oNA 
. 
IdUserModifica 
=  
oNA! $
.$ %
IdUserCreacion% 3
;3 4
oNA 
. 
FechaCreacion 
= 
DateTime  (
.( )
Now) ,
;, -
oNA 
. 
FechaModifica 
= 
oNA  #
.# $
FechaCreacion$ 1
;1 2
oNA 
. 
Estado 
= 

Constantes #
.# $
ESTADO_USUARIO_A$ 4
;4 5
return   "
_oNAConexionRepository   )
.  ) *
Create  * 0
(  0 1
oNA  1 4
)  4 5
;  5 6
}!! 	
public## 
List## 
<## 
ONAConexionDto## "
>##" #
FindAll##$ +
(##+ ,
)##, -
{$$ 	
List%% 
<%% 
ONAConexion%% 
>%% 
oNAConexions%% *
=%%+ ,"
_oNAConexionRepository%%- C
.%%C D
FindAll%%D K
(%%K L
)%%L M
;%%M N
return&& 
mapper&& 
.&& 
Map&& 
<&& 
List&& "
<&&" #
ONAConexionDto&&# 1
>&&1 2
>&&2 3
(&&3 4
oNAConexions&&4 @
)&&@ A
;&&A B
}'' 	
public)) 
ONAConexionDto)) 
?)) 
FindById)) '
())' (
int))( +
Id)), .
))). /
{** 	
ONAConexion++ 
?++ 
oNA++ 
=++ "
_oNAConexionRepository++ 5
.++5 6
FindById++6 >
(++> ?
Id++? A
)++A B
;++B C
return,, 
mapper,, 
.,, 
Map,, 
<,, 
ONAConexionDto,, ,
>,,, -
(,,- .
oNA,,. 1
),,1 2
;,,2 3
}-- 	
public// 
ONAConexionDto// 
?// 
FindByIdONA// *
(//* +
int//+ .
IdONA/// 4
)//4 5
{00 	
ONAConexion11 
oNA11 
=11 "
_oNAConexionRepository11 4
.114 5
FindByIdONA115 @
(11@ A
IdONA11A F
)11F G
;11G H
return22 
mapper22 
.22 
Map22 
<22 
ONAConexionDto22 ,
>22, -
(22- .
oNA22. 1
)221 2
;222 3
}33 	
public55 
async55 
Task55 
<55 
ONAConexionDto55 (
?55( )
>55) *
FindByIdONAAsync55+ ;
(55; <
int55< ?
IdONA55@ E
)55E F
{66 	
ONAConexion77 
?77 
oNAConexions77 %
=77& '
await77( -"
_oNAConexionRepository77. D
.77D E
FindByIdONAAsync77E U
(77U V
IdONA77V [
)77[ \
;77\ ]
return88 
mapper88 
.88 
Map88 
<88 
ONAConexionDto88 ,
>88, -
(88- .
oNAConexions88. :
)88: ;
;88; <
}99 	
public:: 
List:: 
<:: 
ONAConexionDto:: "
>::" #(
GetONAConexionByOnaListAsync::$ @
(::@ A
int::A D
IdONA::E J
)::J K
{;; 	
List<< 
<<< 
ONAConexion<< 
><< 
oNAConexions<< *
=<<+ ,"
_oNAConexionRepository<<- C
.<<C D(
GetOnaConexionByOnaListAsync<<D `
(<<` a
IdONA<<a f
)<<f g
;<<g h
return== 
mapper== 
.== 
Map== 
<== 
List== "
<==" #
ONAConexionDto==# 1
>==1 2
>==2 3
(==3 4
oNAConexions==4 @
)==@ A
;==A B
}>> 	
public?? 
bool?? 
Update?? 
(?? 
ONAConexionDto?? )
data??* .
)??. /
{@@ 	
varAA 
	userTokenAA 
=AA 
_jwtServiceAA '
.AA' (
GetUserIdFromTokenAA( :
(AA: ;
_jwtServiceAA; F
.AAF G
GetTokenFromHeaderAAG Y
(AAY Z
)AAZ [
??AA\ ^
$strAA_ a
)AAa b
;AAb c
ONAConexionBB 
oNABB 
=BB 
mapperBB $
.BB$ %
MapBB% (
<BB( )
ONAConexionBB) 4
>BB4 5
(BB5 6
dataBB6 :
)BB: ;
;BB; <
returnCC "
_oNAConexionRepositoryCC )
.CC) *
UpdateCC* 0
(CC0 1
oNACC1 4
,CC4 5
	userTokenCC6 ?
)CC? @
;CC@ A
}DD 	
}EE 
}FF ”˝
?C:\Users\Dell\source\repos\BuscadorCan\Core\Service\Migrador.cs
	namespace 	
Core
 
. 
Service 
. 
IService 
{ 
public 

class 
Migrador 
( "
IEsquemaDataRepository 0!
esquemaDataRepository1 F
,F G&
IEsquemaFullTextRepositoryH b%
esquemaFullTextRepositoryc |
,| }$
IHomologacionRepository	~ ï$
homologacionRepository
ñ ¨
,
¨ ≠ 
IEsquemaRepository
Æ ¿
esquemaRepository
¡ “
,
“ ”$
IONAConexionRepository
‘ Í 
conexionRepository
Î ˝
,
˝ ˛
IConfiguration
ˇ ç
configuration
é õ
,
õ ú,
IConectionStringBuilderService
ù ª,
connectionStringBuilderService
º ⁄
,
⁄ €%
IEsquemaVistaRepository
‹ Û$
esquemaVistaRepository
Ù ä
,
ä ã,
IEsquemaVistaColumnaRepository
å ™+
esquemaVistaColumnaRepository
´ »
,
» …%
ILogMigracionRepository
  ·$
logMigracionRepository
‚ ¯
,
¯ ˘+
IpaActualizarFiltroRepository
˙ ó!
ipaActualizarFiltro
ò ´
)
´ ¨
:
≠ Æ
	IMigrador
Ø ∏
{ 
private "
IEsquemaDataRepository &
_repositoryDLO' 5
=6 7!
esquemaDataRepository8 M
;M N
private &
IEsquemaFullTextRepository *
_repositoryOFT+ 9
=: ;%
esquemaFullTextRepository< U
;U V
private #
IEsquemaVistaRepository '
_repositoryEVRP( 7
=8 9"
esquemaVistaRepository: P
;P Q
private *
IEsquemaVistaColumnaRepository .
_repositoryEVCRP/ ?
=@ A)
esquemaVistaColumnaRepositoryB _
;_ `
private #
IHomologacionRepository '
_repositoryH( 4
=5 6"
homologacionRepository7 M
;M N
private 
IEsquemaRepository "
_repositoryHE# 0
=1 2
esquemaRepository3 D
;D E
private "
IONAConexionRepository &
_repositoryC' 3
=4 5
conexionRepository6 H
;H I
private *
IConectionStringBuilderService .+
_connectionStringBuilderService/ N
=O P*
connectionStringBuilderServiceQ o
;o p
private #
ILogMigracionRepository '
_logMigracion( 5
=6 7"
logMigracionRepository8 N
;N O
private )
IpaActualizarFiltroRepository - 
_ipaActualizarFiltro. B
=C D
ipaActualizarFiltroE X
;X Y
private 
string 
connectionString '
=( )
configuration* 7
.7 8
GetConnectionString8 K
(K L
$strL Y
)Y Z
??[ ]
throw^ c
newd g&
InvalidOperationException	h Å
(
Å Ç
$str
Ç º
)
º Ω
;
Ω æ
private 
ONAConexion 
? 
currentConexion ,
=- .
null/ 3
;3 4
private 
int 
executionIndex "
=# $
$num% &
;& '
private   
string   
[   
]   
views   
=    
[  ! "
]  " #
;  # $
private!! 
string!! 
[!! 
]!! 
schemas!!  
=!!! "
[!!# $
]!!$ %
;!!% &
private"" 
int"" 
["" 
]"" 
hids"" 
="" 
["" 
]"" 
;""  
private## 
int## 
[## 
]## 
heids## 
=## 
[## 
]##  
;##  !
private$$ 
string$$ 
[$$ 
]$$ 
vids$$ 
=$$ 
[$$  !
]$$! "
;$$" #
private%% 
int%% 
[%% 
]%% 
filters%% 
=%% 
[%%  !
]%%! "
;%%" #
private&& 
bool&& 
deleted&& 
=&& 
false&& $
;&&$ %
private'' 
bool'' 
saveIdVista''  
=''! "
false''# (
;''( )
private(( 
bool(( 

saveIdEnte(( 
=((  !
false((" '
;((' (
List)) 
<)) 
string)) 
>))  
lstViewNoRegistradas)) )
=))* +
new)), /
List))0 4
<))4 5
string))5 ;
>)); <
())< =
)))= >
;))> ?
List** 
<** 
string** 
>** 
lstViewRegistradas** '
=**( )
new*** -
List**. 2
<**2 3
string**3 9
>**9 :
(**: ;
)**; <
;**< =
List++ 
<++ 
string++ 
>++ #
lstColumnsNoRegistradas++ ,
=++- .
new++/ 2
List++3 7
<++7 8
string++8 >
>++> ?
(++? @
)++@ A
;++A B
List,, 
<,, 
string,, 
>,, !
lstColumnsRegistradas,, *
=,,+ ,
new,,- 0
List,,1 5
<,,5 6
string,,6 <
>,,< =
(,,= >
),,> ?
;,,? @
public-- 
async-- 
Task-- 
<-- 
bool-- 
>-- 
MigrarAsync--  +
(--+ ,
ONAConexion--, 7
conexion--8 @
)--@ A
{.. 	
List// 
<// 
EsquemaVista// 
>// 
viewRegistradas// .
=/// 0
new//1 4
List//5 9
<//9 :
EsquemaVista//: F
>//F G
(//G H
)//H I
;//I J
List00 
<00 
EsquemaVistaColumna00 $
>00$ %
viewColumns00& 1
=002 3
new004 7
List008 <
<00< =
EsquemaVistaColumna00= P
>00P Q
(00Q R
)00R S
;00S T
	Stopwatch11 
	stopwatch11 
=11  !
new11" %
	Stopwatch11& /
(11/ 0
)110 1
;111 2
try22 
{33 
bool44 
	resultado44 
=44  
true44! %
;44% &
int55 
idOna55 
=55 
conexion55 $
.55$ %
IdONA55% *
;55* +
var77 
connectionString77 $
=77% &+
_connectionStringBuilderService77' F
.77F G!
BuildConnectionString77G \
(77\ ]
conexion77] e
)77e f
;77f g
var88 "
isConnectionSuccessful88 *
=88+ ,'
TestDatabaseConnectionAsync88- H
(88H I
connectionString88I Y
,88Y Z
conexion88[ c
.88c d
OrigenDatos88d o
)88o p
;88p q
if99 
(99 "
isConnectionSuccessful99 *
)99* +
{:: 
Console;; 
.;; 
	WriteLine;; %
(;;% &
$str;;& ]
);;] ^
;;;^ _
var<< 
data<< 
=<< 
new<< "
LogMigracion<<# /
{== 
IdONA>> 
=>> 
idOna>>  %
,>>% &
OrigenDatos?? #
=??$ %
conexion??& .
.??. /
OrigenDatos??/ :
,??: ;
Observacion@@ #
=@@$ %
$str@@& G
}AA 
;AA 
_logMigracionBB !
.BB! "
CreateBB" (
(BB( )
dataBB) -
)BB- .
;BB. /
}CC 
elseDD 
{EE 
varFF 
dataFF 
=FF 
newFF "
LogMigracionFF# /
{GG 
IdONAHH 
=HH 
idOnaHH  %
,HH% &
OrigenDatosII #
=II$ %
conexionII& .
.II. /
OrigenDatosII/ :
,II: ;
ObservacionJJ #
=JJ$ %
$strJJ& X
}KK 
;KK 
_logMigracionLL !
.LL! "
CreateLL" (
(LL( )
dataLL) -
)LL- .
;LL. /
ConsoleMM 
.MM 
	WriteLineMM %
(MM% &
$strMM& X
)MMX Y
;MMY Z
}NN 
	stopwatchQQ 
.QQ 
StartQQ 
(QQ  
)QQ  !
;QQ! "
viewRegistradasTT 
=TT  !
_repositoryEVRPTT" 1
.TT1 2
FindAllTT2 9
(TT9 :
)TT: ;
.TT; <
WhereTT< A
(TTA B
vTTB C
=>TTD F
vTTG H
.TTH I
IdONATTI N
==TTO Q
idOnaTTR W
)TTW X
.TTX Y
ToListTTY _
(TT_ `
)TT` a
;TTa b
boolVV 
vistaApVV 
;VV 
boolWW 
columnApWW 
;WW 
varXX 
columnasValidasXX #
=XX$ %
newXX& )
ListXX* .
<XX. /
EsquemaVistaColumnaXX/ B
>XXB C
(XXC D
)XXD E
;XXE F
_repositoryDLO\\ 
.\\ 
DeleteOldRecords\\ /
(\\/ 0
idOna\\0 5
)\\5 6
;\\6 7
foreach__ 
(__ 
var__ 
vista__ "
in__# %
viewRegistradas__& 5
)__5 6
{`` 
vistaApaa 
=aa 
awaitaa #
ValidarVistaAsyncaa$ 5
(aa5 6
connectionStringaa6 F
,aaF G
conexionaaH P
.aaP Q
OrigenDatosaaQ \
,aa\ ]
vistaaa^ c
.aac d
VistaOrigenaad o
,aao p
idOnaaaq v
)aav w
;aaw x
ifbb 
(bb 
vistaApbb 
)bb  
{cc 
viewColumnsdd #
=dd$ %
_repositoryEVCRPdd& 6
.dd6 7 
FindByIdEsquemaVistadd7 K
(ddK L
vistaddL Q
.ddQ R
IdEsquemaVistaddR `
)dd` a
;dda b
foreachff 
(ff  !
varff! $
columnff% +
inff, .
viewColumnsff/ :
)ff: ;
{gg 
columnAphh $
=hh% &
awaithh' ,&
ValidarColumnaEnVistaAsynchh- G
(hhG H
connectionStringhhH X
,hhX Y
conexionhhZ b
.hhb c
OrigenDatoshhc n
,hhn o
vistahhp u
.hhu v
VistaOrigen	hhv Å
,
hhÅ Ç
column
hhÉ â
.
hhâ ä
ColumnaVista
hhä ñ
,
hhñ ó
idOna
hhò ù
)
hhù û
;
hhû ü
ifii 
(ii  
columnApii  (
)ii( )
{jj 
columnasValidaskk  /
.kk/ 0
Addkk0 3
(kk3 4
columnkk4 :
)kk: ;
;kk; <
}ll 
elsemm  
{nn 
Consoleoo  '
.oo' (
	WriteLineoo( 1
(oo1 2
$stroo2 X
)ooX Y
;ooY Z
varqq  #
dataqq$ (
=qq) *
newqq+ .
LogMigracionqq/ ;
{rr  !
IdONAss$ )
=ss* +
idOnass, 1
,ss1 2
OrigenDatostt$ /
=tt0 1
conexiontt2 :
.tt: ;
OrigenDatostt; F
,ttF G
Observacionuu$ /
=uu0 1
$"uu2 4
$struu4 =
{uu= >
columnuu> D
.uuD E
ColumnaEsquemauuE S
}uuS T
$struuT o
"uuo p
}vv  !
;vv! "
_logMigracionww  -
.ww- .
Createww. 4
(ww4 5
dataww5 9
)ww9 :
;ww: ;
}xx 
}zz 
}|| 
else}} 
{~~ 
Console 
.  
	WriteLine  )
() *
$str* N
)N O
;O P
var
ÄÄ 
data
ÄÄ  
=
ÄÄ! "
new
ÄÄ# &
LogMigracion
ÄÄ' 3
{
ÅÅ 
IdONA
ÇÇ !
=
ÇÇ" #
idOna
ÇÇ$ )
,
ÇÇ) *
OrigenDatos
ÉÉ '
=
ÉÉ( )
conexion
ÉÉ* 2
.
ÉÉ2 3
OrigenDatos
ÉÉ3 >
,
ÉÉ> ?
Observacion
ÑÑ '
=
ÑÑ( )
$str
ÑÑ* A
+
ÑÑB C
vista
ÑÑD I
.
ÑÑI J
VistaOrigen
ÑÑJ U
+
ÑÑV W
$str
ÑÑX e
}
ÖÖ 
;
ÖÖ 
_logMigracion
ÜÜ %
.
ÜÜ% &
Create
ÜÜ& ,
(
ÜÜ, -
data
ÜÜ- 1
)
ÜÜ1 2
;
ÜÜ2 3
}
áá 
if
ââ 
(
ââ 
columnasValidas
ââ '
.
ââ' (
Any
ââ( +
(
ââ+ ,
)
ââ, -
)
ââ- .
{
ää 
bool
åå 

resspuesta
åå '
=
åå( )
await
åå* /(
ProcesarVistaConDatosAsync
åå0 J
(
ååJ K
connectionString
ååK [
,
åå[ \
conexion
åå] e
.
ååe f
OrigenDatos
ååf q
,
ååq r
vista
åås x
.
ååx y
VistaOrigenååy Ñ
,ååÑ Ö
columnasValidasååÜ ï
,ååï ñ
vistaååó ú
.ååú ù
IdEsquemaVistaååù ´
,åå´ ¨
idOnaåå≠ ≤
)åå≤ ≥
;åå≥ ¥
if
éé 
(
éé 

resspuesta
éé &
)
éé& '
{
èè 
Console
êê #
.
êê# $
	WriteLine
êê$ -
(
êê- .
$"
êê. 0
$str
êê0 7
{
êê7 8
vista
êê8 =
.
êê= >
VistaOrigen
êê> I
}
êêI J
$str
êêJ c
"
êêc d
)
êêd e
;
êêe f
var
ëë 
data
ëë  $
=
ëë% &
new
ëë' *
LogMigracion
ëë+ 7
{
íí 
IdONA
ìì  %
=
ìì& '
idOna
ìì( -
,
ìì- .
OrigenDatos
îî  +
=
îî, -
conexion
îî. 6
.
îî6 7
OrigenDatos
îî7 B
,
îîB C
Observacion
ïï  +
=
ïï, -
$str
ïï. 7
+
ïï8 9
vista
ïï: ?
.
ïï? @
VistaOrigen
ïï@ K
+
ïïL M
$str
ïïN h
}
ññ 
;
ññ 
_logMigracion
óó )
.
óó) *
Create
óó* 0
(
óó0 1
data
óó1 5
)
óó5 6
;
óó6 7
columnasValidas
òò +
.
òò+ ,
Clear
òò, 1
(
òò1 2
)
òò2 3
;
òò3 4
}
ôô 
else
öö 
{
õõ 
Console
úú #
.
úú# $
	WriteLine
úú$ -
(
úú- .
$"
úú. 0
$str
úú0 L
{
úúL M
vista
úúM R
.
úúR S
VistaOrigen
úúS ^
}
úú^ _
$str
úú_ p
"
úúp q
)
úúq r
;
úúr s
var
ùù 
data
ùù  $
=
ùù% &
new
ùù' *
LogMigracion
ùù+ 7
{
ûû 
IdONA
üü  %
=
üü& '
idOna
üü( -
,
üü- .
OrigenDatos
††  +
=
††, -
conexion
††. 6
.
††6 7
OrigenDatos
††7 B
,
††B C
Observacion
°°  +
=
°°, -
$str
°°. L
+
°°M N
vista
°°O T
.
°°T U
VistaOrigen
°°U `
+
°°a b
$str
°°c p
}
¢¢ 
;
¢¢ 
_logMigracion
££ )
.
££) *
Create
££* 0
(
££0 1
data
££1 5
)
££5 6
;
££6 7
}
§§ 
}
¶¶ 
}
®® 
var
™™ 
resultadoSP
™™ 
=
™™  !
await
™™" '"
_ipaActualizarFiltro
™™( <
.
™™< =#
ActualizarFiltroAsync
™™= R
(
™™R S
)
™™S T
;
™™T U
if
´´ 
(
´´ 
resultadoSP
´´ 
)
´´  
{
¨¨ 
Console
≠≠ 
.
≠≠ 
	WriteLine
≠≠ %
(
≠≠% &
$str
≠≠& ]
)
≠≠] ^
;
≠≠^ _
}
ÆÆ 
else
ØØ 
{
∞∞ 
Console
±± 
.
±± 
	WriteLine
±± %
(
±±% &
$str
±±& V
)
±±V W
;
±±W X
}
≤≤ 
	stopwatch
µµ 
.
µµ 
Stop
µµ 
(
µµ 
)
µµ  
;
µµ  !
TimeSpan
∂∂ 
tiempoTotal
∂∂ $
=
∂∂% &
	stopwatch
∂∂' 0
.
∂∂0 1
Elapsed
∂∂1 8
;
∂∂8 9
var
ππ 
	logTiempo
ππ 
=
ππ 
new
ππ  #
LogMigracion
ππ$ 0
{
∫∫ 
IdONA
ªª 
=
ªª 
idOna
ªª !
,
ªª! "
OrigenDatos
ºº 
=
ºº  !
conexion
ºº" *
.
ºº* +
OrigenDatos
ºº+ 6
,
ºº6 7
Observacion
ΩΩ 
=
ΩΩ  !
$"
ΩΩ" $
$str
ΩΩ$ ?
{
ΩΩ? @
tiempoTotal
ΩΩ@ K
.
ΩΩK L
Hours
ΩΩL Q
}
ΩΩQ R
$str
ΩΩR T
{
ΩΩT U
tiempoTotal
ΩΩU `
.
ΩΩ` a
Minutes
ΩΩa h
}
ΩΩh i
$str
ΩΩi k
{
ΩΩk l
tiempoTotal
ΩΩl w
.
ΩΩw x
Seconds
ΩΩx 
}ΩΩ Ä
$strΩΩÄ Ç
{ΩΩÇ É
tiempoTotalΩΩÉ é
.ΩΩé è
MillisecondsΩΩè õ
}ΩΩõ ú
$strΩΩú ü
"ΩΩü †
}
ææ 
;
ææ 
_logMigracion
¿¿ 
.
¿¿ 
Create
¿¿ $
(
¿¿$ %
	logTiempo
¿¿% .
)
¿¿. /
;
¿¿/ 0
return
¬¬ 
	resultado
¬¬  
;
¬¬  !
}
√√ 
catch
ƒƒ 
(
ƒƒ 
	Exception
ƒƒ 
ex
ƒƒ 
)
ƒƒ  
{
≈≈ 
throw
«« 
ex
«« 
;
«« 
}
»» 
}
   	
public
ÃÃ 
async
ÃÃ 
Task
ÃÃ 
<
ÃÃ 
bool
ÃÃ 
>
ÃÃ 
ValidarVistaAsync
ÃÃ  1
(
ÃÃ1 2
string
ÃÃ2 8
connectionString
ÃÃ9 I
,
ÃÃI J
string
ÃÃK Q
origenDatos
ÃÃR ]
,
ÃÃ] ^
string
ÃÃ_ e
vista
ÃÃf k
,
ÃÃk l
int
ÃÃm p
idONA
ÃÃq v
)
ÃÃv w
{
ÕÕ 	
try
ŒŒ 
{
œœ 
var
—— !
connectionFactories
—— '
=
——( )
new
——* -

Dictionary
——. 8
<
——8 9
string
——9 ?
,
——? @
Func
——A E
<
——E F
string
——F L
,
——L M
IDbConnection
——N [
>
——[ \
>
——\ ]
{
““ 
{
”” 
$str
”” !
,
””! "
connStr
””# *
=>
””+ -
new
””. 1
SqlConnection
””2 ?
(
””? @
connStr
””@ G
)
””G H
}
””I J
,
””J K
{
‘‘ 
$str
‘‘ 
,
‘‘ 
connStr
‘‘ &
=>
‘‘' )
new
‘‘* -
MySql
‘‘. 3
.
‘‘3 4
Data
‘‘4 8
.
‘‘8 9
MySqlClient
‘‘9 D
.
‘‘D E
MySqlConnection
‘‘E T
(
‘‘T U
connStr
‘‘U \
)
‘‘\ ]
}
‘‘^ _
,
‘‘_ `
{
’’ 
$str
’’  
,
’’  !
connStr
’’" )
=>
’’* ,
new
’’- 0
Npgsql
’’1 7
.
’’7 8
NpgsqlConnection
’’8 H
(
’’H I
connStr
’’I P
)
’’P Q
}
’’R S
,
’’S T
{
÷÷ 
$str
÷÷ 
,
÷÷  
connStr
÷÷! (
=>
÷÷) +
new
÷÷, /
	Microsoft
÷÷0 9
.
÷÷9 :
Data
÷÷: >
.
÷÷> ?
Sqlite
÷÷? E
.
÷÷E F
SqliteConnection
÷÷F V
(
÷÷V W
connStr
÷÷W ^
)
÷÷^ _
}
÷÷` a
}
◊◊ 
;
◊◊ 
if
ŸŸ 
(
ŸŸ 
!
ŸŸ !
connectionFactories
ŸŸ (
.
ŸŸ( )
TryGetValue
ŸŸ) 4
(
ŸŸ4 5
origenDatos
ŸŸ5 @
.
ŸŸ@ A
ToUpper
ŸŸA H
(
ŸŸH I
)
ŸŸI J
,
ŸŸJ K
out
ŸŸL O
var
ŸŸP S
createConnection
ŸŸT d
)
ŸŸd e
)
ŸŸe f
{
⁄⁄ 
throw
€€ 
new
€€ #
NotSupportedException
€€ 3
(
€€3 4
$"
€€4 6
$str
€€6 M
{
€€M N
origenDatos
€€N Y
}
€€Y Z
$str
€€Z i
"
€€i j
)
€€j k
;
€€k l
}
‹‹ 
using
ﬁﬁ 
var
ﬁﬁ 

connection
ﬁﬁ $
=
ﬁﬁ% &
createConnection
ﬁﬁ' 7
(
ﬁﬁ7 8
connectionString
ﬁﬁ8 H
)
ﬁﬁH I
;
ﬁﬁI J

connection
ﬂﬂ 
.
ﬂﬂ 
Open
ﬂﬂ 
(
ﬂﬂ  
)
ﬂﬂ  !
;
ﬂﬂ! "
string
‚‚ 
query
‚‚ 
=
‚‚ 
origenDatos
‚‚ *
.
‚‚* +
ToUpper
‚‚+ 2
(
‚‚2 3
)
‚‚3 4
switch
‚‚5 ;
{
„„ 
$str
‰‰ 
=>
‰‰  "
$"
‰‰# %
$str
‰‰% 9
{
‰‰9 :
vista
‰‰: ?
}
‰‰? @
"
‰‰@ A
,
‰‰A B
$str
ÂÂ 
=>
ÂÂ 
$"
ÂÂ !
$str
ÂÂ! /
{
ÂÂ/ 0
vista
ÂÂ0 5
}
ÂÂ5 6
$str
ÂÂ6 >
"
ÂÂ> ?
,
ÂÂ? @
$str
ÊÊ 
=>
ÊÊ !
$"
ÊÊ" $
$str
ÊÊ$ 2
{
ÊÊ2 3
vista
ÊÊ3 8
}
ÊÊ8 9
$str
ÊÊ9 A
"
ÊÊA B
,
ÊÊB C
$str
ÁÁ 
=>
ÁÁ  
$"
ÁÁ! #
$str
ÁÁ# 1
{
ÁÁ1 2
vista
ÁÁ2 7
}
ÁÁ7 8
$str
ÁÁ8 @
"
ÁÁ@ A
,
ÁÁA B
_
ËË 
=>
ËË 
throw
ËË 
new
ËË "#
NotSupportedException
ËË# 8
(
ËË8 9
$"
ËË9 ;
$str
ËË; R
{
ËËR S
origenDatos
ËËS ^
}
ËË^ _
$str
ËË_ n
"
ËËn o
)
ËËo p
}
ÈÈ 
;
ÈÈ 
await
ÏÏ 

connection
ÏÏ  
.
ÏÏ  !

QueryAsync
ÏÏ! +
(
ÏÏ+ ,
query
ÏÏ, 1
)
ÏÏ1 2
;
ÏÏ2 3
return
ÔÔ 
true
ÔÔ 
;
ÔÔ 
}
 
catch
ÒÒ 
(
ÒÒ 
	Exception
ÒÒ 
ex
ÒÒ 
)
ÒÒ  
{
ÚÚ 
Console
ÛÛ 
.
ÛÛ 
	WriteLine
ÛÛ !
(
ÛÛ! "
$"
ÛÛ" $
$str
ÛÛ$ ?
{
ÛÛ? @
vista
ÛÛ@ E
}
ÛÛE F
$str
ÛÛF I
{
ÛÛI J
ex
ÛÛJ L
.
ÛÛL M
Message
ÛÛM T
}
ÛÛT U
"
ÛÛU V
)
ÛÛV W
;
ÛÛW X
var
ıı 
data
ıı 
=
ıı 
new
ıı 
LogMigracion
ıı +
{
ˆˆ 
IdONA
˜˜ 
=
˜˜ 
idONA
˜˜ !
,
˜˜! "
OrigenDatos
¯¯ 
=
¯¯  !
origenDatos
¯¯" -
,
¯¯- .
Observacion
˘˘ 
=
˘˘  !
$str
˘˘" 9
+
˘˘: ;
vista
˘˘< A
+
˘˘B C
$str
˘˘D Q
}
˙˙ 
;
˙˙ 
_logMigracion
˚˚ 
.
˚˚ 
Create
˚˚ $
(
˚˚$ %
data
˚˚% )
)
˚˚) *
;
˚˚* +
return
˝˝ 
false
˝˝ 
;
˝˝ 
}
˛˛ 
}
ˇˇ 	
public
ÇÇ 
async
ÇÇ 
Task
ÇÇ 
<
ÇÇ 
bool
ÇÇ 
>
ÇÇ (
ValidarColumnaEnVistaAsync
ÇÇ  :
(
ÇÇ: ;
string
ÇÇ; A
connectionString
ÇÇB R
,
ÇÇR S
string
ÇÇT Z
origenDatos
ÇÇ[ f
,
ÇÇf g
string
ÇÇh n
vista
ÇÇo t
,
ÇÇt u
string
ÇÇv |
columnaÇÇ} Ñ
,ÇÇÑ Ö
intÇÇÜ â
idONAÇÇä è
)ÇÇè ê
{
ÉÉ 	
try
ÑÑ 
{
ÖÖ 
var
áá !
connectionFactories
áá '
=
áá( )
new
áá* -

Dictionary
áá. 8
<
áá8 9
string
áá9 ?
,
áá? @
Func
ááA E
<
ááE F
string
ááF L
,
ááL M
IDbConnection
ááN [
>
áá[ \
>
áá\ ]
{
àà 
{
ââ 
$str
ââ !
,
ââ! "
connStr
ââ# *
=>
ââ+ -
new
ââ. 1
SqlConnection
ââ2 ?
(
ââ? @
connStr
ââ@ G
)
ââG H
}
ââI J
,
ââJ K
{
ää 
$str
ää 
,
ää 
connStr
ää &
=>
ää' )
new
ää* -
MySql
ää. 3
.
ää3 4
Data
ää4 8
.
ää8 9
MySqlClient
ää9 D
.
ääD E
MySqlConnection
ääE T
(
ääT U
connStr
ääU \
)
ää\ ]
}
ää^ _
,
ää_ `
{
ãã 
$str
ãã  
,
ãã  !
connStr
ãã" )
=>
ãã* ,
new
ãã- 0
Npgsql
ãã1 7
.
ãã7 8
NpgsqlConnection
ãã8 H
(
ããH I
connStr
ããI P
)
ããP Q
}
ããR S
,
ããS T
{
åå 
$str
åå 
,
åå  
connStr
åå! (
=>
åå) +
new
åå, /
	Microsoft
åå0 9
.
åå9 :
Data
åå: >
.
åå> ?
Sqlite
åå? E
.
ååE F
SqliteConnection
ååF V
(
ååV W
connStr
ååW ^
)
åå^ _
}
åå` a
}
çç 
;
çç 
if
èè 
(
èè 
!
èè !
connectionFactories
èè (
.
èè( )
TryGetValue
èè) 4
(
èè4 5
origenDatos
èè5 @
.
èè@ A
ToUpper
èèA H
(
èèH I
)
èèI J
,
èèJ K
out
èèL O
var
èèP S
createConnection
èèT d
)
èèd e
)
èèe f
{
êê 
throw
ëë 
new
ëë #
NotSupportedException
ëë 3
(
ëë3 4
$"
ëë4 6
$str
ëë6 M
{
ëëM N
origenDatos
ëëN Y
}
ëëY Z
$str
ëëZ i
"
ëëi j
)
ëëj k
;
ëëk l
}
íí 
using
îî 
var
îî 

connection
îî $
=
îî% &
createConnection
îî' 7
(
îî7 8
connectionString
îî8 H
)
îîH I
;
îîI J

connection
ïï 
.
ïï 
Open
ïï 
(
ïï  
)
ïï  !
;
ïï! "
string
òò 
escapedVista
òò #
=
òò$ %
origenDatos
òò& 1
.
òò1 2
ToUpper
òò2 9
(
òò9 :
)
òò: ;
switch
òò< B
{
ôô 
$str
öö 
=>
öö  "
$"
öö# %
$str
öö% &
{
öö& '
vista
öö' ,
}
öö, -
$str
öö- .
"
öö. /
,
öö/ 0
$str
õõ 
=>
õõ 
$"
õõ !
$str
õõ! "
{
õõ" #
vista
õõ# (
}
õõ( )
$str
õõ) *
"
õõ* +
,
õõ+ ,
$str
úú 
=>
úú !
$"
úú" $
$str
úú$ &
{
úú& '
vista
úú' ,
}
úú, -
$str
úú- /
"
úú/ 0
,
úú0 1
$str
ùù 
=>
ùù  
$"
ùù! #
$str
ùù# %
{
ùù% &
vista
ùù& +
}
ùù+ ,
$str
ùù, .
"
ùù. /
,
ùù/ 0
_
ûû 
=>
ûû 
throw
ûû 
new
ûû "#
NotSupportedException
ûû# 8
(
ûû8 9
$"
ûû9 ;
$str
ûû; R
{
ûûR S
origenDatos
ûûS ^
}
ûû^ _
$str
ûû_ n
"
ûûn o
)
ûûo p
}
üü 
;
üü 
string
°° 
escapedColumna
°° %
=
°°& '
origenDatos
°°( 3
.
°°3 4
ToUpper
°°4 ;
(
°°; <
)
°°< =
switch
°°> D
{
¢¢ 
$str
££ 
=>
££  "
$"
££# %
$str
££% &
{
££& '
columna
££' .
}
££. /
$str
££/ 0
"
££0 1
,
££1 2
$str
§§ 
=>
§§ 
$"
§§ !
$str
§§! "
{
§§" #
columna
§§# *
}
§§* +
$str
§§+ ,
"
§§, -
,
§§- .
$str
•• 
=>
•• !
$"
••" $
$str
••$ &
{
••& '
columna
••' .
}
••. /
$str
••/ 1
"
••1 2
,
••2 3
$str
¶¶ 
=>
¶¶  
$"
¶¶! #
$str
¶¶# %
{
¶¶% &
columna
¶¶& -
}
¶¶- .
$str
¶¶. 0
"
¶¶0 1
,
¶¶1 2
_
ßß 
=>
ßß 
throw
ßß 
new
ßß "#
NotSupportedException
ßß# 8
(
ßß8 9
$"
ßß9 ;
$str
ßß; R
{
ßßR S
origenDatos
ßßS ^
}
ßß^ _
$str
ßß_ n
"
ßßn o
)
ßßo p
}
®® 
;
®® 
string
´´ 
query
´´ 
=
´´ 
origenDatos
´´ *
.
´´* +
ToUpper
´´+ 2
(
´´2 3
)
´´3 4
switch
´´5 ;
{
¨¨ 
$str
≠≠ 
=>
≠≠  "
$"
≠≠# %
$str
≠≠% 2
{
≠≠2 3
escapedColumna
≠≠3 A
}
≠≠A B
$str
≠≠B H
{
≠≠H I
escapedVista
≠≠I U
}
≠≠U V
"
≠≠V W
,
≠≠W X
$str
ÆÆ 
=>
ÆÆ 
$"
ÆÆ !
$str
ÆÆ! (
{
ÆÆ( )
escapedColumna
ÆÆ) 7
}
ÆÆ7 8
$str
ÆÆ8 >
{
ÆÆ> ?
escapedVista
ÆÆ? K
}
ÆÆK L
$str
ÆÆL T
"
ÆÆT U
,
ÆÆU V
$str
ØØ 
=>
ØØ !
$"
ØØ" $
$str
ØØ$ +
{
ØØ+ ,
escapedColumna
ØØ, :
}
ØØ: ;
$str
ØØ; A
{
ØØA B
escapedVista
ØØB N
}
ØØN O
$str
ØØO W
"
ØØW X
,
ØØX Y
$str
∞∞ 
=>
∞∞  
$"
∞∞! #
$str
∞∞# *
{
∞∞* +
escapedColumna
∞∞+ 9
}
∞∞9 :
$str
∞∞: @
{
∞∞@ A
escapedVista
∞∞A M
}
∞∞M N
$str
∞∞N V
"
∞∞V W
,
∞∞W X
_
±± 
=>
±± 
throw
±± 
new
±± "#
NotSupportedException
±±# 8
(
±±8 9
$"
±±9 ;
$str
±±; R
{
±±R S
origenDatos
±±S ^
}
±±^ _
$str
±±_ n
"
±±n o
)
±±o p
}
≤≤ 
;
≤≤ 
await
µµ 

connection
µµ  
.
µµ  !

QueryAsync
µµ! +
(
µµ+ ,
query
µµ, 1
)
µµ1 2
;
µµ2 3
return
∏∏ 
true
∏∏ 
;
∏∏ 
}
ππ 
catch
∫∫ 
(
∫∫ 
	Exception
∫∫ 
ex
∫∫ 
)
∫∫  
{
ªª 
Console
ºº 
.
ºº 
	WriteLine
ºº !
(
ºº! "
$"
ºº" $
$str
ºº$ A
{
ººA B
columna
ººB I
}
ººI J
$str
ººJ Y
{
ººY Z
vista
ººZ _
}
ºº_ `
$str
ºº` c
{
ººc d
ex
ººd f
.
ººf g
Message
ººg n
}
ººn o
"
ººo p
)
ººp q
;
ººq r
return
ΩΩ 
false
ΩΩ 
;
ΩΩ 
}
ææ 
}
øø 	
public
¬¬ 
async
¬¬ 
Task
¬¬ 
<
¬¬ 
bool
¬¬ 
>
¬¬ (
ProcesarVistaConDatosAsync
¬¬  :
(
¬¬: ;
string
¬¬; A
connectionString
¬¬B R
,
¬¬R S
string
¬¬T Z
origenDatos
¬¬[ f
,
¬¬f g
string
¬¬h n
vista
¬¬o t
,
¬¬t u
List
¬¬v z
<
¬¬z {"
EsquemaVistaColumna¬¬{ é
>¬¬é è
columnas¬¬ê ò
,¬¬ò ô
int¬¬ö ù
idEsquemaVista¬¬û ¨
,¬¬¨ ≠
int¬¬Æ ±
idONA¬¬≤ ∑
)¬¬∑ ∏
{
√√ 	
try
ƒƒ 
{
≈≈ 
if
«« 
(
«« 
origenDatos
«« 
.
««  
ToUpper
««  '
(
««' (
)
««( )
==
««* ,
$str
««- 4
&&
««5 7
idONA
««8 =
==
««> @
$num
««A B
)
««B C
{
»» 
connectionString
…… $
+=
……% '
$str
……( Z
;
……Z [
}
   
var
ÕÕ !
connectionFactories
ÕÕ '
=
ÕÕ( )
new
ÕÕ* -

Dictionary
ÕÕ. 8
<
ÕÕ8 9
string
ÕÕ9 ?
,
ÕÕ? @
Func
ÕÕA E
<
ÕÕE F
string
ÕÕF L
,
ÕÕL M
IDbConnection
ÕÕN [
>
ÕÕ[ \
>
ÕÕ\ ]
{
ŒŒ 
{
œœ 
$str
œœ !
,
œœ! "
connStr
œœ# *
=>
œœ+ -
new
œœ. 1
SqlConnection
œœ2 ?
(
œœ? @
connStr
œœ@ G
)
œœG H
}
œœI J
,
œœJ K
{
–– 
$str
–– 
,
–– 
connStr
–– &
=>
––' )
new
––* -
MySql
––. 3
.
––3 4
Data
––4 8
.
––8 9
MySqlClient
––9 D
.
––D E
MySqlConnection
––E T
(
––T U
connStr
––U \
)
––\ ]
}
––^ _
,
––_ `
{
—— 
$str
——  
,
——  !
connStr
——" )
=>
——* ,
new
——- 0
Npgsql
——1 7
.
——7 8
NpgsqlConnection
——8 H
(
——H I
connStr
——I P
)
——P Q
}
——R S
,
——S T
{
““ 
$str
““ 
,
““  
connStr
““! (
=>
““) +
new
““, /
	Microsoft
““0 9
.
““9 :
Data
““: >
.
““> ?
Sqlite
““? E
.
““E F
SqliteConnection
““F V
(
““V W
connStr
““W ^
)
““^ _
}
““` a
}
”” 
;
”” 
if
’’ 
(
’’ 
!
’’ !
connectionFactories
’’ (
.
’’( )
TryGetValue
’’) 4
(
’’4 5
origenDatos
’’5 @
.
’’@ A
ToUpper
’’A H
(
’’H I
)
’’I J
,
’’J K
out
’’L O
var
’’P S
createConnection
’’T d
)
’’d e
)
’’e f
{
÷÷ 
throw
◊◊ 
new
◊◊ #
NotSupportedException
◊◊ 3
(
◊◊3 4
$"
◊◊4 6
$str
◊◊6 M
{
◊◊M N
origenDatos
◊◊N Y
}
◊◊Y Z
$str
◊◊Z i
"
◊◊i j
)
◊◊j k
;
◊◊k l
}
ÿÿ 
using
⁄⁄ 
var
⁄⁄ 

connection
⁄⁄ $
=
⁄⁄% &
createConnection
⁄⁄' 7
(
⁄⁄7 8
connectionString
⁄⁄8 H
)
⁄⁄H I
;
⁄⁄I J

connection
€€ 
.
€€ 
Open
€€ 
(
€€  
)
€€  !
;
€€! "
var
ﬁﬁ 
columnasQuery
ﬁﬁ !
=
ﬁﬁ" #
string
ﬁﬁ$ *
.
ﬁﬁ* +
Join
ﬁﬁ+ /
(
ﬁﬁ/ 0
$str
ﬁﬁ0 4
,
ﬁﬁ4 5
columnas
ﬁﬁ6 >
.
ﬁﬁ> ?
Select
ﬁﬁ? E
(
ﬁﬁE F
c
ﬁﬁF G
=>
ﬁﬁH J
{
ﬂﬂ 
var
‡‡ 
colName
‡‡ 
=
‡‡  !
c
‡‡" #
.
‡‡# $
ColumnaVista
‡‡$ 0
;
‡‡0 1
return
‚‚ 
origenDatos
‚‚ &
.
‚‚& '
ToUpper
‚‚' .
(
‚‚. /
)
‚‚/ 0
switch
‚‚1 7
{
„„ 
$str
‰‰ #
=>
‰‰$ &
$"
‰‰' )
$str
‰‰) 1
{
‰‰1 2
colName
‰‰2 9
}
‰‰9 :
$str
‰‰: E
{
‰‰E F
colName
‰‰F M
}
‰‰M N
$str
‰‰N O
"
‰‰O P
,
‰‰P Q
$str
ÂÂ 
=>
ÂÂ  "
$"
ÂÂ# %
$str
ÂÂ% -
{
ÂÂ- .
colName
ÂÂ. 5
}
ÂÂ5 6
$str
ÂÂ6 A
{
ÂÂA B
colName
ÂÂB I
}
ÂÂI J
$str
ÂÂJ K
"
ÂÂK L
,
ÂÂL M
$str
ÊÊ "
=>
ÊÊ# %
$"
ÊÊ& (
$str
ÊÊ( 3
{
ÊÊ3 4
colName
ÊÊ4 ;
}
ÊÊ; <
$str
ÊÊ< I
{
ÊÊI J
colName
ÊÊJ Q
}
ÊÊQ R
$str
ÊÊR T
"
ÊÊT U
,
ÊÊU V
$str
ÁÁ !
=>
ÁÁ" $
$"
ÁÁ% '
$str
ÁÁ' /
{
ÁÁ/ 0
colName
ÁÁ0 7
}
ÁÁ7 8
$str
ÁÁ8 C
{
ÁÁC D
colName
ÁÁD K
}
ÁÁK L
$str
ÁÁL M
"
ÁÁM N
,
ÁÁN O
_
ËË 
=>
ËË 
colName
ËË $
}
ÈÈ 
;
ÈÈ 
}
ÍÍ 
)
ÍÍ 
)
ÍÍ 
;
ÍÍ 
var
ÏÏ 
query
ÏÏ 
=
ÏÏ 
$"
ÏÏ 
$str
ÏÏ %
{
ÏÏ% &
columnasQuery
ÏÏ& 3
}
ÏÏ3 4
$str
ÏÏ4 :
{
ÏÏ: ;
vista
ÏÏ; @
}
ÏÏ@ A
"
ÏÏA B
;
ÏÏB C
var
ÔÔ 
filas
ÔÔ 
=
ÔÔ 
(
ÔÔ 
await
ÔÔ "

connection
ÔÔ# -
.
ÔÔ- .

QueryAsync
ÔÔ. 8
(
ÔÔ8 9
query
ÔÔ9 >
)
ÔÔ> ?
)
ÔÔ? @
.
ÔÔ@ A
ToList
ÔÔA G
(
ÔÔG H
)
ÔÔH I
;
ÔÔI J
if
ÒÒ 
(
ÒÒ 
!
ÒÒ 
filas
ÒÒ 
.
ÒÒ 
Any
ÒÒ 
(
ÒÒ 
)
ÒÒ  
)
ÒÒ  !
{
ÚÚ 
Console
ÛÛ 
.
ÛÛ 
	WriteLine
ÛÛ %
(
ÛÛ% &
$"
ÛÛ& (
$str
ÛÛ( 2
{
ÛÛ2 3
vista
ÛÛ3 8
}
ÛÛ8 9
$str
ÛÛ9 M
"
ÛÛM N
)
ÛÛN O
;
ÛÛO P
return
ÙÙ 
false
ÙÙ  
;
ÙÙ  !
}
ıı 
foreach
¯¯ 
(
¯¯ 
var
¯¯ 
fila
¯¯ !
in
¯¯" $
filas
¯¯% *
)
¯¯* +
{
˘˘ 
var
˚˚ 
dataEsquemaJson
˚˚ '
=
˚˚( )
columnas
˚˚* 2
.
¸¸ 
Select
¸¸ 
(
¸¸  
col
¸¸  #
=>
¸¸$ &
{
˝˝ 
var
˛˛ 
diccionarioFila
˛˛  /
=
˛˛0 1
(
˛˛2 3
IDictionary
˛˛3 >
<
˛˛> ?
string
˛˛? E
,
˛˛E F
object
˛˛G M
>
˛˛M N
)
˛˛N O
fila
˛˛O S
;
˛˛S T
return
ˇˇ "
new
ˇˇ# &
{
ÄÄ 
IdHomologacion
ÅÅ  .
=
ÅÅ/ 0
col
ÅÅ1 4
.
ÅÅ4 5
ColumnaEsquemaIdH
ÅÅ5 F
,
ÅÅF G
Data
ÇÇ  $
=
ÇÇ% &
diccionarioFila
ÇÇ' 6
.
ÇÇ6 7
ContainsKey
ÇÇ7 B
(
ÇÇB C
col
ÇÇC F
.
ÇÇF G
ColumnaVista
ÇÇG S
)
ÇÇS T
?
ÉÉ$ %
diccionarioFila
ÉÉ& 5
[
ÉÉ5 6
col
ÉÉ6 9
.
ÉÉ9 :
ColumnaVista
ÉÉ: F
]
ÉÉF G
?
ÉÉG H
.
ÉÉH I
ToString
ÉÉI Q
(
ÉÉQ R
)
ÉÉR S
:
ÑÑ$ %
null
ÑÑ& *
}
ÖÖ 
;
ÖÖ 
}
ÜÜ 
)
ÜÜ 
.
áá 
ToList
áá 
(
áá  
)
áá  !
;
áá! "
var
ââ 
json
ââ 
=
ââ 
JsonConvert
ââ *
.
ââ* +
SerializeObject
ââ+ :
(
ââ: ;
dataEsquemaJson
ââ; J
)
ââJ K
;
ââK L
var
åå 
esquemaData
åå #
=
åå$ %
new
åå& )
EsquemaData
åå* 5
{
çç 
IdEsquemaVista
éé &
=
éé' (
idEsquemaVista
éé) 7
,
éé7 8
DataEsquemaJson
èè '
=
èè( )
json
èè* .
,
èè. /
	DataFecha
êê !
=
êê" #
DateTime
êê$ ,
.
êê, -
Now
êê- 0
}
ëë 
;
ëë 
_repositoryDLO
ìì "
.
ìì" #
Create
ìì# )
(
ìì) *
esquemaData
ìì* 5
)
ìì5 6
;
ìì6 7
var
îî 
idEsquemaData
îî %
=
îî& '
esquemaData
îî( 3
.
îî3 4
IdEsquemaData
îî4 A
;
îîA B
var
óó 
homologacion
óó $
=
óó% &
_repositoryH
óó' 3
.
óó3 4
	FindByAll
óó4 =
(
óó= >
)
óó> ?
.
òò 
Where
òò 
(
òò 
x
òò  
=>
òò! #
x
òò$ %
.
òò% &
Indexar
òò& -
==
òò. 0
$str
òò1 4
&&
òò5 7
x
òò8 9
.
òò9 :!
IdHomologacionGrupo
òò: M
==
òòN P
$num
òòQ R
)
òòR S
.
ôô 
Select
ôô 
(
ôô  
x
ôô  !
=>
ôô" $
x
ôô% &
.
ôô& '
IdHomologacion
ôô' 5
)
ôô5 6
.
öö 
	ToHashSet
öö "
(
öö" #
)
öö# $
;
öö$ %
var
ùù 
columnasFiltradas
ùù )
=
ùù* +
columnas
ùù, 4
.
ûû 
Where
ûû 
(
ûû 
col
ûû "
=>
ûû# %
homologacion
ûû& 2
.
ûû2 3
Contains
ûû3 ;
(
ûû; <
col
ûû< ?
.
ûû? @
ColumnaEsquemaIdH
ûû@ Q
)
ûûQ R
)
ûûR S
.
üü 
ToList
üü 
(
üü  
)
üü  !
;
üü! "
foreach
¢¢ 
(
¢¢ 
var
¢¢  
col
¢¢! $
in
¢¢% '
columnasFiltradas
¢¢( 9
)
¢¢9 :
{
££ 
var
•• 
diccionarioFila
•• +
=
••, -
(
••. /
IDictionary
••/ :
<
••: ;
string
••; A
,
••A B
object
••C I
>
••I J
)
••J K
fila
••K O
;
••O P
var
ßß 
esquemaFullText
ßß +
=
ßß, -
new
ßß. 1
EsquemaFullText
ßß2 A
{
®® 
IdEsquemaData
©© )
=
©©* +
idEsquemaData
©©, 9
,
©©9 :
IdHomologacion
™™ *
=
™™+ ,
col
™™- 0
.
™™0 1
ColumnaEsquemaIdH
™™1 B
,
™™B C
FullTextData
´´ (
=
´´) *
diccionarioFila
´´+ :
.
´´: ;
ContainsKey
´´; F
(
´´F G
col
´´G J
.
´´J K
ColumnaVista
´´K W
)
´´W X
?
¨¨  !
diccionarioFila
¨¨" 1
[
¨¨1 2
col
¨¨2 5
.
¨¨5 6
ColumnaVista
¨¨6 B
]
¨¨B C
?
¨¨C D
.
¨¨D E
ToString
¨¨E M
(
¨¨M N
)
¨¨N O
:
≠≠  !
null
≠≠" &
}
ÆÆ 
;
ÆÆ 
_repositoryOFT
ØØ &
.
ØØ& '
Create
ØØ' -
(
ØØ- .
esquemaFullText
ØØ. =
)
ØØ= >
;
ØØ> ?
}
∞∞ 
}
±± 
return
≥≥ 
true
≥≥ 
;
≥≥ 
}
¥¥ 
catch
µµ 
(
µµ 
	Exception
µµ 
ex
µµ 
)
µµ  
{
∂∂ 
Console
∑∑ 
.
∑∑ 
	WriteLine
∑∑ !
(
∑∑! "
$"
∑∑" $
$str
∑∑$ M
{
∑∑M N
vista
∑∑N S
}
∑∑S T
$str
∑∑T W
{
∑∑W X
ex
∑∑X Z
.
∑∑Z [
Message
∑∑[ b
}
∑∑b c
"
∑∑c d
)
∑∑d e
;
∑∑e f
var
∏∏ 
data
∏∏ 
=
∏∏ 
new
∏∏ 
LogMigracion
∏∏ +
{
ππ 
IdONA
∫∫ 
=
∫∫ 
idONA
∫∫ !
,
∫∫! "
OrigenDatos
ªª 
=
ªª  !
origenDatos
ªª" -
,
ªª- .
Observacion
ºº 
=
ºº  !
$str
ºº" L
+
ººM N
vista
ººO T
+
ººU V
$str
ººW d
+
ººe f
ex
ººg i
.
ººi j
Message
ººj q
}
ΩΩ 
;
ΩΩ 
return
ææ 
false
ææ 
;
ææ 
}
øø 
}
¿¿ 	
public
¬¬ 
bool
¬¬ )
TestDatabaseConnectionAsync
¬¬ /
(
¬¬/ 0
string
¬¬0 6
connectionString
¬¬7 G
,
¬¬G H
string
¬¬I O
origenDatos
¬¬P [
)
¬¬[ \
{
√√ 	
try
ƒƒ 
{
≈≈ 
var
«« !
connectionFactories
«« '
=
««( )
new
««* -

Dictionary
««. 8
<
««8 9
string
««9 ?
,
««? @
Func
««A E
<
««E F
string
««F L
,
««L M
IDbConnection
««N [
>
««[ \
>
««\ ]
{
»» 
{
…… 
$str
…… !
,
……! "
connStr
……# *
=>
……+ -
new
……. 1
SqlConnection
……2 ?
(
……? @
connStr
……@ G
)
……G H
}
……I J
,
……J K
{
   
$str
   
,
   
connStr
   &
=>
  ' )
new
  * -
MySql
  . 3
.
  3 4
Data
  4 8
.
  8 9
MySqlClient
  9 D
.
  D E
MySqlConnection
  E T
(
  T U
connStr
  U \
)
  \ ]
}
  ^ _
,
  _ `
{
ÀÀ 
$str
ÀÀ  
,
ÀÀ  !
connStr
ÀÀ" )
=>
ÀÀ* ,
new
ÀÀ- 0
NpgsqlConnection
ÀÀ1 A
(
ÀÀA B
connStr
ÀÀB I
)
ÀÀI J
}
ÀÀK L
,
ÀÀL M
{
ÃÃ 
$str
ÃÃ 
,
ÃÃ  
connStr
ÃÃ! (
=>
ÃÃ) +
new
ÃÃ, /
SQLiteConnection
ÃÃ0 @
(
ÃÃ@ A
connStr
ÃÃA H
)
ÃÃH I
}
ÃÃJ K
}
ÕÕ 
;
ÕÕ 
if
œœ 
(
œœ !
connectionFactories
œœ '
.
œœ' (
TryGetValue
œœ( 3
(
œœ3 4
origenDatos
œœ4 ?
.
œœ? @
ToUpper
œœ@ G
(
œœG H
)
œœH I
,
œœI J
out
œœK N
var
œœO R
createConnection
œœS c
)
œœc d
)
œœd e
{
–– 
using
—— 
var
—— 

connection
—— (
=
——) *
createConnection
——+ ;
(
——; <
connectionString
——< L
)
——L M
;
——M N

connection
““ 
.
““ 
Open
““ #
(
““# $
)
““$ %
;
““% &
if
‘‘ 
(
‘‘ 

connection
‘‘ "
.
‘‘" #
State
‘‘# (
==
‘‘) +
ConnectionState
‘‘, ;
.
‘‘; <
Open
‘‘< @
)
‘‘@ A
{
’’ 
Console
÷÷ 
.
÷÷  
	WriteLine
÷÷  )
(
÷÷) *
$str
÷÷* O
)
÷÷O P
;
÷÷P Q
return
◊◊ 
true
◊◊ #
;
◊◊# $
}
ÿÿ 
else
ŸŸ 
{
⁄⁄ 
Console
€€ 
.
€€  
	WriteLine
€€  )
(
€€) *
$str
€€* I
)
€€I J
;
€€J K
return
‹‹ 
false
‹‹ $
;
‹‹$ %
}
›› 
}
ﬁﬁ 
else
ﬂﬂ 
{
‡‡ 
throw
·· 
new
·· #
NotSupportedException
·· 3
(
··3 4
$"
··4 6
$str
··6 M
{
··M N
origenDatos
··N Y
}
··Y Z
$str
··Z i
"
··i j
)
··j k
;
··k l
}
‚‚ 
}
„„ 
catch
‰‰ 
(
‰‰ 
	Exception
‰‰ 
ex
‰‰ 
)
‰‰  
{
ÂÂ 
Console
ÊÊ 
.
ÊÊ 
	WriteLine
ÊÊ !
(
ÊÊ! "
$"
ÊÊ" $
$str
ÊÊ$ A
{
ÊÊA B
ex
ÊÊB D
.
ÊÊD E
Message
ÊÊE L
}
ÊÊL M
"
ÊÊM N
)
ÊÊN O
;
ÊÊO P
return
ÁÁ 
false
ÁÁ 
;
ÁÁ 
}
ËË 
}
ÈÈ 	
}
ÎÎ 
}ÏÏ Æ
LC:\Users\Dell\source\repos\BuscadorCan\Core\Service\MigracionExcelService.cs
	namespace 	
Core
 
. 
Service 
{ 
public 

class !
MigracionExcelService &
:& '"
IMigracionExcelService( >
{ 
private		 
readonly		 %
IMigracionExcelRepository		 2%
_migracionExcelRepository		3 L
;		L M
public !
MigracionExcelService $
($ %%
IMigracionExcelRepository% >$
migracionExcelRepository? W
)W X
{ 	
this 
. %
_migracionExcelRepository *
=+ ,$
migracionExcelRepository- E
;E F
} 	
public 
LogMigracion 
Create "
(" #
LogMigracion# /
data0 4
)4 5
{ 	
return %
_migracionExcelRepository ,
., -
Create- 3
(3 4
data4 8
)8 9
;9 :
} 	
public 
Task 
< 
LogMigracion  
>  !
CreateAsync" -
(- .
LogMigracion. :
data; ?
)? @
{ 	
return %
_migracionExcelRepository ,
., -
CreateAsync- 8
(8 9
data9 =
)= >
;> ?
} 	
public 
List 
< 
MigracionExcel "
>" #
FindAll$ +
(+ ,
), -
{ 	
return %
_migracionExcelRepository ,
., -
FindAll- 4
(4 5
)5 6
;6 7
} 	
public 
MigracionExcel 
? 
FindById '
(' (
int( +
Id, .
). /
{   	
return!! %
_migracionExcelRepository!! ,
.!!, -
FindById!!- 5
(!!5 6
Id!!6 8
)!!8 9
;!!9 :
}"" 	
public$$ 
bool$$ 
Update$$ 
($$ 
LogMigracion$$ '
data$$( ,
)$$, -
{%% 	
return&& %
_migracionExcelRepository&& ,
.&&, -
Update&&- 3
(&&3 4
data&&4 8
)&&8 9
;&&9 :
}'' 	
public)) 
Task)) 
<)) 
bool)) 
>)) 
UpdateAsync)) %
())% &
LogMigracion))& 2
data))3 7
)))7 8
{** 	
return++ %
_migracionExcelRepository++ ,
.++, -
UpdateAsync++- 8
(++8 9
data++9 =
)++= >
;++> ?
},, 	
}-- 
}.. ö+
BC:\Users\Dell\source\repos\BuscadorCan\Core\Service\MenuService.cs
	namespace 	
Core
 
. 
Service 
{ 
public		 

class		 
MenuService		 
:		 
IMenuService		 *
{

 
private 
readonly 
IMenuRepository (
_menuRepository) 8
;8 9
private 
readonly 
IMapper  
mapper! '
;' (
public 
MenuService 
( 
IMenuRepository *
menuRepository+ 9
,9 :
IMapper; B
mapperC I
)I J
{ 	
this 
. 
_menuRepository  
=! "
menuRepository# 1
;1 2
this 
. 
mapper 
= 
mapper  
;  !
} 	
public 
bool 
Create 
( 

MenuRolDto %
data& *
)* +
{ 	
MenuRol 
menuRol 
= 
mapper $
.$ %
Map% (
<( )
MenuRol) 0
>0 1
(1 2
data2 6
)6 7
;7 8
return 
_menuRepository "
." #
Create# )
() *
menuRol* 1
)1 2
;2 3
} 	
public 
List 
< 

MenuRolDto 
> 
FindAll  '
(' (
)( )
{ 	
List 
< 
Menus 
> 
menus 
= 
_menuRepository  /
./ 0
FindAll0 7
(7 8
)8 9
;9 :
return 
mapper 
. 
Map 
< 
List "
<" #

MenuRolDto# -
>- .
>. /
(/ 0
menus0 5
)5 6
;6 7
} 	
public 

MenuRolDto 
? 
FindById #
(# $
int$ '
idHRol( .
,. /
int0 3
idHMenu4 ;
); <
{   	
MenuRol!! 
?!! 
menuRol!! 
=!! 
_menuRepository!! -
.!!- .
FindById!!. 6
(!!6 7
idHRol!!7 =
,!!= >
idHMenu!!? F
)!!F G
;!!G H
return"" 
mapper"" 
."" 
Map"" 
<"" 

MenuRolDto"" (
>""( )
("") *
menuRol""* 1
)""1 2
;""2 3
}## 	
public%% 

MenuRolDto%% 
?%% 
FindDataById%% '
(%%' (
int%%( +
idHRol%%, 2
,%%2 3
int%%4 7
idHMenu%%8 ?
)%%? @
{&& 	
Menus'' 
?'' 
menuRol'' 
='' 
_menuRepository'' ,
.'', -
FindDataById''- 9
(''9 :
idHRol'': @
,''@ A
idHMenu''B I
)''I J
;''J K
return(( 
mapper(( 
.(( 
Map(( 
<(( 

MenuRolDto(( (
>((( )
((() *
menuRol((* 1
)((1 2
;((2 3
})) 	
public++ 
List++ 
<++ 

MenuRolDto++ 
>++ 
GetListByMenusAsync++  3
(++3 4
int++4 7
idHRol++8 >
,++> ?
int++@ C
idHMenu++D K
)++K L
{,, 	
List-- 
<-- 
Menus-- 
>-- 
menus-- 
=-- 
_menuRepository-- .
.--. /
GetListByMenusAsync--/ B
(--B C
idHRol--C I
,--I J
idHMenu--K R
)--R S
;--S T
return.. 
mapper.. 
... 
Map.. 
<.. 
List.. "
<.." #

MenuRolDto..# -
>..- .
>... /
(../ 0
menus..0 5
)..5 6
;..6 7
}// 	
public11 
List11 
<11 
MenuPaginaDto11 !
>11! "%
ObtenerMenusPendingConfig11# <
(11< =
int11= @
idHomologacionRol11A R
)11R S
{22 	
List33 
<33 

MenuPagina33 
>33 
menuPaginas33 '
=33( )
_menuRepository33* 9
.339 :%
ObtenerMenusPendingConfig33: S
(33S T
idHomologacionRol33T e
)33e f
;33f g
return44 
mapper44 
.44 
Map44 
<44 
List44 "
<44" #
MenuPaginaDto44# 0
>440 1
>441 2
(442 3
menuPaginas443 >
)44> ?
;44? @
}55 	
public77 
bool77 
Update77 
(77 

MenuRolDto77 %
data77& *
)77* +
{88 	
MenuRol99 
menuRol99 
=99 
mapper99 $
.99$ %
Map99% (
<99( )
MenuRol99) 0
>990 1
(991 2
data992 6
)996 7
;997 8
return:: 
_menuRepository:: !
.::! "
Update::" (
(::( )
menuRol::) 0
)::0 1
;::1 2
};; 	
}<< 
}== ∆
FC:\Users\Dell\source\repos\BuscadorCan\Core\Service\Md5HashStrategy.cs
public 
class 
Md5HashStrategy 
: 
IHashStrategy ,
{ 
public 

string 
ComputeHash 
( 
string $
?$ %
input& +
)+ ,
{ 
using		 
(		 
MD5		 
md5		 
=		 
MD5		 
.		 
Create		 #
(		# $
)		$ %
)		% &
{

 	
byte 
[ 
] 
data 
= 
Encoding "
." #
UTF8# '
.' (
GetBytes( 0
(0 1
input1 6
??7 9
$str: <
)< =
;= >
byte 
[ 
] 
hash 
= 
md5 
. 
ComputeHash )
() *
data* .
). /
;/ 0
StringBuilder 
sb 
= 
new "
StringBuilder# 0
(0 1
)1 2
;2 3
for 
( 
int 
i 
= 
$num 
; 
i 
< 
hash  $
.$ %
Length% +
;+ ,
i- .
++. 0
)0 1
{ 
sb 
. 
Append 
( 
hash 
[ 
i  
]  !
.! "
ToString" *
(* +
$str+ /
)/ 0
)0 1
;1 2
} 
return 
sb 
. 
ToString 
( 
)  
;  !
} 	
} 
} ß$
JC:\Users\Dell\source\repos\BuscadorCan\Core\Service\LogMigracionService.cs
	namespace 	
Core
 
. 
Service 
{ 
public 

class 
LogMigracionService $
:% & 
ILogMigracionService' ;
{ 
private		 
readonly		 #
ILogMigracionRepository		 0#
_logMigracionRepository		1 H
;		H I
public 
LogMigracionService "
(" ##
ILogMigracionRepository# :"
logMigracionRepository; Q
)Q R
{ 	
this 
. #
_logMigracionRepository (
=) *"
logMigracionRepository+ A
;A B
} 	
public 
LogMigracion 
Create "
(" #
LogMigracion# /
data0 4
)4 5
{ 	
return #
_logMigracionRepository )
.) *
Create* 0
(0 1
data1 5
)5 6
;6 7
} 	
public 
Task 
< 
LogMigracion  
>  !
CreateAsync" -
(- .
LogMigracion. :
data; ?
)? @
{ 	
return #
_logMigracionRepository )
.) *
CreateAsync* 5
(5 6
data6 :
): ;
;; <
} 	
public 
LogMigracionDetalle "
CreateDetalle# 0
(0 1
LogMigracionDetalle1 D
dataE I
)I J
{ 	
return #
_logMigracionRepository )
.) *
CreateDetalle* 7
(7 8
data8 <
)< =
;= >
} 	
public 
Task 
< 
LogMigracionDetalle '
>' (
CreateDetalleAsync) ;
(; <
LogMigracionDetalle< O
dataP T
)T U
{   	
return!! #
_logMigracionRepository!! )
.!!) *
CreateDetalleAsync!!* <
(!!< =
data!!= A
)!!A B
;!!B C
}"" 	
public$$ 
List$$ 
<$$ 
LogMigracion$$  
>$$  !
FindAll$$" )
($$) *
)$$* +
{%% 	
return&& #
_logMigracionRepository&& )
.&&) *
FindAll&&* 1
(&&1 2
)&&2 3
;&&3 4
}'' 	
public)) 
List)) 
<)) 
LogMigracionDetalle)) '
>))' (
FindAllDetalle))) 7
())7 8
)))8 9
{** 	
return++ #
_logMigracionRepository++ )
.++) *
FindAllDetalle++* 8
(++8 9
)++9 :
;++: ;
},, 	
public.. 
LogMigracion.. 
?.. 
FindById.. %
(..% &
int..& )
Id..* ,
).., -
{// 	
return00 #
_logMigracionRepository00 )
.00) *
FindById00* 2
(002 3
Id003 5
)005 6
;006 7
}11 	
public33 
List33 
<33 
LogMigracionDetalle33 '
>33' (
FindDetalleById33) 8
(338 9
int339 <
Id33= ?
)33? @
{44 	
return55 #
_logMigracionRepository55 )
.55) *
FindDetalleById55* 9
(559 :
Id55: <
)55< =
;55= >
}66 	
public88 
bool88 
Update88 
(88 
LogMigracion88 '
data88( ,
)88, -
{99 	
return:: #
_logMigracionRepository:: )
.::) *
Update::* 0
(::0 1
data::1 5
)::5 6
;::6 7
};; 	
public== 
Task== 
<== 
bool== 
>== 
UpdateAsync== %
(==% &
LogMigracion==& 2
data==3 7
)==7 8
{>> 	
return?? #
_logMigracionRepository?? )
.??) *
UpdateAsync??* 5
(??5 6
data??6 :
)??: ;
;??; <
}@@ 	
publicBB 
boolBB 
UpdateDetalleBB !
(BB! "
LogMigracionDetalleBB" 5
dataBB6 :
)BB: ;
{CC 	
returnDD #
_logMigracionRepositoryDD )
.DD) *
UpdateDetalleDD* 7
(DD7 8
dataDD8 <
)DD< =
;DD= >
}EE 	
}FF 
}GG ı0
AC:\Users\Dell\source\repos\BuscadorCan\Core\Service\JwtService.cs
	namespace 	
Core
 
. 
Services 
{ 
public 

class 

JwtService 
( 
IConfiguration		 
configuration		 $
,		$ % 
IHttpContextAccessor

 
httpContextAccessor

 0
,

0 1
IJwtFactory 

jwtFactory 
) 
: 
IJwtService 
{ 
private 
readonly 
IConfiguration '
_configuration( 6
=7 8
configuration9 F
;F G
private 
readonly  
IHttpContextAccessor - 
_httpContextAccessor. B
=C D
httpContextAccessorE X
;X Y
private 
readonly 
IJwtFactory $
_jwtFactory% 0
=1 2

jwtFactory3 =
;= >
public 
string 
GenerateJwtToken &
(& '
int' *
userId+ 1
)1 2
{ 	
var 
secret 
= 
_configuration '
.' (
GetValue( 0
<0 1
string1 7
>7 8
(8 9
$str9 N
)N O
;O P
var 
tokenHandler 
= 
_jwtFactory *
.* +
CreateTokenHandler+ =
(= >
)> ?
;? @
var 
signingCredentials "
=# $
_jwtFactory% 0
.0 1$
CreateSigningCredentials1 I
(I J
secretJ P
??Q S
$strT V
)V W
;W X
var 
tokenDescriptor 
=  !
new" %#
SecurityTokenDescriptor& =
{ 
Subject 
= 
new 
ClaimsIdentity ,
(, -
new- 0
Claim1 6
[6 7
]7 8
{ 
new 
Claim 
( 

ClaimTypes (
.( )
NameIdentifier) 7
,7 8
userId9 ?
.? @
ToString@ H
(H I
)I J
)J K
,K L
} 
) 
, 
Expires 
= 
DateTime "
." #
UtcNow# )
.) *
AddDays* 1
(1 2
$num2 3
)3 4
,4 5
SigningCredentials "
=# $
signingCredentials% 7
} 
; 
var!! 
token!! 
=!! 
tokenHandler!! $
.!!$ %
CreateToken!!% 0
(!!0 1
tokenDescriptor!!1 @
)!!@ A
;!!A B
return"" 
tokenHandler"" 
.""  

WriteToken""  *
(""* +
token""+ 0
)""0 1
;""1 2
}## 	
public%% 
int%% 
GetUserIdFromToken%% %
(%%% &
string%%& ,
token%%- 2
)%%2 3
{&& 	
var'' 
secret'' 
='' 
_configuration'' '
.''' (
GetValue''( 0
<''0 1
string''1 7
>''7 8
(''8 9
$str''9 N
)''N O
;''O P
var(( 
tokenHandler(( 
=(( 
_jwtFactory(( *
.((* +
CreateTokenHandler((+ =
(((= >
)((> ?
;((? @
var))  
validationParameters)) $
=))% &
_jwtFactory))' 2
.))2 3+
CreateTokenValidationParameters))3 R
())R S
secret))S Y
??))Z \
$str))] _
)))_ `
;))` a
try++ 
{,, 
SecurityToken-- 
securityToken-- +
;--+ ,
var.. 
claimsPrincipal.. #
=..$ %
tokenHandler..& 2
...2 3
ValidateToken..3 @
(..@ A
token..A F
,..F G 
validationParameters..H \
,..\ ]
out..^ a
securityToken..b o
)..o p
;..p q
var// 
userIdClaim// 
=//  !
claimsPrincipal//" 1
.//1 2
	FindFirst//2 ;
(//; <

ClaimTypes//< F
.//F G
NameIdentifier//G U
)//U V
;//V W
if11 
(11 
userIdClaim11 
!=11  "
null11# '
&&11( *
int11+ .
.11. /
TryParse11/ 7
(117 8
userIdClaim118 C
.11C D
Value11D I
,11I J
out11K N
int11O R
userId11S Y
)11Y Z
)11Z [
{22 
return33 
userId33 !
;33! "
}44 
return66 
$num66 
;66 
}77 
catch88 
(88 
	Exception88 
)88 
{99 
return:: 
$num:: 
;:: 
};; 
}<< 	
public>> 
string>> 
?>> 
GetTokenFromHeader>> )
(>>) *
)>>* +
{?? 	
var@@ 
authorizationHeader@@ #
=@@$ % 
_httpContextAccessor@@& :
.@@: ;
HttpContext@@; F
?@@F G
.@@G H
Request@@H O
.@@O P
Headers@@P W
[@@W X
$str@@X g
]@@g h
.@@h i
FirstOrDefault@@i w
(@@w x
)@@x y
;@@y z
ifAA 
(AA 
authorizationHeaderAA #
!=AA$ &
nullAA' +
&&AA, .
authorizationHeaderAA/ B
.AAB C

StartsWithAAC M
(AAM N
$strAAN W
)AAW X
)AAX Y
{BB 
returnCC 
authorizationHeaderCC *
.CC* +
	SubstringCC+ 4
(CC4 5
$strCC5 >
.CC> ?
LengthCC? E
)CCE F
.CCF G
TrimCCG K
(CCK L
)CCL M
;CCM N
}DD 
returnEE 
nullEE 
;EE 
}FF 	
}GG 
}HH è
AC:\Users\Dell\source\repos\BuscadorCan\Core\Service\JwtFactory.cs
	namespace 	
Core
 
. 
Services 
{ 
public 

class 

JwtFactory 
: 
IJwtFactory )
{ 
public		 #
JwtSecurityTokenHandler		 &
CreateTokenHandler		' 9
(		9 :
)		: ;
{

 	
return 
new #
JwtSecurityTokenHandler .
(. /
)/ 0
;0 1
} 	
public 
SigningCredentials !$
CreateSigningCredentials" :
(: ;
string; A
secretB H
)H I
{ 	
var 
key 
= 
Encoding 
. 
ASCII $
.$ %
GetBytes% -
(- .
secret. 4
)4 5
;5 6
return 
new 
SigningCredentials )
() *
new* - 
SymmetricSecurityKey. B
(B C
keyC F
)F G
,G H
SecurityAlgorithmsI [
.[ \
HmacSha256Signature\ o
)o p
;p q
} 	
public %
TokenValidationParameters (+
CreateTokenValidationParameters) H
(H I
stringI O
secretP V
)V W
{ 	
var 
key 
= 
Encoding 
. 
ASCII $
.$ %
GetBytes% -
(- .
secret. 4
)4 5
;5 6
return 
new %
TokenValidationParameters 0
{ $
ValidateIssuerSigningKey (
=) *
true+ /
,/ 0
IssuerSigningKey  
=! "
new# & 
SymmetricSecurityKey' ;
(; <
key< ?
)? @
,@ A
ValidateIssuer 
=  
false! &
,& '
ValidateAudience  
=! "
false# (
} 
; 
} 	
} 
}   ƒ
KC:\Users\Dell\source\repos\BuscadorCan\Core\Service\IpCoordinatesService.cs
	namespace 	
Core
 
. 
Service 
{ 
public

 

class

  
IpCoordinatesService

 %
:

& '!
IIpCoordinatesService

( =
{ 
private 
readonly 

HttpClient #
_httpClient$ /
;/ 0
public  
IpCoordinatesService #
(# $

HttpClient$ .

httpClient/ 9
)9 :
{ 	
_httpClient 
= 

httpClient $
??% '
throw( -
new. 1!
ArgumentNullException2 G
(G H
nameofH N
(N O

httpClientO Y
)Y Z
)Z [
;[ \
} 	
public 
async 
Task 
< 
CoordinatesDto (
>( )
GetCoordinates* 8
(8 9
string9 ?
ip@ B
)B C
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
ip* ,
), -
)- .
throw 
new 
ArgumentException +
(+ ,
$str, S
,S T
nameofU [
([ \
ip\ ^
)^ _
)_ `
;` a
try!! 
{"" 
var## 
response## 
=## 
await## $
_httpClient##% 0
.##0 1
GetAsync##1 9
(##9 :
$"##: <
$str##< S
{##S T
ip##T V
}##V W
"##W X
)##X Y
.##Y Z
ConfigureAwait##Z h
(##h i
false##i n
)##n o
;##o p
if%% 
(%% 
!%% 
response%% 
.%% 
IsSuccessStatusCode%% 1
)%%1 2
{&& 
return(( 
null(( 
;((  
})) 
return,, 
await,, 
response,, %
.,,% &
Content,,& -
.,,- .
ReadFromJsonAsync,,. ?
<,,? @
CoordinatesDto,,@ N
>,,N O
(,,O P
),,P Q
.,,Q R
ConfigureAwait,,R `
(,,` a
false,,a f
),,f g
;,,g h
}-- 
catch.. 
(..  
HttpRequestException.. '
ex..( *
)..* +
{// 
Console00 
.00 
	WriteLine00 !
(00! "
$"00" $
$str00$ @
{00@ A
ex00A C
.00C D
Message00D K
}00K L
"00L M
)00M N
;00N O
return11 
null11 
;11 
}22 
catch33 
(33 
	Exception33 
ex33 
)33  
{44 
Console55 
.55 
	WriteLine55 !
(55! "
$"55" $
$str55$ H
{55H I
ex55I K
.55K L
Message55L S
}55S T
"55T U
)55U V
;55V W
return66 
null66 
;66 
}77 
}88 	
}99 
}:: ÕR
HC:\Users\Dell\source\repos\BuscadorCan\Core\Service\ImportadorService.cs
	namespace		 	
Core		
 
.		 
Service		 
.		 
IService		 
{

 
public 

class 
ImportadorService "
:# $
IImportador% 0
{ 
private 
readonly #
IHomologacionRepository 0
_repositoryH1 =
;= >
private 
readonly 
IEsquemaRepository +
_repositoryHE, 9
;9 :
private 
readonly 
IONAConexionService ,
	_serviceC- 6
;6 7
private 
readonly 
IMapper  
mapper! '
;' (
private 
readonly 
IImportarRepository ,
importarRepository- ?
;? @
private 
int 
executionIndex "
=# $
$num% &
;& '
private 
string 
[ 
] 
views 
=  
[! "
]" #
;# $
private 
string 
[ 
] 
schemas  
=! "
[# $
]$ %
;% &
private 
string 
connectionString '
;' (
public 
ImportadorService  
(  !#
IHomologacionRepository #"
homologacionRepository$ :
,: ;
IEsquemaRepository )
homologacionEsquemaRepository <
,< =
IONAConexionService 
conexionService  /
,/ 0
IMapper 
mapper 
, 
IImportarRepository 
importarRepository  2
) 	
{ 	
_repositoryH 
= "
homologacionRepository 1
;1 2
_repositoryHE   
=   )
homologacionEsquemaRepository   9
;  9 :
	_serviceC!! 
=!! 
conexionService!! '
;!!' (
this"" 
."" 
mapper"" 
="" 
mapper""  
;""  !
this## 
.## 
importarRepository## #
=##$ %
importarRepository##& 8
;##8 9
}$$ 	
public%% 
Boolean%% 
Importar%% 
(%%  
string%%  &
[%%& '
]%%' (
vistas%%) /
)%%/ 0
{&& 	
try'' 
{(( 
List** 
<** 
ONAConexionDto** #
>**# $

conexiones**% /
=**0 1
	_serviceC**2 ;
.**; <
FindAll**< C
(**C D
)**D E
.++ 
Where++ 
(++ 
w++ 
=>++ 
!++  !
w++! "
.++" #
Migrar++# )
.++) *
Equals++* 0
(++0 1

Constantes++1 ;
.++; <
CONEXION_MIGRAR_S++< M
)++M N
)++N O
.,, 
ToList,, 
(,, 
),, 
;,, )
ConectionStringBuilderService.. -)
conectionStringBuilderService... K
=..L M
new..N Q)
ConectionStringBuilderService..R o
(..o p
)..p q
;..q r
List// 
<// 
Esquema// 
>//  
homologacionEsquemas// 2
=//3 4
_repositoryHE//5 B
.//B C
FindAllWithViews//C S
(//S T
)//T U
;//U V
HashSet00 
<00 
string00 
>00 
	DBSchemas00  )
=00* + 
homologacionEsquemas00, @
.00@ A
Select00A G
(00G H
he00H J
=>00K M
he00N P
.00P Q
EsquemaJson00Q \
)00\ ]
.00] ^
Where00^ c
(00c d
v00d e
=>00f h
v00i j
!=00k m
null00n r
)00r s
.00s t
Select00t z
(00z {
v00{ |
=>00} 
v
00Ä Å
!
00Å Ç
)
00Ç É
.
00É Ñ
	ToHashSet
00Ñ ç
(
00ç é
)
00é è
;
00è ê
if22 
(22 
	DBSchemas22 
.22 
Count22 #
>22$ %
$num22& '
)22' (
{33 
schemas44 
=44 
	DBSchemas44 '
.44' (
ToArray44( /
(44/ 0
)440 1
;441 2
}55 
foreach77 
(77 
ONAConexionDto77 '
conexion77( 0
in771 3

conexiones774 >
)77> ?
{88 
ONAConexion99 
currentConexion99  /
=990 1
mapper992 8
.998 9
Map999 <
<99< =
ONAConexion99= H
>99H I
(99I J
conexion99J R
)99R S
;99S T
connectionString:: $
=::% &)
conectionStringBuilderService::' D
.::D E!
BuildConnectionString::E Z
(::Z [
currentConexion::[ j
)::j k
;::k l
ImportarSistema;; #
(;;# $
views;;$ )
,;;) *
connectionString;;+ ;
);;; <
;;;< =
conexion<< 
.<< 
Migrar<< #
=<<$ %

Constantes<<& 0
.<<0 1
CONEXION_MIGRAR_N<<1 B
;<<B C
	_serviceC== 
.== 
Update== $
(==$ %
conexion==% -
)==- .
;==. /
}>> 
return@@ 
true@@ 
;@@ 
}AA 
catchBB 
(BB 
	ExceptionBB 
exBB 
)BB  
{CC 
ConsoleDD 
.DD 
	WriteLineDD !
(DD! "
exDD" $
.DD$ %
MessageDD% ,
)DD, -
;DD- .
returnEE 
falseEE 
;EE 
}FF 
}GG 	
publicII 
boolII 
ImportarSistemaII #
(II# $
stringII$ *
[II* +
]II+ ,
vistasII- 3
,II3 4
stringII5 ;
connectionStringII< L
)IIL M
{JJ 	
ifKK 
(KK 
connectionStringKK  
!=KK! #
nullKK$ (
)KK( )
{LL 
thisMM 
.MM 
connectionStringMM %
=MM& '
connectionStringMM( 8
;MM8 9
}NN 
boolPP 
resultPP 
=PP 
truePP 
;PP 
ifRR 
(RR 
vistasRR 
!=RR 
nullRR 
&&RR !
vistasRR" (
.RR( )
LengthRR) /
>RR0 1
$numRR2 3
)RR3 4
{SS 
viewsTT 
=TT 
vistasTT 
;TT 
}UU 
foreachWW 
(WW 
stringWW 
viewWW  
inWW! #
viewsWW$ )
)WW) *
{XX 
executionIndexYY 
=YY  
ArrayYY! &
.YY& '
IndexOfYY' .
(YY. /
viewsYY/ 4
,YY4 5
viewYY6 :
)YY: ;
;YY; <
resultZZ 
=ZZ 
resultZZ 
&&ZZ  "
LeerZZ# '
(ZZ' (
viewZZ( ,
)ZZ, -
;ZZ- .
}[[ 
return\\ 
result\\ 
;\\ 
}]] 	
public__ 
bool__ 
Leer__ 
(__ 
string__ 
viewName__  (
)__( )
{`` 	
stringaa 
currentSchemaaa  
=aa! "
schemasaa# *
[aa* +
executionIndexaa+ 9
]aa9 :
;aa: ;
JArraybb 
schemaArraybb 
=bb  
JArraybb! '
.bb' (
Parsebb( -
(bb- .
currentSchemabb. ;
)bb; <
;bb< =
intcc 
[cc 
]cc 
homologacionIdscc !
=cc" #
Arraycc$ )
.cc) *
Emptycc* /
<cc/ 0
intcc0 3
>cc3 4
(cc4 5
)cc5 6
;cc6 7
foreachee 
(ee 
JObjectee 
itemee !
inee" $
schemaArrayee% 0
)ee0 1
{ff 
intgg 
idHomologaciongg "
=gg# $
itemgg% )
.gg) *
Valuegg* /
<gg/ 0
intgg0 3
>gg3 4
(gg4 5
$strgg5 E
)ggE F
;ggF G
homologacionIdshh 
=hh  !
homologacionIdshh" 1
.hh1 2
Appendhh2 8
(hh8 9
idHomologacionhh9 G
)hhG H
.hhH I
ToArrayhhI P
(hhP Q
)hhQ R
;hhR S
}ii 
Listkk 
<kk 
Homologacionkk 
>kk 
homologacioneskk -
=kk. /
_repositoryHkk0 <
.kk< =
	FindByIdskk= F
(kkF G
homologacionIdskkG V
)kkV W
;kkW X
intll 
[ll 
]ll 
newHomologacionIdsll $
=ll% &
homologacionesll' 5
.ll5 6
Selectll6 <
(ll< =
hll= >
=>ll? A
hllB C
.llC D
IdHomologacionllD R
)llR S
.llS T
ToArrayllT [
(ll[ \
)ll\ ]
;ll] ^
stringmm 
[mm 
]mm 
newSelectFieldsmm $
=mm% &
homologacionesmm' 5
.mm5 6
Selectmm6 <
(mm< =
hmm= >
=>mm? A
hmmB C
.mmC D
NombreHomologadommD T
??mmU W
$strmmX Z
)mmZ [
.mm[ \
ToArraymm\ c
(mmc d
)mmd e
;mme f
stringoo 
selectQueryoo 
=oo  
importarRepositoryoo! 3
.oo3 4 
buildSelectViewQueryoo4 H
(ooH I
newHomologacionIdsooI [
,oo[ \
newSelectFieldsoo] l
,ool m
viewNameoon v
)oov w
;oow x
ifqq 
(qq 
selectQueryqq 
==qq 
$strqq !
)qq! "
{rr 
returnss 
falsess 
;ss 
}tt 
returnvv 
importarRepositoryvv %
.vv% &
executeQueryViewvv& 6
(vv6 7
selectQueryvv7 B
)vvB C
;vvC D
}ww 	
}xx 
}yy À,
JC:\Users\Dell\source\repos\BuscadorCan\Core\Service\HomologacionService.cs
	namespace 	
Core
 
. 
Service 
{ 
public		 

class		 
HomologacionService		 $
:		% & 
IHomologacionService		' ;
{

 
private 
readonly #
IHomologacionRepository 0#
_homologacionRepository1 H
;H I
private 
readonly 
IMapper  
mapper! '
;' (
public 
HomologacionService "
(" ##
IHomologacionRepository# :"
homologacionRepository; Q
,Q R
IMapperS Z
mapper[ a
)a b
{ 	
this 
. #
_homologacionRepository (
=) *"
homologacionRepository+ A
;A B
this 
. 
mapper 
= 
mapper  
;  !
} 	
public 
bool 
Create 
( 
HomologacionDto *
data+ /
)/ 0
{ 	
Homologacion 
homologacion %
=& '
mapper( .
.. /
Map/ 2
<2 3
Homologacion3 ?
>? @
(@ A
dataA E
)E F
;F G
return #
_homologacionRepository *
.* +
Create+ 1
(1 2
homologacion2 >
)> ?
;? @
} 	
public 
List 
< 
HomologacionDto #
># $
	FindByAll% .
(. /
)/ 0
{ 	
List 
< 
Homologacion 
> 
homologacions ,
=- .#
_homologacionRepository/ F
.F G
	FindByAllG P
(P Q
)Q R
;R S
return 
mapper 
. 
Map 
< 
List "
<" #
HomologacionDto# 2
>2 3
>3 4
(4 5
homologacions5 B
)B C
;C D
} 	
public 
HomologacionDto 
? 
FindById  (
(( )
int) ,
id- /
)/ 0
{   	
Homologacion!! 
homologacion!! %
=!!& '#
_homologacionRepository!!( ?
.!!? @
FindById!!@ H
(!!H I
id!!I K
)!!K L
;!!L M
return"" 
mapper"" 
."" 
Map"" 
<"" 
HomologacionDto"" -
>""- .
("". /
homologacion""/ ;
)""; <
;""< =
}## 	
public%% 
List%% 
<%% 
HomologacionDto%% #
>%%# $
	FindByIds%%% .
(%%. /
int%%/ 2
[%%2 3
]%%3 4
ids%%5 8
)%%8 9
{&& 	
List'' 
<'' 
Homologacion'' 
>'' 
homologacions'' ,
=''- .#
_homologacionRepository''/ F
.''F G
	FindByIds''G P
(''P Q
ids''Q T
)''T U
;''U V
return(( 
mapper(( 
.(( 
Map(( 
<(( 
List(( "
<((" #
HomologacionDto((# 2
>((2 3
>((3 4
(((4 5
homologacions((5 B
)((B C
;((C D
})) 	
public++ 
List++ 
<++ 
HomologacionDto++ #
>++# $
FindByParent++% 1
(++1 2
)++2 3
{,, 	
List-- 
<-- 
Homologacion-- 
>-- 
homologacions-- ,
=--- .#
_homologacionRepository--/ F
.--F G
FindByParent--G S
(--S T
)--T U
.--U V
ToList--V \
(--\ ]
)--] ^
;--^ _
return.. 
mapper.. 
... 
Map.. 
<.. 
List.. "
<.." #
HomologacionDto..# 2
>..2 3
>..3 4
(..4 5
homologacions..5 B
)..B C
;..C D
}// 	
public11 
List11 
<11 
VwHomologacionDto11 %
>11% &*
ObtenerVwHomologacionPorCodigo11' E
(11E F
string11F L
codigoHomologacion11M _
)11_ `
{22 	
List33 
<33 
VwHomologacion33 
>33  
homologacions33! .
=33/ 0#
_homologacionRepository331 H
.33H I*
ObtenerVwHomologacionPorCodigo33I g
(33g h
codigoHomologacion33h z
)33z {
;33{ |
return44 
mapper44 
.44 
Map44 
<44 
List44 "
<44" #
VwHomologacionDto44# 4
>444 5
>445 6
(446 7
homologacions447 D
)44D E
;44E F
}55 	
public77 
bool77 
Update77 
(77 
HomologacionDto77 *
data77+ /
)77/ 0
{88 	
Homologacion99 
homologacion99 %
=99& '
mapper99( .
.99. /
Map99/ 2
<992 3
Homologacion993 ?
>99? @
(99@ A
data99A E
)99E F
;99F G
return:: #
_homologacionRepository:: *
.::* +
Update::+ 1
(::1 2
homologacion::2 >
)::> ?
;::? @
};; 	
}<< 
}== Ã
BC:\Users\Dell\source\repos\BuscadorCan\Core\Service\HashService.cs
	namespace 	
Core
 
. 
Services 
{ 
public 

class 
HashService 
: 
Services '
.' (
IHashService( 4
{ 
private 
readonly 
Services !
.! "
IHashStrategy" /
_hashStrategy0 =
;= >
public 
HashService 
( 
Services #
.# $
IHashStrategy$ 1
hashStrategy2 >
)> ?
{		 	
_hashStrategy

 
=

 
hashStrategy

 (
;

( )
} 	
public 
string 
GenerateHash "
(" #
string# )
?) *
input+ 0
)0 1
{ 	
return 
_hashStrategy  
.  !
ComputeHash! ,
(, -
input- 2
)2 3
;3 4
} 	
} 
} .
IC:\Users\Dell\source\repos\BuscadorCan\Core\Service\GmailClientFactory.cs
	namespace 	
Core
 
. 
Services 
{		 
public 

class 
GmailClientFactory #
:$ %
Services& .
.. /
IGmailClientFactory/ B
{ 
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
public 
GmailClientFactory !
(! "
IConfiguration" 0
configuration1 >
)> ?
{ 	
_configuration 
= 
configuration *
;* +
} 	
public 
async 
Task 
< 
GmailService &
>& '#
CreateGmailServiceAsync( ?
(? @
)@ A
{ 	
var   
accessToken   
=   
await   #
GetAccessTokenAsync  $ 7
(  7 8
)  8 9
;  9 :
var## 

credential## 
=## 
GoogleCredential## -
.##- .
FromAccessToken##. =
(##= >
accessToken##> I
)##I J
;##J K
return%% 
new%% 
GmailService%% #
(%%# $
new%%$ '
Google%%( .
.%%. /
Apis%%/ 3
.%%3 4
Services%%4 <
.%%< =
BaseClientService%%= N
.%%N O
Initializer%%O Z
{&& !
HttpClientInitializer'' %
=''& '

credential''( 2
,''2 3
ApplicationName(( 
=((  !
_configuration((" 0
[((0 1
$str((1 F
]((F G
})) 
))) 
;)) 
}** 	
private00 
async00 
Task00 
<00 
string00 !
>00! "
GetAccessTokenAsync00# 6
(006 7
)007 8
{11 	
if22 
(22 
!22 
	Directory22 
.22 
Exists22 !
(22! "
_configuration22" 0
[220 1
$str221 E
]22E F
)22F G
)22G H
{33 
throw44 
new44 %
InvalidOperationException44 3
(443 4
$str444 q
)44q r
;44r s
}55 
var77 

tokenFiles77 
=77 
	Directory77 &
.77& '
GetFiles77' /
(77/ 0
_configuration770 >
[77> ?
$str77? S
]77S T
)77T U
;77U V
if88 
(88 

tokenFiles88 
.88 
Length88 !
==88" $
$num88% &
)88& '
{99 
throw:: 
new:: %
InvalidOperationException:: 3
(::3 4
$str::4 s
)::s t
;::t u
};; 
var== 
	tokenJson== 
=== 
await== !
File==" &
.==& '
ReadAllTextAsync==' 7
(==7 8

tokenFiles==8 B
[==B C
$num==C D
]==D E
)==E F
;==F G
var>> 
tokenResponse>> 
=>> 
JsonConvert>>  +
.>>+ ,
DeserializeObject>>, =
<>>= >
TokenResponse>>> K
>>>K L
(>>L M
	tokenJson>>M V
)>>V W
;>>W X
if@@ 
(@@ 
tokenResponse@@ 
.@@ 
	IssuedUtc@@ '
.@@' (

AddSeconds@@( 2
(@@2 3
tokenResponse@@3 @
.@@@ A
ExpiresInSeconds@@A Q
??@@R T
$num@@U V
)@@V W
<@@X Y
DateTime@@Z b
.@@b c
UtcNow@@c i
)@@i j
{AA 
tokenResponseBB 
=BB 
awaitBB  %
RefreshTokenAsyncBB& 7
(BB7 8
tokenResponseBB8 E
.BBE F
RefreshTokenBBF R
)BBR S
;BBS T
awaitCC 
FileCC 
.CC 
WriteAllTextAsyncCC ,
(CC, -

tokenFilesCC- 7
[CC7 8
$numCC8 9
]CC9 :
,CC: ;
JsonConvertCC< G
.CCG H
SerializeObjectCCH W
(CCW X
tokenResponseCCX e
)CCe f
)CCf g
;CCg h
}DD 
returnFF 
tokenResponseFF  
.FF  !
AccessTokenFF! ,
;FF, -
}GG 	
privateNN 
asyncNN 
TaskNN 
<NN 
TokenResponseNN (
>NN( )
RefreshTokenAsyncNN* ;
(NN; <
stringNN< B
refreshTokenNNC O
)NNO P
{OO 	
varPP 
clientSecretsPP 
=PP 
newPP  #
ClientSecretsPP$ 1
{QQ 
ClientIdRR 
=RR 
_configurationRR )
[RR) *
$strRR* @
]RR@ A
,RRA B
ClientSecretSS 
=SS 
_configurationSS -
[SS- .
$strSS. H
]SSH I
}TT 
;TT 
varVV 
flowVV 
=VV 
newVV '
GoogleAuthorizationCodeFlowVV 6
(VV6 7
newVV7 :'
GoogleAuthorizationCodeFlowVV; V
.VVV W
InitializerVVW b
{WW 
ClientSecretsXX 
=XX 
clientSecretsXX  -
,XX- .
ScopesYY 
=YY 
newYY 
[YY 
]YY 
{YY  
$strYY! P
}YYQ R
}ZZ 
)ZZ 
;ZZ 
return\\ 
await\\ 
flow\\ 
.\\ 
RefreshTokenAsync\\ /
(\\/ 0
_configuration\\0 >
[\\> ?
$str\\? U
]\\U V
,\\V W
refreshToken\\X d
,\\d e
CancellationToken\\f w
.\\w x
None\\x |
)\\| }
;\\} ~
}]] 	
}^^ 
}__ Úó
CC:\Users\Dell\source\repos\BuscadorCan\Core\Service\ExcelService.cs
	namespace 	
Core
 
. 
Service 
. 
IService 
{ 
public 

class 
ExcelService 
( 
IONARepository 
onaRepository "
," #
IEsquemaRepository 
esquemaRepository *
,* +#
IEsquemaVistaRepository "
esquemaVistaRepository 4
,4 5*
IEsquemaVistaColumnaRepository $)
esquemaVistaColumnaRepository% B
,B C"
IEsquemaDataRepository !
esquemaDataRepository 2
,2 3&
IEsquemaFullTextRepository  %
esquemaFullTextRepository! :
,: ;#
IHomologacionRepository "
homologacionRepository 4
,4 5%
IMigracionExcelRepository $
migracionExcelRepository  8
,8 9#
ILogMigracionRepository "
logMigracionRepository 4
,4 5"
IONAConexionRepository 
conexionRepository /
,/ 0)
IpaActualizarFiltroRepository #
ipaActualizarFiltro$ 7
) 
: 	
IExcelService
 
{ 
private 
IONARepository 
_repositoryO +
=, -
onaRepository. ;
;; <
private 
IEsquemaRepository "
_repositoryE# /
=0 1
esquemaRepository2 C
;C D
private #
IEsquemaVistaRepository '
_repositoryEV( 5
=6 7"
esquemaVistaRepository8 N
;N O
private *
IEsquemaVistaColumnaRepository .
_repositoryEVC/ =
=> ?)
esquemaVistaColumnaRepository@ ]
;] ^
private "
IEsquemaDataRepository &
_repositoryED' 4
=5 6!
esquemaDataRepository7 L
;L M
private   &
IEsquemaFullTextRepository   *
_repositoryEFT  + 9
=  : ;%
esquemaFullTextRepository  < U
;  U V
private!! #
IHomologacionRepository!! '
_repositoryH!!( 4
=!!5 6"
homologacionRepository!!7 M
;!!M N
private"" %
IMigracionExcelRepository"" )
_repositoryME""* 7
=""8 9$
migracionExcelRepository"": R
;""R S
private## #
ILogMigracionRepository## '
_repositoryLM##( 5
=##6 7"
logMigracionRepository##8 N
;##N O
private$$ "
IONAConexionRepository$$ &
_repositoryOC$$' 4
=$$5 6
conexionRepository$$7 I
;$$I J
private%% 
int%% 
migration_cnt%% !
=%%" #
$num%%$ %
;%%% &
private&& 
int&& 
executionIndex&& "
=&&# $
$num&&% &
;&&& '
private'' 
bool'' 
deleted'' 
='' 
false'' $
;''$ %
private(( 
JArray(( 
currentSchema(( $
=((% &
new((' *
JArray((+ 1
(((1 2
)((2 3
;((3 4
private)) 
List)) 
<)) 
EsquemaVistaColumna)) (
>))( )
currentFields))* 7
=))8 9
new)): =
List))> B
<))B C
EsquemaVistaColumna))C V
>))V W
())W X
)))X Y
;))Y Z
private** 
LogMigracion** 
?** 
currentLogMigracion** 1
=**2 3
null**4 8
;**8 9
private++ 
LogMigracionDetalle++ #
?++# $&
currentLogMigracionDetalle++% ?
=++@ A
null++B F
;++F G
private,, 
ONA,, 
?,, 

currentONA,, 
=,,  !
null,," &
;,,& '
private-- 
ONAConexion-- 
?-- 
currentConexion-- ,
=--- .
null--/ 3
;--3 4
Esquema.. 
?.. 
currentEsquema.. 
=..  !
null.." &
;..& '
private// 
string// 

idEnteName// !
=//" #
$str//$ 5
;//5 6
private00 
string00 
[00 
]00 
errors00 
=00  !
Array00" '
.00' (
Empty00( -
<00- .
string00. 4
>004 5
(005 6
)006 7
;007 8
private11 )
IpaActualizarFiltroRepository11 - 
_ipaActualizarFiltro11. B
=11C D
ipaActualizarFiltro11E X
;11X Y
publicZZ 
asyncZZ 
TaskZZ 
<ZZ 
BooleanZZ !
>ZZ! "
ImportarExcelZZ# 0
(ZZ0 1
stringZZ1 7
pathZZ8 <
,ZZ< =
LogMigracionZZ> J
?ZZJ K
	migracionZZL U
,ZZU V
intZZW Z
idOnaZZ[ `
)ZZ` a
{[[ 	
try\\ 
{]] 
if^^ 
(^^ 
	migracion^^ 
==^^  
null^^! %
)^^% &
{__ 
	migracion`` 
=`` 
new``  #
LogMigracion``$ 0
(``0 1
)``1 2
;``2 3
	migracionaa 
.aa 
Estadoaa $
=aa% &
$straa' 3
;aa3 4
	migracionbb 
.bb 
ExcelFileNamebb +
=bb, -
pathbb. 2
.bb2 3
Splitbb3 8
(bb8 9
$strbb9 <
)bb< =
.bb= >
Lastbb> B
(bbB C
)bbC D
;bbD E
	migracioncc 
=cc 
_repositoryMEcc  -
.cc- .
Createcc. 4
(cc4 5
	migracioncc5 >
)cc> ?
;cc? @
}dd 
elseee 
{ff 
	migraciongg 
.gg 
Estadogg $
=gg% &
$strgg' 3
;gg3 4
	migracionhh 
.hh 
ExcelFileNamehh +
=hh, -
pathhh. 2
.hh2 3
Splithh3 8
(hh8 9
$strhh9 <
)hh< =
.hh= >
Lasthh> B
(hhB C
)hhC D
;hhD E
_repositoryMEjj !
.jj! "
Updatejj" (
(jj( )
	migracionjj) 2
)jj2 3
;jj3 4
}kk 
varll 
resultll 
=ll 
awaitll "
Leerll# '
(ll' (
pathll( ,
,ll, -
idOnall. 3
)ll3 4
;ll4 5
ifmm 
(mm 
resultmm 
)mm 
{nn 
	migracionoo 
.oo 
ExcelFileNameoo +
=oo, -
pathoo. 2
.oo2 3
Splitoo3 8
(oo8 9
$stroo9 <
)oo< =
.oo= >
Lastoo> B
(ooB C
)ooC D
;ooD E
	migracionpp 
.pp 
Estadopp $
=pp% &
$strpp' 0
;pp0 1
}qq 
elserr 
{ss 
	migraciontt 
.tt 
ExcelFileNamett +
=tt, -
pathtt. 2
.tt2 3
Splittt3 8
(tt8 9
$strtt9 <
)tt< =
.tt= >
Lasttt> B
(ttB C
)ttC D
;ttD E
	migracionuu 
.uu 
Estadouu $
=uu% &
$struu' .
;uu. /
	migracionvv 
.vv 
Observacionvv )
=vv* +
$strvv, L
;vvL M
}ww 
_repositoryMExx 
.xx 
Updatexx $
(xx$ %
	migracionxx% .
)xx. /
;xx/ 0
returnzz 
resultzz 
;zz 
}{{ 
catch|| 
(|| 
	Exception|| 
e|| 
)|| 
{}} 
Console~~ 
.~~ 
	WriteLine~~ !
(~~! "
e~~" #
)~~# $
;~~$ %
errors 
= 
errors 
.  
Append  &
(& '
e' (
.( )
Message) 0
)0 1
.1 2
ToArray2 9
(9 :
): ;
;; <
	migracion
ÄÄ 
.
ÄÄ 
Estado
ÄÄ  
=
ÄÄ! "
$str
ÄÄ# *
;
ÄÄ* +
	migracion
ÅÅ 
.
ÅÅ 
Observacion
ÅÅ %
=
ÅÅ& '
string
ÅÅ( .
.
ÅÅ. /
Join
ÅÅ/ 3
(
ÅÅ3 4
$str
ÅÅ4 8
,
ÅÅ8 9
errors
ÅÅ: @
)
ÅÅ@ A
;
ÅÅA B
_repositoryME
ÇÇ 
.
ÇÇ 
Update
ÇÇ $
(
ÇÇ$ %
	migracion
ÇÇ% .
)
ÇÇ. /
;
ÇÇ/ 0
if
ÉÉ 
(
ÉÉ !
currentLogMigracion
ÉÉ '
!=
ÉÉ( *
null
ÉÉ+ /
)
ÉÉ/ 0
{
ÑÑ !
currentLogMigracion
ÖÖ '
.
ÖÖ' (
Final
ÖÖ( -
=
ÖÖ. /
DateTime
ÖÖ0 8
.
ÖÖ8 9
Now
ÖÖ9 <
;
ÖÖ< =!
currentLogMigracion
ÜÜ '
.
ÜÜ' (
Estado
ÜÜ( .
=
ÜÜ/ 0
$str
ÜÜ1 8
;
ÜÜ8 9!
currentLogMigracion
áá '
.
áá' (
Observacion
áá( 3
=
áá4 5
string
áá6 <
.
áá< =
Join
áá= A
(
ááA B
$str
ááB F
,
ááF G
errors
ááH N
)
ááN O
;
ááO P!
currentLogMigracion
àà '
.
àà' (
EsquemaFilas
àà( 4
=
àà5 6
migration_cnt
àà7 D
;
ààD E
_repositoryLM
ââ !
.
ââ! "
Update
ââ" (
(
ââ( )!
currentLogMigracion
ââ) <
)
ââ< =
;
ââ= >
}
ää 
return
ãã 
false
ãã 
;
ãã 
}
åå 
}
çç 	
public
éé 
async
éé 
Task
éé 
<
éé 
Boolean
éé !
>
éé! "
Leer
éé# '
(
éé' (
string
éé( .
fileSrc
éé/ 6
,
éé6 7
int
éé8 ;
idOna
éé< A
)
ééA B
{
èè 	
try
êê 
{
ëë 
bool
íí 
	resultado
íí 
=
íí  
true
íí! %
;
íí% &
	Stopwatch
ìì 
	stopwatch
ìì #
=
ìì$ %
new
ìì& )
	Stopwatch
ìì* 3
(
ìì3 4
)
ìì4 5
;
ìì5 6
System
ïï 
.
ïï 
Text
ïï 
.
ïï 
Encoding
ïï $
.
ïï$ %
RegisterProvider
ïï% 5
(
ïï5 6
System
ïï6 <
.
ïï< =
Text
ïï= A
.
ïïA B'
CodePagesEncodingProvider
ïïB [
.
ïï[ \
Instance
ïï\ d
)
ïïd e
;
ïïe f
using
óó 
(
óó 
var
óó 
stream
óó !
=
óó" #
File
óó$ (
.
óó( )
Open
óó) -
(
óó- .
fileSrc
óó. 5
,
óó5 6
FileMode
óó7 ?
.
óó? @
Open
óó@ D
,
óóD E

FileAccess
óóF P
.
óóP Q
Read
óóQ U
)
óóU V
)
óóV W
{
òò 
using
ôô 
(
ôô 
var
ôô 
reader
ôô %
=
ôô& ' 
ExcelReaderFactory
ôô( :
.
ôô: ;
CreateReader
ôô; G
(
ôôG H
stream
ôôH N
)
ôôN O
)
ôôO P
{
öö 
var
õõ 
configuration
õõ )
=
õõ* +
new
õõ, /'
ExcelDataSetConfiguration
õõ0 I
{
úú  
ConfigureDataTable
ùù .
=
ùù/ 0
_
ùù1 2
=>
ùù3 5
new
ùù6 9)
ExcelDataTableConfiguration
ùù: U
{
ûû 
UseHeaderRow
üü  ,
=
üü- .
true
üü/ 3
}
†† 
}
°° 
;
°° 
var
££ 
DataSet
££ #
=
££$ %
reader
££& ,
.
££, -
	AsDataSet
££- 6
(
££6 7
configuration
££7 D
)
££D E
;
££E F
if
•• 
(
•• 
DataSet
•• #
.
••# $
Tables
••$ *
.
••* +
Count
••+ 0
>
••1 2
$num
••3 4
)
••4 5
{
¶¶ 
DateTime
ßß $
	StartTime
ßß% .
=
ßß/ 0
DateTime
ßß1 9
.
ßß9 :
Now
ßß: =
;
ßß= >
var
®® 
migrationValue
®®  .
=
®®/ 0
DataSet
®®1 8
.
®®8 9
Tables
®®9 ?
[
®®? @
$num
®®@ A
]
®®A B
.
®®B C
Rows
®®C G
[
®®G H
$num
®®H I
]
®®I J
[
®®J K
$num
®®K L
]
®®L M
.
®®M N
ToString
®®N V
(
®®V W
)
®®W X
;
®®X Y

currentONA
™™ &
=
™™' (
_repositoryO
™™) 5
.
™™5 6
FindById
™™6 >
(
™™> ?
idOna
™™? D
)
™™D E
;
™™E F
if
´´ 
(
´´  

currentONA
´´  *
==
´´+ -
null
´´. 2
)
´´2 3
{
¨¨ 
throw
ÆÆ  %
new
ÆÆ& )
	Exception
ÆÆ* 3
(
ÆÆ3 4
$"
ÆÆ4 6
$str
ÆÆ6 A
{
ÆÆA B
migrationValue
ÆÆB P
}
ÆÆP Q
$str
ÆÆQ s
"
ÆÆs t
)
ÆÆt u
;
ÆÆu v
}
ØØ 
Console
∞∞ #
.
∞∞# $
	WriteLine
∞∞$ -
(
∞∞- .
$str
∞∞. =
+
∞∞> ?

currentONA
∞∞@ J
.
∞∞J K
RazonSocial
∞∞K V
)
∞∞V W
;
∞∞W X
currentConexion
±± +
=
±±, -
_repositoryOC
±±. ;
.
±±; <
FindByIdONA
±±< G
(
±±G H

currentONA
±±H R
.
±±R S
IdONA
±±S X
)
±±X Y
;
±±Y Z
if
≤≤ 
(
≤≤  
currentConexion
≤≤  /
==
≤≤0 2
null
≤≤3 7
)
≤≤7 8
{
≥≥ 
throw
¥¥  %
new
¥¥& )
	Exception
¥¥* 3
(
¥¥3 4
$"
¥¥4 6
$str
¥¥6 q
{
¥¥q r

currentONA
¥¥r |
.
¥¥| }
RazonSocial¥¥} à
}¥¥à â
"¥¥â ä
)¥¥ä ã
;¥¥ã å
}
µµ 
foreach
∂∂ #
(
∂∂$ %
	DataTable
∂∂% .
	dataTable
∂∂/ 8
in
∂∂9 ;
DataSet
∂∂< C
.
∂∂C D
Tables
∂∂D J
)
∂∂J K
{
∑∑ 
LogMigracion
∏∏  ,
logMigracion
∏∏- 9
=
∏∏: ;
new
∏∏< ?
LogMigracion
∏∏@ L
(
∏∏L M
)
∏∏M N
;
∏∏N O
string
ππ  &
	sheetName
ππ' 0
=
ππ1 2
	dataTable
ππ3 <
.
ππ< =
	TableName
ππ= F
;
ππF G
currentEsquema
∫∫  .
=
∫∫/ 0
_repositoryE
∫∫1 =
.
∫∫= >
FindByViewName
∫∫> L
(
∫∫L M
	sheetName
∫∫M V
)
∫∫V W
;
∫∫W X
if
ªª  "
(
ªª# $
currentEsquema
ªª$ 2
==
ªª3 5
null
ªª6 :
)
ªª: ;
{
ºº  !
errors
ΩΩ$ *
=
ΩΩ+ ,
errors
ΩΩ- 3
.
ΩΩ3 4
Append
ΩΩ4 :
(
ΩΩ: ;
$"
ΩΩ; =
$str
ΩΩ= L
{
ΩΩL M
	sheetName
ΩΩM V
}
ΩΩV W
$strΩΩW É
{ΩΩÉ Ñ

currentONAΩΩÑ é
.ΩΩé è
RazonSocialΩΩè ö
}ΩΩö õ
"ΩΩõ ú
)ΩΩú ù
.ΩΩù û
ToArrayΩΩû •
(ΩΩ• ¶
)ΩΩ¶ ß
;ΩΩß ®
continue
ææ$ ,
;
ææ, -
}
øø  !
EsquemaVista
¡¡  ,
?
¡¡, -
esquemaVista
¡¡. :
=
¡¡; <
_repositoryEV
¡¡= J
.
¡¡J K
_FindByIdEsquema
¡¡K [
(
¡¡[ \
currentEsquema
¡¡\ j
.
¡¡j k
	IdEsquema
¡¡k t
,
¡¡t u

currentONA¡¡v Ä
.¡¡Ä Å
IdONA¡¡Å Ü
)¡¡Ü á
;¡¡á à
if
√√  "
(
√√# $
esquemaVista
√√$ 0
==
√√1 3
null
√√4 8
)
√√8 9
{
ƒƒ  !
errors
≈≈$ *
=
≈≈+ ,
errors
≈≈- 3
.
≈≈3 4
Append
≈≈4 :
(
≈≈: ;
$"
≈≈; =
$str
≈≈= R
{
≈≈R S
	sheetName
≈≈S \
}
≈≈\ ]
$str≈≈] â
{≈≈â ä

currentONA≈≈ä î
.≈≈î ï
RazonSocial≈≈ï †
}≈≈† °
"≈≈° ¢
)≈≈¢ £
.≈≈£ §
ToArray≈≈§ ´
(≈≈´ ¨
)≈≈¨ ≠
;≈≈≠ Æ
continue
∆∆$ ,
;
∆∆, -
}
««  !
logMigracion
……  ,
.
……, -
IdONA
……- 2
=
……3 4
currentConexion
……5 D
.
……D E
IdONA
……E J
;
……J K
logMigracion
    ,
.
  , -
VistaOrigen
  - 8
=
  9 :
esquemaVista
  ; G
.
  G H
VistaOrigen
  H S
;
  S T
logMigracion
ÀÀ  ,
.
ÀÀ, -

VistaFilas
ÀÀ- 7
=
ÀÀ8 9
	dataTable
ÀÀ: C
.
ÀÀC D
Rows
ÀÀD H
.
ÀÀH I
Count
ÀÀI N
;
ÀÀN O
logMigracion
ÃÃ  ,
.
ÃÃ, -
EsquemaFilas
ÃÃ- 9
=
ÃÃ: ;
$num
ÃÃ< =
;
ÃÃ= >
logMigracion
ÕÕ  ,
.
ÕÕ, -
	EsquemaId
ÕÕ- 6
=
ÕÕ7 8
currentEsquema
ÕÕ9 G
.
ÕÕG H
	IdEsquema
ÕÕH Q
;
ÕÕQ R
logMigracion
ŒŒ  ,
.
ŒŒ, -
EsquemaVista
ŒŒ- 9
=
ŒŒ: ;
currentEsquema
ŒŒ< J
.
ŒŒJ K
EsquemaVista
ŒŒK W
;
ŒŒW X
logMigracion
œœ  ,
.
œœ, -
Inicio
œœ- 3
=
œœ4 5
	StartTime
œœ6 ?
;
œœ? @
logMigracion
——  ,
.
——, -
ExcelFileName
——- :
=
——; <
fileSrc
——= D
.
——D E
Split
——E J
(
——J K
$str
——K N
)
——N O
.
——O P
Last
——P T
(
——T U
)
——U V
;
——V W!
currentLogMigracion
““  3
=
““4 5
_repositoryLM
““6 C
.
““C D
Create
““D J
(
““J K
logMigracion
““K W
)
““W X
;
““X Y
currentFields
’’  -
=
’’. /
_repositoryEVC
’’0 >
.
’’> ?%
FindByIdEsquemaVistaOna
’’? V
(
’’V W
esquemaVista
’’W c
.
’’c d
IdEsquemaVista
’’d r
,
’’r s

currentONA
’’t ~
.
’’~ 
IdONA’’ Ñ
)’’Ñ Ö
;’’Ö Ü
if
◊◊  "
(
◊◊# $
currentFields
◊◊$ 1
.
◊◊1 2
Count
◊◊2 7
==
◊◊8 :
$num
◊◊; <
)
◊◊< =
{
ÿÿ  !
errors
ŸŸ$ *
=
ŸŸ+ ,
errors
ŸŸ- 3
.
ŸŸ3 4
Append
ŸŸ4 :
(
ŸŸ: ;
$"
ŸŸ; =
$str
ŸŸ= s
{
ŸŸs t
esquemaVistaŸŸt Ä
.ŸŸÄ Å
VistaOrigenŸŸÅ å
}ŸŸå ç
$strŸŸç §
{ŸŸ§ •

currentONAŸŸ• Ø
.ŸŸØ ∞
RazonSocialŸŸ∞ ª
}ŸŸª º
"ŸŸº Ω
)ŸŸΩ æ
.ŸŸæ ø
ToArrayŸŸø ∆
(ŸŸ∆ «
)ŸŸ« »
;ŸŸ» …
continue
⁄⁄$ ,
;
⁄⁄, -
}
€€  !
executionIndex
››  .
=
››/ 0
DataSet
››1 8
.
››8 9
Tables
››9 ?
.
››? @
IndexOf
››@ G
(
››G H
	dataTable
››H Q
)
››Q R
;
››R S
Console
ﬁﬁ  '
.
ﬁﬁ' (
	WriteLine
ﬁﬁ( 1
(
ﬁﬁ1 2
$str
ﬁﬁ2 E
+
ﬁﬁF G
executionIndex
ﬁﬁH V
+
ﬁﬁW X
$str
ﬁﬁY c
+
ﬁﬁd e
	dataTable
ﬁﬁf o
.
ﬁﬁo p
	TableName
ﬁﬁp y
)
ﬁﬁy z
;
ﬁﬁz {
DeleteDataAntigua
‡‡  1
(
‡‡1 2
idOna
‡‡2 7
)
‡‡7 8
;
‡‡8 9
for
‚‚  #
(
‚‚$ %
int
‚‚% (
i
‚‚) *
=
‚‚+ ,
$num
‚‚- .
;
‚‚. /
i
‚‚0 1
<
‚‚2 3
	dataTable
‚‚4 =
.
‚‚= >
Rows
‚‚> B
.
‚‚B C
Count
‚‚C H
;
‚‚H I
i
‚‚J K
++
‚‚K M
)
‚‚M N
{
„„  !
EsquemaData
ËË$ /
esquemaData
ËË0 ;
=
ËË< =
addEsquemaData
ËË> L
(
ËËL M
	dataTable
ËËM V
,
ËËV W
i
ËËX Y
,
ËËY Z
esquemaVista
ËË[ g
.
ËËg h
IdEsquemaVista
ËËh v
)
ËËv w
;
ËËw x 
addEsquemaFullText
ÈÈ$ 6
(
ÈÈ6 7
	dataTable
ÈÈ7 @
,
ÈÈ@ A
i
ÈÈB C
,
ÈÈC D
esquemaData
ÈÈE P
.
ÈÈP Q
IdEsquemaData
ÈÈQ ^
)
ÈÈ^ _
;
ÈÈ_ `!
currentLogMigracion
ÍÍ$ 7
.
ÍÍ7 8
Final
ÍÍ8 =
=
ÍÍ> ?
DateTime
ÍÍ@ H
.
ÍÍH I
Now
ÍÍI L
;
ÍÍL M!
currentLogMigracion
ÎÎ$ 7
.
ÎÎ7 8
Estado
ÎÎ8 >
=
ÎÎ? @
$str
ÎÎA E
;
ÎÎE F!
currentLogMigracion
ÏÏ$ 7
.
ÏÏ7 8
EsquemaFilas
ÏÏ8 D
=
ÏÏE F
migration_cnt
ÏÏG T
;
ÏÏT U
_repositoryLM
ÌÌ$ 1
.
ÌÌ1 2
Update
ÌÌ2 8
(
ÌÌ8 9!
currentLogMigracion
ÌÌ9 L
)
ÌÌL M
;
ÌÌM N
}
ÓÓ  !
}
ÔÔ 
bool
ÚÚ  
resultadoSP
ÚÚ! ,
=
ÚÚ- .
await
ÚÚ/ 4"
_ipaActualizarFiltro
ÚÚ5 I
.
ÚÚI J#
ActualizarFiltroAsync
ÚÚJ _
(
ÚÚ_ `
)
ÚÚ` a
;
ÚÚa b
if
ÛÛ 
(
ÛÛ  
resultadoSP
ÛÛ  +
)
ÛÛ+ ,
{
ÙÙ 
Console
ıı  '
.
ıı' (
	WriteLine
ıı( 1
(
ıı1 2
$str
ıı2 {
)
ıı{ |
;
ıı| }
}
ˆˆ 
else
˜˜  
{
¯¯ 
Console
˘˘  '
.
˘˘' (
	WriteLine
˘˘( 1
(
˘˘1 2
$str
˘˘2 b
)
˘˘b c
;
˘˘c d
}
˙˙ 
return
ää "
	resultado
ää# ,
;
ää, -
}
ãã 
else
åå 
{
çç 
Console
éé #
.
éé# $
	WriteLine
éé$ -
(
éé- .
$str
éé. ?
)
éé? @
;
éé@ A
return
èè "
false
èè# (
;
èè( )
}
êê 
}
ëë 
}
íí 
}
ìì 
catch
îî 
(
îî 
	Exception
îî 
ex
îî 
)
îî  
{
ïï 
throw
óó 
ex
óó 
;
óó 
}
òò 
}
öö 	
EsquemaData
úú 
addEsquemaData
úú "
(
úú" #
	DataTable
úú# ,
	dataTable
úú- 6
,
úú6 7
int
úú8 ;
row
úú< ?
,
úú? @
int
úúA D
esquemaVistaId
úúE S
)
úúS T
{
ùù 	
EsquemaData
ûû 

canDataSet
ûû "
=
ûû# $
new
ûû% (
EsquemaData
ûû) 4
{
üü 
IdEsquemaVista
†† 
=
††  
esquemaVistaId
††! /
,
††/ 0
DataEsquemaJson
°° 
=
°°  !%
buildEsquemaDataSetJson
°°" 9
(
°°9 :
	dataTable
°°: C
,
°°C D
row
°°E H
)
°°H I
}
¢¢ 
;
¢¢ 
migration_cnt
££ 
++
££ 
;
££ 
return
§§ 
_repositoryED
§§  
.
§§  !
Create
§§! '
(
§§' (

canDataSet
§§( 2
)
§§2 3
;
§§3 4
}
•• 	
bool
ßß  
addEsquemaFullText
ßß 
(
ßß  
	DataTable
ßß  )
	dataTable
ßß* 3
,
ßß3 4
int
ßß5 8
row
ßß9 <
,
ßß< =
int
ßß> A
esquemaDataId
ßßB O
)
ßßO P
{
®® 	
bool
©© 
result
©© 
=
©© 
true
©© 
;
©© 
foreach
™™ 
(
™™ !
EsquemaVistaColumna
™™ (
currentField
™™) 5
in
™™6 8
currentFields
™™9 F
)
™™F G
{
´´ 
if
¨¨ 
(
¨¨ 
currentField
¨¨  
.
¨¨  !
ColumnaEsquemaIdH
¨¨! 2
<
¨¨3 4
$num
¨¨5 6
)
¨¨6 7
{
≠≠ 
errors
ÆÆ 
=
ÆÆ 
errors
ÆÆ #
.
ÆÆ# $
Append
ÆÆ$ *
(
ÆÆ* +
$"
ÆÆ+ -
$str
ÆÆ- <
{
ÆÆ< =
currentField
ÆÆ= I
.
ÆÆI J
ColumnaEsquema
ÆÆJ X
}
ÆÆX Y
$strÆÆY Ö
{ÆÆÖ Ü

currentONAÆÆÜ ê
.ÆÆê ë
RazonSocialÆÆë ú
}ÆÆú ù
"ÆÆù û
)ÆÆû ü
.ÆÆü †
ToArrayÆÆ† ß
(ÆÆß ®
)ÆÆ® ©
;ÆÆ© ™
continue
ØØ 
;
ØØ 
}
∞∞ 
int
≤≤ 
currentFieldIndex
≤≤ %
=
≤≤& '
Array
≤≤( -
.
≤≤- .
	FindIndex
≤≤. 7
(
≤≤7 8
	dataTable
≤≤8 A
.
≤≤A B
Columns
≤≤B I
.
≤≤I J
Cast
≤≤J N
<
≤≤N O

DataColumn
≤≤O Y
>
≤≤Y Z
(
≤≤Z [
)
≤≤[ \
.
≤≤\ ]
Select
≤≤] c
(
≤≤c d
c
≤≤d e
=>
≤≤f h
c
≤≤i j
.
≤≤j k

ColumnName
≤≤k u
)
≤≤u v
.
≤≤v w
ToArray
≤≤w ~
(
≤≤~ 
)≤≤ Ä
,≤≤Ä Å
c≤≤Ç É
=>≤≤Ñ Ü
c≤≤á à
==≤≤â ã
currentField≤≤å ò
.≤≤ò ô
ColumnaVista≤≤ô •
)≤≤• ¶
;≤≤¶ ß
if
≥≥ 
(
≥≥ 
currentFieldIndex
≥≥ %
==
≥≥& (
-
≥≥) *
$num
≥≥* +
)
≥≥+ ,
{
¥¥ 
errors
µµ 
=
µµ 
errors
µµ #
.
µµ# $
Append
µµ$ *
(
µµ* +
$"
µµ+ -
$str
µµ- <
{
µµ< =
currentField
µµ= I
.
µµI J
ColumnaVista
µµJ V
}
µµV W
$strµµW ä
{µµä ã

currentONAµµã ï
.µµï ñ
RazonSocialµµñ °
}µµ° ¢
"µµ¢ £
)µµ£ §
.µµ§ •
ToArrayµµ• ¨
(µµ¨ ≠
)µµ≠ Æ
;µµÆ Ø
continue
∂∂ 
;
∂∂ 
}
∑∑ 
string
ππ 
?
ππ 
currentValue
ππ $
=
ππ% &
	dataTable
ππ' 0
.
ππ0 1
Rows
ππ1 5
[
ππ5 6
row
ππ6 9
]
ππ9 :
[
ππ: ;
currentFieldIndex
ππ; L
]
ππL M
.
ππM N
ToString
ππN V
(
ππV W
)
ππW X
;
ππX Y
if
∫∫ 
(
∫∫ 
string
∫∫ 
.
∫∫ 
IsNullOrEmpty
∫∫ (
(
∫∫( )
currentValue
∫∫) 5
)
∫∫5 6
)
∫∫6 7
{
ªª 
errors
ºº 
=
ºº 
errors
ºº #
.
ºº# $
Append
ºº$ *
(
ºº* +
$"
ºº+ -
$str
ºº- <
{
ºº< =
currentField
ºº= I
.
ººI J
ColumnaVista
ººJ V
}
ººV W
$str
ººW {
{
ºº{ |

currentONAºº| Ü
.ººÜ á
RazonSocialººá í
}ººí ì
"ººì î
)ººî ï
.ººï ñ
ToArrayººñ ù
(ººù û
)ººû ü
;ººü †
continue
ΩΩ 
;
ΩΩ 
}
ææ 
EsquemaFullText
¿¿ 
newCanFullText
¿¿  .
=
¿¿/ 0
new
¿¿1 4
EsquemaFullText
¿¿5 D
{
¡¡ 
IdEsquemaData
¬¬ !
=
¬¬" #
esquemaDataId
¬¬$ 1
,
¬¬1 2
IdHomologacion
√√ "
=
√√# $
currentField
√√% 1
.
√√1 2
ColumnaEsquemaIdH
√√2 C
,
√√C D
FullTextData
ƒƒ  
=
ƒƒ! "
currentValue
ƒƒ# /
,
ƒƒ/ 0
}
≈≈ 
;
≈≈ 
result
«« 
=
«« 
_repositoryEFT
«« '
.
««' (
Create
««( .
(
««. /
newCanFullText
««/ =
)
««= >
!=
««? A
null
««B F
?
««G H
result
««I O
:
««P Q
false
««R W
;
««W X
}
»» 
return
…… 
result
…… 
;
…… 
}
   	
string
ÃÃ %
buildEsquemaDataSetJson
ÃÃ &
(
ÃÃ& '
	DataTable
ÃÃ' 0
	dataTable
ÃÃ1 :
,
ÃÃ: ;
int
ÃÃ< ?
row
ÃÃ@ C
)
ÃÃC D
{
ÕÕ 	
JArray
ŒŒ 
data
ŒŒ 
=
ŒŒ 
new
ŒŒ 
JArray
ŒŒ $
(
ŒŒ$ %
)
ŒŒ% &
;
ŒŒ& '
foreach
œœ 
(
œœ !
EsquemaVistaColumna
œœ (
currentField
œœ) 5
in
œœ6 8
currentFields
œœ9 F
)
œœF G
{
–– 
addLogDetail
—— 
(
—— 
currentField
—— )
)
——) *
;
——* +
if
““ 
(
““ 
currentField
““  
.
““  !
ColumnaEsquemaIdH
““! 2
<
““3 4
$num
““5 6
)
““6 7
{
”” 
errors
‘‘ 
=
‘‘ 
errors
‘‘ #
.
‘‘# $
Append
‘‘$ *
(
‘‘* +
$"
‘‘+ -
$str
‘‘- <
{
‘‘< =
currentField
‘‘= I
.
‘‘I J
ColumnaEsquema
‘‘J X
}
‘‘X Y
$str‘‘Y Ö
{‘‘Ö Ü

currentONA‘‘Ü ê
.‘‘ê ë
RazonSocial‘‘ë ú
}‘‘ú ù
"‘‘ù û
)‘‘û ü
.‘‘ü †
ToArray‘‘† ß
(‘‘ß ®
)‘‘® ©
;‘‘© ™
continue
’’ 
;
’’ 
}
÷÷ 
int
ÿÿ 
currentFieldIndex
ÿÿ %
=
ÿÿ& '
Array
ÿÿ( -
.
ÿÿ- .
	FindIndex
ÿÿ. 7
(
ÿÿ7 8
	dataTable
ÿÿ8 A
.
ÿÿA B
Columns
ÿÿB I
.
ÿÿI J
Cast
ÿÿJ N
<
ÿÿN O

DataColumn
ÿÿO Y
>
ÿÿY Z
(
ÿÿZ [
)
ÿÿ[ \
.
ÿÿ\ ]
Select
ÿÿ] c
(
ÿÿc d
c
ÿÿd e
=>
ÿÿf h
c
ÿÿi j
.
ÿÿj k

ColumnName
ÿÿk u
)
ÿÿu v
.
ÿÿv w
ToArray
ÿÿw ~
(
ÿÿ~ 
)ÿÿ Ä
,ÿÿÄ Å
cÿÿÇ É
=>ÿÿÑ Ü
cÿÿá à
==ÿÿâ ã
currentFieldÿÿå ò
.ÿÿò ô
ColumnaVistaÿÿô •
)ÿÿ• ¶
;ÿÿ¶ ß
if
ŸŸ 
(
ŸŸ 
currentFieldIndex
ŸŸ %
==
ŸŸ& (
-
ŸŸ) *
$num
ŸŸ* +
)
ŸŸ+ ,
{
⁄⁄ 
errors
€€ 
=
€€ 
errors
€€ #
.
€€# $
Append
€€$ *
(
€€* +
$"
€€+ -
$str
€€- <
{
€€< =
currentField
€€= I
.
€€I J
ColumnaVista
€€J V
}
€€V W
$str€€W ä
{€€ä ã

currentONA€€ã ï
.€€ï ñ
RazonSocial€€ñ °
}€€° ¢
"€€¢ £
)€€£ §
.€€§ •
ToArray€€• ¨
(€€¨ ≠
)€€≠ Æ
;€€Æ Ø
continue
‹‹ 
;
‹‹ 
}
›› 
data
ÍÍ 
.
ÍÍ 
Add
ÍÍ 
(
ÍÍ 
new
ÍÍ 
JObject
ÍÍ $
{
ÎÎ 
[
ÏÏ 
$str
ÏÏ %
]
ÏÏ% &
=
ÏÏ' (
currentField
ÏÏ) 5
.
ÏÏ5 6
ColumnaEsquemaIdH
ÏÏ6 G
,
ÏÏG H
[
ÌÌ 
$str
ÌÌ 
]
ÌÌ 
=
ÌÌ 
	dataTable
ÌÌ (
.
ÌÌ( )
Rows
ÌÌ) -
[
ÌÌ- .
row
ÌÌ. 1
]
ÌÌ1 2
[
ÌÌ2 3
currentFieldIndex
ÌÌ3 D
]
ÌÌD E
.
ÌÌE F
ToString
ÌÌF N
(
ÌÌN O
)
ÌÌO P
}
ÔÔ 
)
ÔÔ 
;
ÔÔ 
}
 
return
ÚÚ 
data
ÚÚ 
.
ÚÚ 
ToString
ÚÚ  
(
ÚÚ  !
)
ÚÚ! "
;
ÚÚ" #
}
ÛÛ 	
bool
ÅÅ 
DeleteDataAntigua
ÅÅ 
(
ÅÅ 
int
ÅÅ "
idOna
ÅÅ# (
)
ÅÅ( )
{
ÇÇ 	
Console
ÉÉ 
.
ÉÉ 
	WriteLine
ÉÉ 
(
ÉÉ 
$"
ÉÉ  
$str
ÉÉ  9
{
ÉÉ9 :
idOna
ÉÉ: ?
}
ÉÉ? @
"
ÉÉ@ A
)
ÉÉA B
;
ÉÉB C
if
ÑÑ 
(
ÑÑ 
deleted
ÑÑ 
)
ÑÑ 
{
ÖÖ 
Console
ÜÜ 
.
ÜÜ 
	WriteLine
ÜÜ !
(
ÜÜ! "
$str
ÜÜ" 3
)
ÜÜ3 4
;
ÜÜ4 5
return
áá 
true
áá 
;
áá 
}
àà 
deleted
ââ 
=
ââ 
true
ââ 
;
ââ 
Console
ää 
.
ää 
	WriteLine
ää 
(
ää 
$str
ää )
)
ää) *
;
ää* +
return
ãã 
_repositoryED
ãã  
.
ãã  !
DeleteDataAntigua
ãã! 2
(
ãã2 3
idOna
ãã3 8
)
ãã8 9
;
ãã9 :
}
åå 	
bool
ìì 
addLogDetail
ìì 
(
ìì !
EsquemaVistaColumna
ìì -
field
ìì. 3
)
ìì3 4
{
îî 	
if
ïï 
(
ïï !
currentLogMigracion
ïï #
==
ïï$ &
null
ïï' +
)
ïï+ ,
{
ññ 
return
óó 
false
óó 
;
óó 
}
òò !
LogMigracionDetalle
ôô !
logMigracionDetalle
ôô  3
=
ôô4 5
new
ôô6 9!
LogMigracionDetalle
ôô: M
(
ôôM N!
currentLogMigracion
ôôN a
)
ôôa b
;
ôôb c!
logMigracionDetalle
öö 
.
öö  
IdEsquemaVista
öö  .
=
öö/ 0
field
öö1 6
.
öö6 7
IdEsquemaVista
öö7 E
;
ööE F!
logMigracionDetalle
õõ 
.
õõ  
ColumnaEsquemaIdH
õõ  1
=
õõ2 3
field
õõ4 9
.
õõ9 :
ColumnaEsquemaIdH
õõ: K
;
õõK L!
logMigracionDetalle
úú 
.
úú  
ColumnaEsquema
úú  .
=
úú/ 0
field
úú1 6
.
úú6 7
ColumnaEsquema
úú7 E
;
úúE F!
logMigracionDetalle
ùù 
.
ùù  
ColumnaVista
ùù  ,
=
ùù- .
field
ùù/ 4
.
ùù4 5
ColumnaVista
ùù5 A
;
ùùA B!
logMigracionDetalle
ûû 
.
ûû  
ColumnaVistaPK
ûû  .
=
ûû/ 0
field
ûû1 6
.
ûû6 7
ColumnaVistaPK
ûû7 E
;
ûûE F(
currentLogMigracionDetalle
üü &
=
üü' (
_repositoryLM
üü) 6
.
üü6 7
CreateDetalle
üü7 D
(
üüD E!
logMigracionDetalle
üüE X
)
üüX Y
;
üüY Z
return
†† (
currentLogMigracionDetalle
†† -
!=
††. 0
null
††1 5
;
††5 6
}
°° 	
}
¢¢ 
}££ ¡%
KC:\Users\Dell\source\repos\BuscadorCan\Core\Service\EventTrackingService.cs
	namespace 	
Core
 
. 
Service 
{ 
public 

class  
EventTrackingService %
:& '!
IEventTrackingService( =
{		 
private

 
readonly

 $
IEventTrackingRepository

 1$
_eventTrackingRepository

2 J
;

J K
public  
EventTrackingService #
(# $$
IEventTrackingRepository$ <#
eventTrackingRepository= T
)T U
{ 	
this 
. $
_eventTrackingRepository )
=* +#
eventTrackingRepository, C
;C D
} 	
public 
bool 
Create 
( !
paAddEventTrackingDto 0
data1 5
)5 6
{ 	
return $
_eventTrackingRepository +
.+ ,
Create, 2
(2 3
data3 7
)7 8
;8 9
} 	
public 
bool 
DeleteEventAll "
(" #
DateOnly# +
fini, 0
,0 1
DateOnly2 :
ffin; ?
)? @
{ 	
return $
_eventTrackingRepository +
.+ ,
DeleteEventAll, :
(: ;
fini; ?
,? @
ffinA E
)E F
;F G
} 	
public 
bool 
DeleteEventById #
(# $
int$ '
id( *
)* +
{ 	
return $
_eventTrackingRepository +
.+ ,
DeleteEventById, ;
(; <
id< >
)> ?
;? @
} 	
public   
Menus   
?   
FindDataById   "
(  " #
int  # &
idHRol  ' -
,  - .
int  / 2
idHMenu  3 :
)  : ;
{!! 	
return"" $
_eventTrackingRepository"" +
.""+ ,
FindDataById"", 8
(""8 9
idHRol""9 ?
,""? @
idHMenu""A H
)""H I
;""I J
}## 	
public%% 
string%% 
GetCodeByUser%% #
(%%# $
string%%$ *
nombreUsuario%%+ 8
,%%8 9
string%%: @!
CodigoHomologacionRol%%A V
,%%V W
string%%X ^"
CodigoHomologacionMenu%%_ u
)%%u v
{&& 	
return'' $
_eventTrackingRepository'' +
.''+ ,
GetCodeByUser'', 9
(''9 :
nombreUsuario'': G
,''G H!
CodigoHomologacionRol''I ^
,''^ _"
CodigoHomologacionMenu''` v
)''v w
;''w x
}(( 	
public** 
List** 
<** 
	EventUser** 
>** 
GetEventAll** *
(*** +
string**+ 1
report**2 8
,**8 9
DateOnly**: B
fini**C G
,**G H
DateOnly**I Q
ffin**R V
)**V W
{++ 	
return,, $
_eventTrackingRepository,, +
.,,+ ,
GetEventAll,,, 7
(,,7 8
report,,8 >
,,,> ?
fini,,@ D
,,,D E
ffin,,F J
),,J K
;,,K L
}-- 	
public// 
List// 
<// 
FiltrosMasUsadoDto// &
>//& ' 
GetEventFiltroMasUsa//( <
(//< =
)//= >
{00 	
return11 $
_eventTrackingRepository11 +
.11+ , 
GetEventFiltroMasUsa11, @
(11@ A
)11A B
;11B C
}22 	
public44 
List44 
<44 !
PaginasMasVisitadaDto44 )
>44) *
GetEventPagMasVisit44+ >
(44> ?
)44? @
{55 	
return66 $
_eventTrackingRepository66 +
.66+ ,
GetEventPagMasVisit66, ?
(66? @
)66@ A
;66A B
}77 	
public99 
List99 
<99 %
VwEventTrackingSessionDto99 -
>99- .
GetEventSession99/ >
(99> ?
)99? @
{:: 	
return;; $
_eventTrackingRepository;; +
.;;+ ,
GetEventSession;;, ;
(;;; <
);;< =
;;;= >
}<< 	
public>> 
List>> 
<>> 
VwEventUserAll>> "
>>>" #
GetEventUserAll>>$ 3
(>>3 4
)>>4 5
{?? 	
return@@ $
_eventTrackingRepository@@ +
.@@+ ,
GetEventUserAll@@, ;
(@@; <
)@@< =
;@@= >
}AA 	
}BB 
}CC º,
EC:\Users\Dell\source\repos\BuscadorCan\Core\Service\EsquemaService.cs
	namespace 	
Core
 
. 
Service 
{ 
public 

class 
EsquemaService 
:  !
IEsquemaService" 1
{ 
private		 
readonly		 
IEsquemaRepository		 +
_esquemaRepository		, >
;		> ?
public 
EsquemaService 
( 
IEsquemaRepository 0
esquemaRepository1 B
)B C
{ 	
this 
. 
_esquemaRepository #
=$ %
esquemaRepository& 7
;7 8
} 	
public 
bool 
Create 
( 
Esquema "
data# '
)' (
{ 	
return 
_esquemaRepository $
.$ %
Create% +
(+ ,
data, 0
)0 1
;1 2
} 	
public 
bool #
CreateEsquemaValidacion +
(+ ,
EsquemaVista, 8
data9 =
)= >
{ 	
return 
_esquemaRepository %
.% &#
CreateEsquemaValidacion& =
(= >
data> B
)B C
;C D
} 	
public 
bool ;
/EliminarEsquemaVistaColumnaByIdEquemaVistaAsync C
(C D
intD G
idH J
)J K
{ 	
return 
_esquemaRepository %
.% &;
/EliminarEsquemaVistaColumnaByIdEquemaVistaAsync& U
(U V
idV X
)X Y
;Y Z
} 	
public 
List 
< 
Esquema 
> 
FindAll $
($ %
)% &
{ 	
return   
_esquemaRepository   $
.  $ %
FindAll  % ,
(  , -
)  - .
;  . /
}!! 	
public## 
List## 
<## 
Esquema## 
>## 
FindAllWithViews## -
(##- .
)##. /
{$$ 	
return%% 
_esquemaRepository%% $
.%%$ %
FindAllWithViews%%% 5
(%%5 6
)%%6 7
;%%7 8
}&& 	
public(( 
Esquema(( 
?(( 
FindById((  
(((  !
int((! $
Id((% '
)((' (
{)) 	
return** 
_esquemaRepository** $
.**$ %
FindById**% -
(**- .
Id**. 0
)**0 1
;**1 2
}++ 	
public-- 
Esquema-- 
?-- 
FindByViewName-- &
(--& '
string--' -
esquemaVista--. :
)--: ;
{.. 	
return// 
_esquemaRepository// $
.//$ %
FindByViewName//% 3
(//3 4
esquemaVista//4 @
)//@ A
;//A B
}00 	
public22 
Task22 
<22 
Esquema22 
?22 
>22 
FindByViewNameAsync22 1
(221 2
string222 8
esquemaVista229 E
)22E F
{33 	
return44 
_esquemaRepository44 %
.44% &
FindByViewNameAsync44& 9
(449 :
esquemaVista44: F
)44F G
;44G H
}55 	
public77 
EsquemaVistaColumna77 "
?77" #6
*GetEsquemaVistaColumnaByIdEquemaVistaAsync77$ N
(77N O
int77O R
idOna77S X
,77X Y
int77Z ]
	idEsquema77^ g
)77g h
{88 	
return99 
_esquemaRepository99 %
.99% &6
*GetEsquemaVistaColumnaByIdEquemaVistaAsync99& P
(99P Q
idOna99Q V
,99V W
	idEsquema99X a
)99a b
;99b c
}:: 	
public<< 
List<< 
<<< 
Esquema<< 
><<  
GetListaEsquemaByOna<< 1
(<<1 2
int<<2 5
idONA<<6 ;
)<<; <
{== 	
return>> 
_esquemaRepository>> $
.>>$ % 
GetListaEsquemaByOna>>% 9
(>>9 :
idONA>>: ?
)>>? @
;>>@ A
}?? 	
publicAA 
boolAA +
GuardarListaEsquemaVistaColumnaAA 3
(AA3 4
ListAA4 8
<AA8 9
EsquemaVistaColumnaAA9 L
>AAL M$
listaEsquemaVistaColumnaAAN f
,AAf g
intAAh k
?AAk l
idOnaAAm r
,AAr s
intAAt w
?AAw x
intidEsquema	AAy Ö
)
AAÖ Ü
{BB 	
returnCC 
_esquemaRepositoryCC %
.CC% &+
GuardarListaEsquemaVistaColumnaCC& E
(CCE F$
listaEsquemaVistaColumnaCCF ^
,CC^ _
idOnaCC` e
,CCe f
intidEsquemaCCg s
)CCs t
;CCt u
}DD 	
publicFF 
boolFF 
UpdateFF 
(FF 
EsquemaFF "
dataFF# '
)FF' (
{GG 	
returnHH 
_esquemaRepositoryHH $
.HH$ %
UpdateHH% +
(HH+ ,
dataHH, 0
)HH0 1
;HH1 2
}II 	
publicKK 
boolKK #
UpdateEsquemaValidacionKK +
(KK+ ,
EsquemaVistaKK, 8
dataKK9 =
)KK= >
{LL 	
returnMM 
_esquemaRepositoryMM %
.MM% &#
UpdateEsquemaValidacionMM& =
(MM= >
dataMM> B
)MMB C
;MMC D
}NN 	
}OO 
}PP ≠J
CC:\Users\Dell\source\repos\BuscadorCan\Core\Service\EmailService.cs
	namespace 	
Core
 
. 
Service 
{		 
public 

class 
EmailService 
: 
IEmailService  -
{ 
private 
readonly 
IGmailClientFactory ,
_gmailClientFactory- @
;@ A
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
private 
readonly 
ILogger  
<  !
EmailService! -
>- .
_logger/ 6
;6 7
public'' 
EmailService'' 
('' 
IGmailClientFactory'' /
gmailClientFactory''0 B
,''B C
IConfiguration(( *
configuration((+ 8
,((8 9
ILogger)) #
<))# $
EmailService))$ 0
>))0 1
logger))2 8
)++ 
{,, 	
_gmailClientFactory-- 
=--  !
gmailClientFactory--" 4
;--4 5
_configuration.. 
=.. 
configuration.. *
;..* +
_logger// 
=// 
logger// 
;// 
}11 	
public44 
async44 
Task44 
<44 
bool44 
>44 
SendEmailAsync44  .
(44. /
string44/ 5
to446 8
,448 9
string44: @
subject44A H
,44H I
string44J P
body44Q U
)44U V
{55 	
try66 
{77 
var99 
gmailService99  
=99! "
await99# (
_gmailClientFactory99) <
.99< =#
CreateGmailServiceAsync99= T
(99T U
)99U V
;99V W
var<< 
message<< 
=<< 
new<< !
MimeMessage<<" -
(<<- .
)<<. /
;<</ 0
message== 
.== 
From== 
.== 
Add==  
(==  !
new==! $
MailboxAddress==% 3
(==3 4
_configuration==4 B
[==B C
$str==C X
]==X Y
,==Y Z
_configuration==[ i
[==i j
$str	==j Ä
]
==Ä Å
??
==Ç Ñ
throw
==Ö ä
new
==ã é'
InvalidOperationException
==è ®
(
==® ©
$str
==© ø
)
==ø ¿
)
==¿ ¡
)
==¡ ¬
;
==¬ √
message@@ 
.@@ 
To@@ 
.@@ 
Add@@ 
(@@ 
new@@ "
MailboxAddress@@# 1
(@@1 2
to@@2 4
,@@4 5
to@@6 8
)@@8 9
)@@9 :
;@@: ;
messageAA 
.AA 
SubjectAA 
=AA  !
subjectAA" )
;AA) *
varBB 
textPartBB 
=BB 
newBB "
TextPartBB# +
(BB+ ,
$strBB, 2
)BB2 3
{CC 
TextDD 
=DD 
bodyDD 
,DD  #
ContentTransferEncodingEE +
=EE, -
ContentEncodingEE. =
.EE= >
Base64EE> D
}FF 
;FF 
messageHH 
.HH 
BodyHH 
=HH 
textPartHH '
;HH' (
varKK 

rawMessageKK 
=KK  
Base64UrlEncodeKK! 0
(KK0 1
messageKK1 8
.KK8 9
ToStringKK9 A
(KKA B
)KKB C
)KKC D
;KKD E
varNN 
gmailMessageNN  
=NN! "
newNN# &
MessageNN' .
{OO 
RawPP 
=PP 

rawMessagePP $
}QQ 
;QQ 
awaitSS 
gmailServiceSS "
.SS" #
UsersSS# (
.SS( )
MessagesSS) 1
.SS1 2
SendSS2 6
(SS6 7
gmailMessageSS7 C
,SSC D
$strSSE I
)SSI J
.SSJ K
ExecuteAsyncSSK W
(SSW X
)SSX Y
;SSY Z
returnTT 
trueTT 
;TT 
}UU 
catchVV 
(VV 
	ExceptionVV 
exVV 
)VV  
{WW 
_loggerXX 
.XX 
LogErrorXX  
(XX  !
exXX! #
,XX# $
$strXX% J
,XXJ K
toXXL N
)XXN O
;XXO P
returnYY 
falseYY 
;YY 
}ZZ 
}[[ 	
public^^ 
async^^ 
Task^^ 
<^^ 
bool^^ 
>^^ 
SendManyEmailAsync^^  2
(^^2 3
string^^3 9
to^^: <
,^^< =
string^^> D
subject^^E L
,^^L M
string^^N T
body^^U Y
)^^Y Z
{__ 	
try`` 
{aa 
varcc 
gmailServicecc  
=cc! "
awaitcc# (
_gmailClientFactorycc) <
.cc< =#
CreateGmailServiceAsynccc= T
(ccT U
)ccU V
;ccV W
varff 
messageff 
=ff 
newff !
MimeMessageff" -
(ff- .
)ff. /
;ff/ 0
messagegg 
.gg 
Fromgg 
.gg 
Addgg  
(gg  !
newgg! $
MailboxAddressgg% 3
(gg3 4
_configurationgg4 B
[ggB C
$strggC X
]ggX Y
,ggY Z
_configurationgg[ i
[ggi j
$str	ggj Ä
]
ggÄ Å
??
ggÇ Ñ
throw
ggÖ ä
new
ggã é'
InvalidOperationException
ggè ®
(
gg® ©
$str
gg© ø
)
ggø ¿
)
gg¿ ¡
)
gg¡ ¬
;
gg¬ √
varii 
listaReceptoresii #
=ii$ %
toii& (
.ii( )
Splitii) .
(ii. /
$charii/ 2
)ii2 3
;ii3 4
foreachjj 
(jj 
stringjj 
	direccionjj  )
injj* ,
listaReceptoresjj- <
)jj< =
{kk 
messagell 
.ll 
Toll 
.ll 
Addll "
(ll" #
newll# &
MailboxAddressll' 5
(ll5 6
	direccionll6 ?
.ll? @
Trimll@ D
(llD E
)llE F
,llF G
	direccionllH Q
.llQ R
TrimllR V
(llV W
)llW X
)llX Y
)llY Z
;llZ [
}mm 
messagenn 
.nn 
Subjectnn 
=nn  !
subjectnn" )
;nn) *
varoo 
textPartoo 
=oo 
newoo "
TextPartoo# +
(oo+ ,
$stroo, 2
)oo2 3
{pp 
Textqq 
=qq 
bodyqq 
,qq  #
ContentTransferEncodingrr +
=rr, -
ContentEncodingrr. =
.rr= >
Base64rr> D
}ss 
;ss 
messageuu 
.uu 
Bodyuu 
=uu 
textPartuu '
;uu' (
varxx 

rawMessagexx 
=xx  
Base64UrlEncodexx! 0
(xx0 1
messagexx1 8
.xx8 9
ToStringxx9 A
(xxA B
)xxB C
)xxC D
;xxD E
var{{ 
gmailMessage{{  
={{! "
new{{# &
Message{{' .
{|| 
Raw}} 
=}} 

rawMessage}} $
}~~ 
;~~ 
await
ÄÄ 
gmailService
ÄÄ "
.
ÄÄ" #
Users
ÄÄ# (
.
ÄÄ( )
Messages
ÄÄ) 1
.
ÄÄ1 2
Send
ÄÄ2 6
(
ÄÄ6 7
gmailMessage
ÄÄ7 C
,
ÄÄC D
$str
ÄÄE I
)
ÄÄI J
.
ÄÄJ K
ExecuteAsync
ÄÄK W
(
ÄÄW X
)
ÄÄX Y
;
ÄÄY Z
return
ÅÅ 
true
ÅÅ 
;
ÅÅ 
}
ÇÇ 
catch
ÉÉ 
(
ÉÉ 
	Exception
ÉÉ 
ex
ÉÉ 
)
ÉÉ  
{
ÑÑ 
_logger
ÖÖ 
.
ÖÖ 
LogError
ÖÖ  
(
ÖÖ  !
ex
ÖÖ! #
,
ÖÖ# $
$str
ÖÖ% J
,
ÖÖJ K
to
ÖÖL N
)
ÖÖN O
;
ÖÖO P
return
ÜÜ 
false
ÜÜ 
;
ÜÜ 
}
áá 
}
àà 	
private
èè 
static
èè 
string
èè 
Base64UrlEncode
èè -
(
èè- .
string
èè. 4
input
èè5 :
)
èè: ;
{
êê 	
var
ëë 
bytes
ëë 
=
ëë 
System
ëë 
.
ëë 
Text
ëë #
.
ëë# $
Encoding
ëë$ ,
.
ëë, -
UTF8
ëë- 1
.
ëë1 2
GetBytes
ëë2 :
(
ëë: ;
input
ëë; @
)
ëë@ A
;
ëëA B
var
íí 
base64
íí 
=
íí 
Convert
íí  
.
íí  !
ToBase64String
íí! /
(
íí/ 0
bytes
íí0 5
)
íí5 6
;
íí6 7
return
ìì 
base64
ìì 
.
ìì 
Replace
ìì !
(
ìì! "
$char
ìì" %
,
ìì% &
$char
ìì' *
)
ìì* +
.
ìì+ ,
Replace
ìì, 3
(
ìì3 4
$char
ìì4 7
,
ìì7 8
$char
ìì9 <
)
ìì< =
.
ìì= >
TrimEnd
ìì> E
(
ììE F
$char
ììF I
)
ììI J
;
ììJ K
}
îî 	
}
ññ 
}óó Ä
EC:\Users\Dell\source\repos\BuscadorCan\Core\Service\DynamicService.cs
	namespace 	
Core
 
. 
Service 
{ 
public 

class 
DynamicService 
:  !
IDynamicService" 1
{		 
private

 
readonly

 
IDynamicRepository

 +
_dynamicRepository

, >
;

> ?
public 
DynamicService 
( 
IDynamicRepository 0
dynamicRepository1 B
)B C
{ 	
this 
. 
_dynamicRepository #
=$ %
dynamicRepository& 7
;7 8
} 	
public 
ONAConexion 
GetConexion &
(& '
int' *
idONA+ 0
)0 1
{ 	
return 
_dynamicRepository $
.$ %
GetConexion% 0
(0 1
idONA1 6
)6 7
;7 8
} 	
public 
List 
< 
EsquemaVistaDto #
># $%
GetListaValidacionEsquema% >
(> ?
int? B
idONAC H
,H I
intJ M
idEsquemaVistaN \
)\ ]
{ 	
return 
_dynamicRepository %
.% &%
GetListaValidacionEsquema& ?
(? @
idONA@ E
,E F
idEsquemaVistaG U
)U V
;V W
} 	
public 
List 
< 
PropiedadesTablaDto '
>' (
GetProperties) 6
(6 7
int7 :
idONA; @
,@ A
stringB H
viewNameI Q
)Q R
{ 	
return 
_dynamicRepository $
.$ %
GetProperties% 2
(2 3
idONA3 8
,8 9
viewName: B
)B C
;C D
} 	
public 
List 
< 
PropiedadesTablaDto '
>' (
GetValueColumna) 8
(8 9
int9 <
idONA= B
,B C
stringD J
valueColumnK V
,V W
stringX ^
viewName_ g
)g h
{   	
return!! 
_dynamicRepository!! $
.!!$ %
GetValueColumna!!% 4
(!!4 5
idONA!!5 :
,!!: ;
valueColumn!!< G
,!!G H
viewName!!I Q
)!!Q R
;!!R S
}"" 	
public$$ 
List$$ 
<$$ 
string$$ 
>$$ 
GetViewNames$$ (
($$( )
int$$) ,
idONA$$- 2
)$$2 3
{%% 	
return&& 
_dynamicRepository&& $
.&&$ %
GetViewNames&&% 1
(&&1 2
idONA&&2 7
)&&7 8
;&&8 9
}'' 	
public)) 
Task)) 
<)) 
bool)) 
>)) 
MigrarConexionAsync)) -
())- .
int)). 1
idONA))2 7
)))7 8
{** 	
return++ 
_dynamicRepository++ $
.++$ %
MigrarConexionAsync++% 8
(++8 9
idONA++9 >
)++> ?
;++? @
},, 	
public.. 
bool.. "
TestDatabaseConnection.. *
(..* +
ONAConexion..+ 6
conexion..7 ?
)..? @
{// 	
return00 
_dynamicRepository00 $
.00$ %"
TestDatabaseConnection00% ;
(00; <
conexion00< D
)00D E
;00E F
}11 	
}22 
}33 »*
TC:\Users\Dell\source\repos\BuscadorCan\Core\Service\ConectionStringBuilderService.cs
	namespace 	
Core
 
. 
Service 
{ 
public 

class )
ConectionStringBuilderService .
:/ 0*
IConectionStringBuilderService1 O
{ 
public		 
string		 !
BuildConnectionString		 +
(		+ ,
ONAConexion		, 7
conexion		8 @
)		@ A
{

 	
if 
( 
! 
Enum 
. 
TryParse 
( 
conexion '
.' (
OrigenDatos( 3
,3 4
true5 9
,9 :
out; >
DatabaseType? K
databaseTypeL X
)X Y
)Y Z
{ 
databaseType 
= 
DatabaseType +
.+ ,
	SQLSERVER, 5
;5 6
} 
return 
databaseType 
switch  &
{ 
DatabaseType 
. 
	SQLSERVER &
=>' )*
BuildSqlServerConnectionString* H
(H I
conexionI Q
)Q R
,R S
DatabaseType 
. 
MYSQL "
=># %&
BuildMysqlConnectionString& @
(@ A
conexionA I
)I J
,J K
DatabaseType 
. 
POSTGRES %
=>& ()
BuildPostgresConnectionString) F
(F G
conexionG O
)O P
,P Q
DatabaseType 
. 
SQLLITE $
=>% ''
BuildSqliteConnectionString( C
(C D
conexionD L
)L M
,M N
_ 
=> *
BuildSqlServerConnectionString 3
(3 4
conexion4 <
)< =
} 
; 
} 	
string &
BuildMysqlConnectionString )
() *
ONAConexion* 5
conexion6 >
)> ?
{ 	
string 
sslMode 
= 
$str #
;# $
return 
$" 
$str 
{ 
conexion %
.% &
Host& *
}* +
$str+ ,
", -
+. /
$" 
$str 
{ 
conexion '
.' (
	BaseDatos( 1
}1 2
$str2 3
"3 4
+5 6
$" 
$str 
{ 
conexion "
." #
Usuario# *
}* +
$str+ ,
", -
+. /
$"   
$str   
{   
conexion   "
.  " #
Contrasenia  # .
}  . /
$str  / 0
"  0 1
+  2 3
$"!! 
$str!! 
{!! 
conexion!! #
.!!# $
Puerto!!$ *
}!!* +
$str!!+ ,
"!!, -
+!!. /
$""" 
$str"" 
{"" 
sslMode"" %
}""% &
$str""& '
"""' (
;""( )
}## 	
string%% *
BuildSqlServerConnectionString%% -
(%%- .
ONAConexion%%. 9
conexion%%: B
)%%B C
{&& 	
string'' 

portString'' 
='' 
conexion''  (
.''( )
Puerto'') /
!=''0 2
$num''3 4
?''5 6
$"''7 9
$str''9 :
{'': ;
conexion''; C
.''C D
Puerto''D J
}''J K
"''K L
:''M N
$str''O Q
;''Q R
return(( 
$"(( 
$str(( 
{(( 
conexion(( %
.((% &
Host((& *
}((* +
$str((+ 5
{((5 6
conexion((6 >
.((> ?
	BaseDatos((? H
}((H I
$str((I R
{((R S
conexion((S [
.(([ \
Usuario((\ c
}((c d
$str((d n
{((n o
conexion((o w
.((w x
Contrasenia	((x É
}
((É Ñ
$str
((Ñ °
"
((° ¢
;
((¢ £
})) 	
string++ '
BuildSqliteConnectionString++ *
(++* +
ONAConexion+++ 6
conexion++7 ?
)++? @
{,, 	
return-- 
$"-- 
$str-- !
{--! "
conexion--" *
.--* +
	BaseDatos--+ 4
}--4 5
"--5 6
;--6 7
}.. 	
string00 )
BuildPostgresConnectionString00 ,
(00, -
ONAConexion00- 8
conexion009 A
)00A B
{11 	
return22 
$"22 
$str22 
{22 
conexion22 #
.22# $
Host22$ (
}22( )
$str22) /
{22/ 0
conexion220 8
.228 9
Puerto229 ?
}22? @
$str22@ J
{22J K
conexion22K S
.22S T
	BaseDatos22T ]
}22] ^
$str22^ h
{22h i
conexion22i q
.22q r
Usuario22r y
}22y z
$str	22z Ñ
{
22Ñ Ö
conexion
22Ö ç
.
22ç é
Contrasenia
22é ô
}
22ô ö
$str
22ö õ
"
22õ ú
;
22ú ù
}33 	
}44 
}55 Å
GC:\Users\Dell\source\repos\BuscadorCan\Core\Service\CatalogosService.cs
	namespace 	
Core
 
. 
Service 
{ 
public		 
class		 
CatalogosService		 "
:		# $
ICatalogosService		% 6
{

 
private 
readonly  
ICatalogosRepository - 
_catalogosRepository. B
;B C
private 
readonly 
IMapper  
mapper! '
;' (
public 
CatalogosService 
(   
ICatalogosRepository  4
catalogosRepository5 H
,H I
IMapperJ Q
mapperR X
)X Y
{ 	
this 
.  
_catalogosRepository %
=& '
catalogosRepository( ;
;; <
this 
. 
mapper 
= 
mapper  
;  !
} 	
private 
string  
ObtenerValorPorClave +
(+ ,!
vw_FiltrosAnidadosDto, A
itemB F
,F G
stringH N
claveO T
)T U
{ 	
return 
clave 
switch 
{ 
$str 
=>  
item! %
.% &
KEY_FIL_ONA& 1
,1 2
$str 
=>  
item! %
.% &
KEY_FIL_PAI& 1
,1 2
$str 
=>  
item! %
.% &
KEY_FIL_EST& 1
,1 2
$str 
=>  
item! %
.% &
KEY_FIL_ESQ& 1
,1 2
$str 
=>  
item! %
.% &
KEY_FIL_NOR& 1
,1 2
$str 
=>  
item! %
.% &
KEY_FIL_REC& 1
,1 2
_ 
=> 
string 
. 
Empty !
} 
; 
} 	
public   "
VwHomologacionGrupoDto   %
?  % &
FindVwHGByCode  ' 5
(  5 6
string  6 <
codigoHomologacion  = O
)  O P
{!! 	
VwHomologacionGrupo"" 
?""  
vwHomologacionGrupo""! 4
=""5 6 
_catalogosRepository""7 K
.""K L
FindVwHGByCode""L Z
(""Z [
codigoHomologacion""[ m
)""m n
;""n o
return## 
mapper## 
.## 
Map## 
<## "
VwHomologacionGrupoDto## 4
>##4 5
(##5 6
vwHomologacionGrupo##6 I
)##I J
;##J K
}$$ 	
public&& 
VwRolDto&& 
FindVwRolByHId&& &
(&&& '
int&&' *
idHomologacionRol&&+ <
)&&< =
{'' 	
VwRol(( 
vwRol(( 
=((  
_catalogosRepository(( .
.((. /
FindVwRolByHId((/ =
(((= >
idHomologacionRol((> O
)((O P
;((P Q
return)) 
mapper)) 
.)) 
Map)) 
<)) 
VwRolDto)) &
>))& '
())' (
vwRol))( -
)))- .
;)). /
}** 	
public,, 
List,, 
<,, 
vwFiltroDetalleDto,, &
>,,& '!
ObtenerFiltroDetalles,,( =
(,,= >
string,,> D
codigo,,E K
),,K L
{-- 	
List.. 
<.. 
vwFiltroDetalle..  
>..  !
	vwFiltros.." +
=.., - 
_catalogosRepository... B
...B C!
ObtenerFiltroDetalles..C X
(..X Y
codigo..Y _
).._ `
;..` a
return// 
mapper// 
.// 
Map// 
<// 
List// "
<//" #
vwFiltroDetalleDto//# 5
>//5 6
>//6 7
(//7 8
	vwFiltros//8 A
)//A B
;//B C
}00 	
public22 

Dictionary22 
<22 
string22  
,22  !
List22" &
<22& '!
vw_FiltrosAnidadosDto22' <
>22< =
>22= >"
ObtenerFiltrosAnidados22? U
(22U V
List22V Z
<22Z ['
FiltrosBusquedaSeleccionDto22[ v
>22v w!
filtrosSeleccionados	22x å
)
22å ç
{33 	
List44 
<44 
vw_FiltrosAnidados44 #
>44# $"
vw_FiltrosAnidadosDtos44% ;
=44< = 
_catalogosRepository44> R
.44R S"
ObtenerFiltrosAnidados44S i
(44i j 
filtrosSeleccionados44j ~
)44~ 
;	44 Ä
List55 
<55 !
vw_FiltrosAnidadosDto55 &
>55& '
	resultado55( 1
=552 3
mapper554 :
.55: ;
Map55; >
<55> ?
List55? C
<55C D!
vw_FiltrosAnidadosDto55D Y
>55Y Z
>55Z [
(55[ \"
vw_FiltrosAnidadosDtos55\ r
)55r s
;55s t
var77 
dto77 
=77 
new77 

Dictionary77 $
<77$ %
string77% +
,77+ ,
List77- 1
<771 2!
vw_FiltrosAnidadosDto772 G
>77G H
>77H I
(77I J
)77J K
;77K L
foreach:: 
(:: 
var:: 
key:: 
in:: 
new::  #
[::# $
]::$ %
{::& '
$str::( 5
,::5 6
$str::7 D
,::D E
$str::F S
,::S T
$str::U b
,::b c
$str::d q
,::q r
$str	::s Ä
}
::Å Ç
)
::Ç É
{;; 
var<< 
valores<< 
=<< 
	resultado<< '
.== 
Select== 
(== 
r== 
=>==   
ObtenerValorPorClave==! 5
(==5 6
r==6 7
,==7 8
key==9 <
)==< =
)=== >
.>> 
Where>> 
(>> 
v>> 
=>>> 
!>>  !
string>>! '
.>>' (
IsNullOrWhiteSpace>>( :
(>>: ;
v>>; <
)>>< =
)>>= >
.?? 
Distinct?? 
(?? 
)?? 
.@@ 
ToList@@ 
(@@ 
)@@ 
;@@ 
dtoBB 
[BB 
keyBB 
]BB 
=BB 
valoresBB "
.BB" #
SelectBB# )
(BB) *
valBB* -
=>BB. 0
newBB1 4!
vw_FiltrosAnidadosDtoBB5 J
{CC 
KEY_FIL_ONADD 
=DD  !
keyDD" %
==DD& (
$strDD) 6
?DD7 8
valDD9 <
:DD= >
nullDD? C
,DDC D
KEY_FIL_PAIEE 
=EE  !
keyEE" %
==EE& (
$strEE) 6
?EE7 8
valEE9 <
:EE= >
nullEE? C
,EEC D
KEY_FIL_ESTFF 
=FF  !
keyFF" %
==FF& (
$strFF) 6
?FF7 8
valFF9 <
:FF= >
nullFF? C
,FFC D
KEY_FIL_ESQGG 
=GG  !
keyGG" %
==GG& (
$strGG) 6
?GG7 8
valGG9 <
:GG= >
nullGG? C
,GGC D
KEY_FIL_NORHH 
=HH  !
keyHH" %
==HH& (
$strHH) 6
?HH7 8
valHH9 <
:HH= >
nullHH? C
,HHC D
KEY_FIL_RECII 
=II  !
keyII" %
==II& (
$strII) 6
?II7 8
valII9 <
:II= >
nullII? C
,IIC D
}JJ 
)JJ 
.JJ 
ToListJJ 
(JJ 
)JJ 
;JJ 
}KK 
returnMM 
dtoMM 
;MM 
}NN 	
publicOO 
ListOO 
<OO !
vw_FiltrosAnidadosDtoOO )
>OO) *%
ObtenerFiltrosAnidadosAllOO+ D
(OOD E
)OOE F
{PP 	
ListQQ 
<QQ 
vw_FiltrosAnidadosQQ "
>QQ" #
vw_FiltrosAnidadosQQ$ 6
=QQ7 8 
_catalogosRepositoryQQ9 M
.QQM N%
ObtenerFiltrosAnidadosAllQQN g
(QQg h
)QQh i
;QQi j
returnRR 
mapperRR 
.RR 
MapRR 
<RR 
ListRR "
<RR" #!
vw_FiltrosAnidadosDtoRR# 8
>RR8 9
>RR9 :
(RR: ;
vw_FiltrosAnidadosRR; M
)RRM N
;RRN O
}SS 	
publicUU 
ListUU 
<UU 
HomologacionDtoUU #
>UU# $
ObtenerGruposUU% 2
(UU2 3
)UU3 4
{VV 	
ListWW 
<WW 
HomologacionWW 
>WW 
homologacionesWW -
=WW. / 
_catalogosRepositoryWW0 D
.WWD E
ObtenerGruposWWE R
(WWR S
)WWS T
;WWT U
returnXX 
mapperXX 
.XX 
MapXX 
<XX 
ListXX "
<XX" #
HomologacionDtoXX# 2
>XX2 3
>XX3 4
(XX4 5
homologacionesXX5 C
)XXC D
;XXD E
}YY 	
public[[ 
List[[ 
<[[ 
OnaDto[[ 
>[[ 

ObtenerOna[[ &
([[& '
)[[' (
{\\ 	
List]] 
<]] 
ONA]] 
>]] 
oNAs]] 
=]]  
_catalogosRepository]] 0
.]]0 1

ObtenerOna]]1 ;
(]]; <
)]]< =
;]]= >
return^^ 
mapper^^ 
.^^ 
Map^^ 
<^^ 
List^^ "
<^^" #
OnaDto^^# )
>^^) *
>^^* +
(^^+ ,
oNAs^^, 0
)^^0 1
;^^1 2
}__ 	
publicaa 
Listaa 
<aa 
VwDimensionDtoaa "
>aa" #
ObtenerVwDimensionaa$ 6
(aa6 7
)aa7 8
{bb 	
Listcc 
<cc 
VwDimensioncc 
>cc 
vwDimensionscc )
=cc* + 
_catalogosRepositorycc, @
.cc@ A
ObtenerVwDimensionccA S
(ccS T
)ccT U
;ccU V
returndd 
mapperdd 
.dd 
Mapdd 
<dd 
Listdd "
<dd" #
VwDimensionDtodd# 1
>dd1 2
>dd2 3
(dd3 4
vwDimensionsdd4 @
)dd@ A
;ddA B
}ee 	
publicgg 
Listgg 
<gg  
vwEsquemaOrganizaDtogg (
>gg( )$
ObtenervwEsquemaOrganizagg* B
(ggB C
)ggC D
{hh 	
Listii 
<ii 
vwEsquemaOrganizaii "
>ii" #!
vwEsquemaOrganizaDtosii$ 9
=ii: ; 
_catalogosRepositoryii< P
.iiP Q$
ObtenervwEsquemaOrganizaiiQ i
(iii j
)iij k
;iik l
returnjj 
mapperjj 
.jj 
Mapjj 
<jj 
Listjj "
<jj" # 
vwEsquemaOrganizaDtojj# 7
>jj7 8
>jj8 9
(jj9 :!
vwEsquemaOrganizaDtosjj: O
)jjO P
;jjP Q
}kk 	
publicmm 
Listmm 
<mm 
VwFiltroDtomm 
>mm  
ObtenerVwFiltromm! 0
(mm0 1
)mm1 2
{nn 	
Listoo 
<oo 
VwFiltrooo 
>oo 
	vwFiltrosoo #
=oo$ % 
_catalogosRepositoryoo& :
.oo: ;
ObtenerVwFiltrooo; J
(ooJ K
)ooK L
;ooL M
returnpp 
mapperpp 
.pp 
Mappp 
<pp 
Listpp "
<pp" #
VwFiltroDtopp# .
>pp. /
>pp/ 0
(pp0 1
	vwFiltrospp1 :
)pp: ;
;pp; <
}qq 	
publicss 
Listss 
<ss 
VwGrillaDtoss 
>ss  
ObtenerVwGrillass! 0
(ss0 1
)ss1 2
{tt 	
Listuu 
<uu 
VwGrillauu 
>uu 
	vwGrillasuu $
=uu% & 
_catalogosRepositoryuu' ;
.uu; <
ObtenerVwGrillauu< K
(uuK L
)uuL M
;uuM N
returnvv 
mappervv 
.vv 
Mapvv 
<vv 
Listvv "
<vv" #
VwGrillaDtovv# .
>vv. /
>vv/ 0
(vv0 1
	vwGrillasvv1 :
)vv: ;
;vv; <
}ww 	
publicyy 
Listyy 
<yy "
VwHomologacionGrupoDtoyy *
>yy* +&
ObtenerVwHomologacionGrupoyy, F
(yyF G
)yyG H
{zz 	
List{{ 
<{{ 
VwHomologacionGrupo{{ #
>{{# $#
vwHomologacionGrupoDtos{{% <
={{= > 
_catalogosRepository{{? S
.{{S T&
ObtenerVwHomologacionGrupo{{T n
({{n o
){{o p
;{{p q
return|| 
mapper|| 
.|| 
Map|| 
<|| 
List|| "
<||" #"
VwHomologacionGrupoDto||# 9
>||9 :
>||: ;
(||; <#
vwHomologacionGrupoDtos||< S
)||S T
;||T U
}}} 	
public 
List 
< 
	VwMenuDto 
> 
ObtenerVwMenu ,
(, -
)- .
{
ÄÄ 	
List
ÅÅ 
<
ÅÅ 
VwMenu
ÅÅ 
>
ÅÅ 
vwMenus
ÅÅ 
=
ÅÅ  !"
_catalogosRepository
ÅÅ" 6
.
ÅÅ6 7
ObtenerVwMenu
ÅÅ7 D
(
ÅÅD E
)
ÅÅE F
;
ÅÅF G
return
ÇÇ 
mapper
ÇÇ 
.
ÇÇ 
Map
ÇÇ 
<
ÇÇ 
List
ÇÇ "
<
ÇÇ" #
	VwMenuDto
ÇÇ# ,
>
ÇÇ, -
>
ÇÇ- .
(
ÇÇ. /
vwMenus
ÇÇ/ 6
)
ÇÇ6 7
;
ÇÇ7 8
}
ÉÉ 	
public
ÖÖ 
List
ÖÖ 
<
ÖÖ 
vwONADto
ÖÖ 
>
ÖÖ 
ObtenervwOna
ÖÖ *
(
ÖÖ* +
)
ÖÖ+ ,
{
ÜÜ 	
List
áá 
<
áá 
vwONA
áá 
>
áá 
vwONAs
áá 
=
áá  "
_catalogosRepository
áá! 5
.
áá5 6
ObtenervwOna
áá6 B
(
ááB C
)
ááC D
;
ááD E
return
àà 
mapper
àà 
.
àà 
Map
àà 
<
àà 
List
àà "
<
àà" #
vwONADto
àà# +
>
àà+ ,
>
àà, -
(
àà- .
vwONAs
àà. 4
)
àà4 5
;
àà5 6
}
ââ 	
public
ãã 
List
ãã 
<
ãã 
vwPanelONADto
ãã !
>
ãã! "
ObtenerVwPanelOna
ãã# 4
(
ãã4 5
)
ãã5 6
{
åå 	
List
çç 
<
çç 

vwPanelONA
çç 
>
çç 
vwPanelONAs
çç '
=
çç( )"
_catalogosRepository
çç* >
.
çç> ?
ObtenerVwPanelOna
çç? P
(
ççP Q
)
ççQ R
;
ççR S
return
éé 
mapper
éé 
.
éé 
Map
éé 
<
éé 
List
éé "
<
éé" #
vwPanelONADto
éé# 0
>
éé0 1
>
éé1 2
(
éé2 3
vwPanelONAs
éé3 >
)
éé> ?
;
éé? @
}
èè 	
public
ëë 
List
ëë 
<
ëë 
VwRolDto
ëë 
>
ëë 
ObtenerVwRol
ëë *
(
ëë* +
)
ëë+ ,
{
íí 	
List
ìì 
<
ìì 
VwRol
ìì 
>
ìì 
vwRols
ìì 
=
ìì  "
_catalogosRepository
ìì! 5
.
ìì5 6
ObtenerVwRol
ìì6 B
(
ììB C
)
ììC D
;
ììD E
return
îî 
mapper
îî 
.
îî 
Map
îî 
<
îî 
List
îî "
<
îî" #
VwRolDto
îî# +
>
îî+ ,
>
îî, -
(
îî- .
vwRols
îî. 4
)
îî4 5
;
îî5 6
}
ïï 	
}
ññ 
}óó ≤q
FC:\Users\Dell\source\repos\BuscadorCan\Core\Service\BuscadorService.cs
	namespace 	
Core
 
. 
Service 
{ 
public 

class 
BuscadorService  
:! "
IBuscadorService# 3
{ 
private 
readonly 
IBuscadorRepository ,
_buscadorRepository- @
;@ A
public 
BuscadorService 
( 
IBuscadorRepository 2
buscadorRepository3 E
)E F
{ 	
this 
. 
_buscadorRepository $
=% &
buscadorRepository' 9
;9 :
} 	
private 
async 
Task 
< 
IpLocationDto (
>( )
GetIpLocationInfo* ;
(; <
string< B
	ipAddressC L
)L M
{ 	
try 
{ 
if 
( 
string 
. 
IsNullOrEmpty (
(( )
	ipAddress) 2
)2 3
||4 6
	ipAddress7 @
==A C
$strD I
)I J
return 
new 
IpLocationDto ,
{- .
Country/ 6
=7 8
$str9 @
,@ A
CityB F
=G H
$strI P
,P Q
IspR U
=V W
$strX _
}` a
;a b
using 
var 

httpClient $
=% &
new' *

HttpClient+ 5
(5 6
)6 7
;7 8
var 
response 
= 
await $

httpClient% /
./ 0
GetStringAsync0 >
(> ?
$"? A
$strA X
{X Y
	ipAddressY b
}b c
"c d
)d e
;e f
return   
JsonSerializer   %
.  % &
Deserialize  & 1
<  1 2
IpLocationDto  2 ?
>  ? @
(  @ A
response  A I
)  I J
??  K M
new  N Q
(  Q R
)  R S
;  S T
}!! 
catch"" 
{## 
return$$ 
new$$ 
IpLocationDto$$ (
{$$) *
Country$$+ 2
=$$3 4
$str$$5 B
,$$B C
City$$D H
=$$I J
$str$$K X
,$$X Y
Isp$$Z ]
=$$^ _
$str$$` m
}$$n o
;$$o p
}%% 
}&& 	
public'' 
int'' 
AddEventTracking'' #
(''# $
EventTrackingDto''$ 4
eventTracking''5 B
,''B C
string''D J
	ipAddress''K T
)''T U
{(( 	
var** 
ipInfo** 
=** 
GetIpLocationInfo** *
(*** +
	ipAddress**+ 4
)**4 5
.**5 6
Result**6 <
;**< =
eventTracking,, 
.,, 
UbicacionJson,, '
=,,( )
JsonSerializer,,* 8
.,,8 9
	Serialize,,9 B
(,,B C
new,,C F
{-- 
	IpAddress.. 
=.. 
	ipAddress.. %
,..% &
ipInfo// 
.// 
Country// 
,// 
ipInfo00 
.00 
City00 
,00 
ipInfo11 
.11 
Isp11 
}22 
)22 
;22 
return44 
_buscadorRepository44 &
.44& '
AddEventTracking44' 7
(447 8
eventTracking448 E
)44E F
;44F G
}55 	
public77  
fnEsquemaCabeceraDto77 #
?77# $
FnEsquemaCabecera77% 6
(776 7
int777 :
IdEsquemadata77; H
)77H I
{88 	
return99 
_buscadorRepository99 &
.99& '
FnEsquemaCabecera99' 8
(998 9
IdEsquemadata999 F
)99F G
;99G H
}:: 	
public<< 
List<< 
<<< #
FnEsquemaDataBuscadoDto<< +
><<+ ,
FnEsquemaDatoBuscar<<- @
(<<@ A
int<<A D
IdEsquemaData<<E R
,<<R S
string<<T Z
TextoBuscar<<[ f
)<<f g
{== 	
return>> 
_buscadorRepository>> &
.>>& '
FnEsquemaDatoBuscar>>' :
(>>: ;
IdEsquemaData>>; H
,>>H I
TextoBuscar>>J U
)>>U V
;>>V W
}?? 	
publicAA 
FnEsquemaDtoAA 
?AA !
FnHomologacionEsquemaAA 2
(AA2 3
intAA3 6!
idHomologacionEsquemaAA7 L
)AAL M
{BB 	
returnCC 
_buscadorRepositoryCC &
.CC& '!
FnHomologacionEsquemaCC' <
(CC< =!
idHomologacionEsquemaCC= R
)CCR S
;CCS T
}DD 	
publicFF 
ListFF 
<FF (
FnHomologacionEsquemaDataDtoFF 0
>FF0 1%
FnHomologacionEsquemaDatoFF2 K
(FFK L
intFFL O
	idEsquemaFFP Y
,FFY Z
stringFF[ a
VistaFKFFb i
,FFi j
intFFk n
idOnaFFo t
)FFt u
{GG 	
returnHH 
_buscadorRepositoryHH &
.HH& '%
FnHomologacionEsquemaDatoHH' @
(HH@ A
	idEsquemaHHA J
,HHJ K
VistaFKHHL S
,HHS T
idOnaHHU Z
)HHZ [
;HH[ \
}II 	
publicKK 
ListKK 
<KK 

EsquemaDtoKK 
>KK %
FnHomologacionEsquemaTodoKK  9
(KK9 :
stringKK: @
VistaFKKKA H
,KKH I
intKKJ M
idOnaKKN S
)KKS T
{LL 	
returnMM 
_buscadorRepositoryMM &
.MM& '%
FnHomologacionEsquemaTodoMM' @
(MM@ A
VistaFKMMA H
,MMH I
idOnaMMJ O
)MMO P
;MMP Q
}NN 	
publicPP 
ListPP 
<PP 
FnPredictWordsDtoPP %
>PP% &
FnPredictWordsPP' 5
(PP5 6
stringPP6 <
wordPP= A
)PPA B
{QQ 	
returnRR 
_buscadorRepositoryRR &
.RR& '
FnPredictWordsRR' 5
(RR5 6
wordRR6 :
)RR: ;
;RR; <
}SS 	
publicUU 
BuscadorDtoUU 
PsBuscarPalabraUU *
(UU* +
stringUU+ 1
	paramJSONUU2 ;
,UU; <
intUU= @

PageNumberUUA K
,UUK L
intUUM P
RowsPerPageUUQ \
)UU\ ]
{VV 	
returnWW 
_buscadorRepositoryWW &
.WW& '
PsBuscarPalabraWW' 6
(WW6 7
	paramJSONWW7 @
,WW@ A

PageNumberWWB L
,WWL M
RowsPerPageWWN Y
)WWY Z
;WWZ [
}XX 	
publicZZ 
boolZZ 
ValidateWordsZZ !
(ZZ! "
ListZZ" &
<ZZ& '
stringZZ' -
>ZZ- .
wordsZZ/ 4
)ZZ4 5
{[[ 	
return\\ 
_buscadorRepository\\ &
.\\& '
ValidateWords\\' 4
(\\4 5
words\\5 :
)\\: ;
;\\; <
}]] 	
public__ 
async__ 
Task__ 
<__ 
string__  
>__  !
GetCoordinates__" 0
(__0 1
string__1 7
address__8 ?
)__? @
{`` 	
varbb 
apiKeybb 
=bb 
$strbb B
;bbB C
varcc 
urlcc 
=cc 
$"cc 
$strcc R
{ccR S
UriccS V
.ccV W
EscapeDataStringccW g
(ccg h
addresscch o
)cco p
}ccp q
$strccq v
{ccv w
apiKeyccw }
}cc} ~
"cc~ 
;	cc Ä
usingdd 
vardd 

httpClientdd  
=dd! "
newdd# &

HttpClientdd' 1
(dd1 2
)dd2 3
;dd3 4
returnee 
awaitee 

httpClientee #
.ee# $
GetStringAsyncee$ 2
(ee2 3
urlee3 6
)ee6 7
;ee7 8
}ff 	
publichh 
bytehh 
[hh 
]hh 
ExportExcelhh !
(hh! "
Listhh" &
<hh& '

Dictionaryhh' 1
<hh1 2
stringhh2 8
,hh8 9
stringhh: @
>hh@ A
>hhA B
datahhC G
)hhG H
{ii 	
ExcelPackagejj 
.jj 
LicenseContextjj '
=jj( )
LicenseContextjj* 8
.jj8 9
NonCommercialjj9 F
;jjF G
usingkk 
varkk 
packagekk 
=kk 
newkk  #
ExcelPackagekk$ 0
(kk0 1
)kk1 2
;kk2 3
varll 
wsll 
=ll 
packagell 
.ll 
Workbookll %
.ll% &

Worksheetsll& 0
.ll0 1
Addll1 4
(ll4 5
$strll5 <
)ll< =
;ll= >
varnn 
headersnn 
=nn 
datann 
[nn 
$numnn  
]nn  !
.nn! "
Keysnn" &
.nn& '
ToListnn' -
(nn- .
)nn. /
;nn/ 0
foroo 
(oo 
intoo 
ioo 
=oo 
$numoo 
;oo 
ioo 
<oo 
headersoo  '
.oo' (
Countoo( -
;oo- .
ioo/ 0
++oo0 2
)oo2 3
wsoo4 6
.oo6 7
Cellsoo7 <
[oo< =
$numoo= >
,oo> ?
ioo@ A
+ooB C
$numooD E
]ooE F
.ooF G
ValueooG L
=ooM N
headersooO V
[ooV W
iooW X
]ooX Y
;ooY Z
forqq 
(qq 
intqq 
iqq 
=qq 
$numqq 
;qq 
iqq 
<qq 
dataqq  $
.qq$ %
Countqq% *
;qq* +
iqq, -
++qq- /
)qq/ 0
forrr 
(rr 
intrr 
jrr 
=rr 
$numrr 
;rr 
jrr  !
<rr" #
headersrr$ +
.rr+ ,
Countrr, 1
;rr1 2
jrr3 4
++rr4 6
)rr6 7
wsss 
.ss 
Cellsss 
[ss 
iss 
+ss  
$numss! "
,ss" #
jss$ %
+ss& '
$numss( )
]ss) *
.ss* +
Valuess+ 0
=ss1 2
datass3 7
[ss7 8
iss8 9
]ss9 :
[ss: ;
headersss; B
[ssB C
jssC D
]ssD E
]ssE F
;ssF G
returntt 
packagett 
.tt 
GetAsByteArraytt )
(tt) *
)tt* +
;tt+ ,
}uu 	
publicww 
byteww 
[ww 
]ww 
	ExportPdfww 
(ww  
Listww  $
<ww$ %

Dictionaryww% /
<ww/ 0
stringww0 6
,ww6 7
stringww8 >
>ww> ?
>ww? @
datawwA E
)wwE F
{xx 	
usingyy 
varyy 
streamyy 
=yy 
newyy "
MemoryStreamyy# /
(yy/ 0
)yy0 1
;yy1 2
varzz 
doczz 
=zz 
newzz 
Documentzz "
(zz" #
)zz# $
;zz$ %
	PdfWriter{{ 
.{{ 
GetInstance{{ !
({{! "
doc{{" %
,{{% &
stream{{' -
){{- .
;{{. /
doc|| 
.|| 
Open|| 
(|| 
)|| 
;|| 
if~~ 
(~~ 
data~~ 
.~~ 
Count~~ 
==~~ 
$num~~ 
)~~  
{ 
doc
ÄÄ 
.
ÄÄ 
Add
ÄÄ 
(
ÄÄ 
new
ÄÄ 
	Paragraph
ÄÄ %
(
ÄÄ% &
$str
ÄÄ& B
)
ÄÄB C
)
ÄÄC D
;
ÄÄD E
}
ÅÅ 
else
ÇÇ 
{
ÉÉ 
var
ÑÑ 
headers
ÑÑ 
=
ÑÑ 
data
ÑÑ "
[
ÑÑ" #
$num
ÑÑ# $
]
ÑÑ$ %
.
ÑÑ% &
Keys
ÑÑ& *
.
ÑÑ* +
ToList
ÑÑ+ 1
(
ÑÑ1 2
)
ÑÑ2 3
;
ÑÑ3 4
var
ÖÖ 
table
ÖÖ 
=
ÖÖ 
new
ÖÖ 
	PdfPTable
ÖÖ  )
(
ÖÖ) *
headers
ÖÖ* 1
.
ÖÖ1 2
Count
ÖÖ2 7
)
ÖÖ7 8
;
ÖÖ8 9
foreach
áá 
(
áá 
var
áá 
header
áá #
in
áá$ &
headers
áá' .
)
áá. /
table
àà 
.
àà 
AddCell
àà !
(
àà! "
new
àà" %
PdfPCell
àà& .
(
àà. /
new
àà/ 2
Phrase
àà3 9
(
àà9 :
header
àà: @
)
àà@ A
)
ààA B
{
ààC D
BackgroundColor
ààE T
=
ààU V
	BaseColor
ààW `
.
àà` a

LIGHT_GRAY
ààa k
}
ààl m
)
ààm n
;
ààn o
foreach
ää 
(
ää 
var
ää 
row
ää  
in
ää! #
data
ää$ (
)
ää( )
foreach
ãã 
(
ãã 
var
ãã  
header
ãã! '
in
ãã( *
headers
ãã+ 2
)
ãã2 3
table
åå 
.
åå 
AddCell
åå %
(
åå% &
row
åå& )
.
åå) *
TryGetValue
åå* 5
(
åå5 6
header
åå6 <
,
åå< =
out
åå> A
var
ååB E
v
ååF G
)
ååG H
?
ååI J
v
ååK L
:
ååM N
string
ååO U
.
ååU V
Empty
ååV [
)
åå[ \
;
åå\ ]
doc
éé 
.
éé 
Add
éé 
(
éé 
table
éé 
)
éé 
;
éé 
}
èè 
doc
ëë 
.
ëë 
Close
ëë 
(
ëë 
)
ëë 
;
ëë 
return
ìì 
stream
ìì 
.
ìì 
ToArray
ìì !
(
ìì! "
)
ìì" #
;
ìì# $
}
îî 	
}
ïï 
}ññ ¿µ
JC:\Users\Dell\source\repos\BuscadorCan\Core\Service\AuthenticateService.cs
	namespace		 	
Core		
 
.		 
Service		 
{

 
public 

class 
AuthenticateService $
:% & 
IAuthenticateService' ;
{ 
private 
readonly 
IUsuarioRepository +
_usuarioRepository, >
;> ?
private 
readonly "
IONAConexionRepository /"
_onaConexionRepository0 F
;F G
private 
readonly 
IHashService %
_hashService& 2
;2 3
private 
readonly 
IJwtService $
_jwtService% 0
;0 1
private 
readonly  
ICatalogosRepository - 
_catalogosRepository. B
;B C
private 
readonly $
IEventTrackingRepository 1$
_eventTrackingRepository2 J
;J K
private 
readonly 
IEmailService &
_emailService' 4
;4 5
private 
readonly )
IRandomStringGeneratorService 6#
_randomGeneratorService7 N
;N O
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
public&& 
AuthenticateService&& "
(&&" #
IUsuarioRepository'' 
usuarioRepository'' 0
,''0 1"
IONAConexionRepository(( "!
onaConexionRepository((# 8
,((8 9 
ICatalogosRepository))  
catalogosRepository))! 4
,))4 5$
IEventTrackingRepository** $#
eventTrackingRepository**% <
,**< =)
IRandomStringGeneratorService++ )"
randomGeneratorService++* @
,++@ A
IEmailService,, 
emailService,, &
,,,& '
IHashService-- 
hashService-- $
,--$ %
IJwtService.. 

jwtService.. "
,.." #
IConfiguration// 
configuration// (
)//( )
{00 	
_usuarioRepository11 
=11  
usuarioRepository11! 2
;112 3"
_onaConexionRepository22 "
=22# $!
onaConexionRepository22% :
;22: ; 
_catalogosRepository33  
=33! "
catalogosRepository33# 6
;336 7$
_eventTrackingRepository44 $
=44% &#
eventTrackingRepository44' >
;44> ?#
_randomGeneratorService55 #
=55$ %"
randomGeneratorService55& <
;55< =
_emailService66 
=66 
emailService66 (
;66( )
_hashService77 
=77 
hashService77 &
;77& '
_jwtService88 
=88 

jwtService88 $
;88$ %
_configuration99 
=99 
configuration99 *
;99* +
}:: 	
public<< 
Result<< 
<<< #
AuthenticateResponseDto<< -
><<- .
Authenticate<</ ;
(<<; <#
UsuarioAutenticacionDto<<< S#
usuarioAutenticacionDto<<T k
)<<k l
{== 	
try>> 
{>> 
var?? 
result?? 
=?? 
Authenticate?? )
(??) *#
usuarioAutenticacionDto??* A
.??A B
Email??B G
,??G H#
usuarioAutenticacionDto??I `
.??` a
Clave??a f
)??f g
;??g h
ifAA 
(AA 
!AA 
resultAA 
.AA 
	IsSuccessAA %
)AA% &
{AA' (!
GenerateEventTrackingBB )
(BB) *
dtoBB* -
:BB- .#
usuarioAutenticacionDtoBB/ F
)BBF G
;BBG H
returnCC 
ResultCC !
<CC! "#
AuthenticateResponseDtoCC" 9
>CC9 :
.CC: ;
FailureCC; B
(CCB C
resultCCC I
.CCI J
ErrorMessageCCJ V
)CCV W
;CCW X
}DD 
varFF 
usuarioFF 
=FF 
resultFF $
.FF$ %
ValueFF% *
;FF* +
varGG 
rolGG 
=GG 
GetRolGG  
(GG  !
usuarioGG! (
.GG( )
IdHomologacionRolGG) :
)GG: ;
;GG; <
stringII 
codeII 
=II #
_randomGeneratorServiceII 5
.II5 6!
GenerateTemporaryCodeII6 K
(IIK L
$numIIL M
)IIM N
;IIN O
_JJ 
=JJ 
TaskJJ 
.JJ 
RunJJ 
(JJ 
asyncJJ "
(JJ# $
)JJ$ %
=>JJ& (
{KK 
tryLL 
{MM 
varNN 
htmlBodyNN $
=NN% &-
!GenerateVerificationCodeEmailBodyNN' H
(NNH I
codeNNI M
)NNM N
;NNN O
awaitOO 
_emailServiceOO +
.OO+ ,
SendEmailAsyncOO, :
(OO: ;
usuarioOO; B
.OOB C
EmailOOC H
??OOI K
$strOOL N
,OON O
$strOOP h
,OOh i
htmlBodyOOj r
)OOr s
;OOs t
}PP 
catchQQ 
(QQ 
	ExceptionQQ $
exQQ% '
)QQ' (
{RR 
ConsoleSS 
.SS  
	WriteLineSS  )
(SS) *
$"SS* ,
$strSS, D
{SSD E
exSSE G
.SSG H
MessageSSH O
}SSO P
"SSP Q
)SSQ R
;SSR S
}TT 
}UU 
)UU 
;UU !
GenerateEventTrackingWW %
(WW% &
usuarioWW& -
:WW- .
usuarioWW/ 6
,WW6 7
rolWW8 ;
:WW; <
rolWW= @
,WW@ A
codeWWB F
:WWF G
codeWWH L
)WWL M
;WWM N
returnXX 
ResultXX 
<XX #
AuthenticateResponseDtoXX 5
>XX5 6
.XX6 7
SuccessXX7 >
(XX> ?
newXX? B#
AuthenticateResponseDtoXXC Z
{YY 
	IdUsuarioZZ 
=ZZ 
usuarioZZ  '
.ZZ' (
	IdUsuarioZZ( 1
,ZZ1 2
IdHomologacionRol[[ %
=[[& '
usuario[[( /
.[[/ 0
IdHomologacionRol[[0 A
}\\ 
)\\ 
;\\ 
}]] 
catch]] 
(]] 
	Exception]] 
ex]] !
)]]! "
{]]# $!
GenerateEventTracking^^ %
(^^% &
dto^^& )
:^^) *#
usuarioAutenticacionDto^^+ B
)^^B C
;^^C D
throw__ 
ex__ 
;__ 
}`` 
}aa 	
publicdd 
Resultdd 
<dd ,
 UsuarioAutenticacionRespuestaDtodd 6
>dd6 7
ValidateCodedd8 D
(ddD E
AuthValidationDtoddE V
authValidationDtoddW h
)ddh i
{ee 	
tryff 
{ff 
ifgg 
(gg 
authValidationDtogg %
.gg% &
	IdUsuariogg& /
==gg0 2
$numgg3 4
)gg4 5
{hh !
GenerateEventTrackingii )
(ii) *
dtoii* -
:ii- .
authValidationDtoii/ @
)ii@ A
;iiA B
returnjj 
Resultjj !
<jj! ",
 UsuarioAutenticacionRespuestaDtojj" B
>jjB C
.jjC D
FailurejjD K
(jjK L
$strjjL `
)jj` a
;jja b
}kk 
varmm 
usuariomm 
=mm 
_usuarioRepositorymm 0
.mm0 1
FindByIdmm1 9
(mm9 :
authValidationDtomm: K
.mmK L
	IdUsuariommL U
)mmU V
;mmV W
varnn 
rolnn 
=nn 
GetRolnn  
(nn  !
usuarionn! (
.nn( )
IdHomologacionRolnn) :
)nn: ;
;nn; <
varpp 
codepp 
=pp $
_eventTrackingRepositorypp 3
.pp3 4
GetCodeByUserpp4 A
(ppA B
usuarioppB I
.ppI J
NombreppJ P
,ppP Q
rolppR U
.ppU V
CodigoHomologacionppV h
,pph i
$strppj r
)ppr s
;pps t
Consoleqq 
.qq 
	WriteLineqq !
(qq! "
codeqq" &
)qq& '
;qq' (
ifrr 
(rr 
stringrr 
.rr 
IsNullOrEmptyrr (
(rr( )
coderr) -
)rr- .
||rr/ 1
!rr2 3
authValidationDtorr3 D
.rrD E
CodigorrE K
.rrK L
EqualsrrL R
(rrR S
coderrS W
)rrW X
)rrX Y
{ss !
GenerateEventTrackingtt (
(tt( )
dtott) ,
:tt, -
authValidationDtott. ?
)tt? @
;tt@ A
}ww 
varyy 
onayy 
=yy "
_onaConexionRepositoryyy 0
.yy0 1
FindByIdyy1 9
(yy9 :
usuarioyy: A
.yyA B
IdONAyyB G
)yyG H
;yyH I
varzz 
homologacionGrupozz %
=zz& '"
GetVwHomologacionGrupozz( >
(zz> ?
)zz? @
;zz@ A
var{{ 
token{{ 
={{ 
GenerateToken{{ )
({{) *
usuario{{* 1
.{{1 2
	IdUsuario{{2 ;
){{; <
;{{< =!
GenerateEventTracking}} %
(}}% &
dto}}& )
:}}) *
authValidationDto}}+ <
,}}< =
usuario}}> E
:}}E F
usuario}}G N
,}}N O
rol}}P S
:}}S T
rol}}U X
)}}X Y
;}}Y Z
return~~ 
Result~~ 
<~~ ,
 UsuarioAutenticacionRespuestaDto~~ >
>~~> ?
.~~? @
Success~~@ G
(~~G H
new~~H K,
 UsuarioAutenticacionRespuestaDto~~L l
{ 
Token
ÄÄ 
=
ÄÄ 
token
ÄÄ !
,
ÄÄ! "
Usuario
ÅÅ 
=
ÅÅ 
new
ÅÅ !

UsuarioDto
ÅÅ" ,
{
ÇÇ 
	IdUsuario
ÉÉ !
=
ÉÉ" #
usuario
ÉÉ$ +
.
ÉÉ+ ,
	IdUsuario
ÉÉ, 5
,
ÉÉ5 6
Email
ÑÑ 
=
ÑÑ 
usuario
ÑÑ  '
.
ÑÑ' (
Email
ÑÑ( -
,
ÑÑ- .
Nombre
ÖÖ 
=
ÖÖ  
usuario
ÖÖ! (
.
ÖÖ( )
Nombre
ÖÖ) /
,
ÖÖ/ 0
Apellido
ÜÜ  
=
ÜÜ! "
usuario
ÜÜ# *
.
ÜÜ* +
Apellido
ÜÜ+ 3
,
ÜÜ3 4
Telefono
áá  
=
áá! "
usuario
áá# *
.
áá* +
Telefono
áá+ 3
,
áá3 4
IdHomologacionRol
àà )
=
àà* +
usuario
àà, 3
.
àà3 4
IdHomologacionRol
àà4 E
,
ààE F
IdONA
ââ 
=
ââ 
usuario
ââ  '
.
ââ' (
IdONA
ââ( -
,
ââ- .
	BaseDatos
ää !
=
ää" #
ona
ää$ '
.
ää' (
	BaseDatos
ää( 1
,
ää1 2
OrigenDatos
ãã #
=
ãã$ %
ona
ãã& )
.
ãã) *
OrigenDatos
ãã* 5
,
ãã5 6
Migrar
åå 
=
åå  
ona
åå! $
.
åå$ %
Migrar
åå% +
,
åå+ ,
EstadoMigracion
çç '
=
çç( )
ona
çç* -
.
çç- .
Estado
çç. 4
}
éé 
,
éé 
Rol
èè 
=
èè 
rol
èè 
,
èè 
HomologacionGrupo
êê %
=
êê& '
homologacionGrupo
êê( 9
}
ëë 
)
ëë 
;
ëë 
}
íí 
catch
ìì 
(
ìì 
	Exception
ìì 
ex
ìì 
)
ìì  
{
ìì! "#
GenerateEventTracking
îî %
(
îî% &
dto
îî& )
:
îî) *
authValidationDto
îî+ <
)
îî< =
;
îî= >
throw
ïï 
ex
ïï 
;
ïï 
}
ññ 
}
óó 	
private
ßß 
Result
ßß 
<
ßß 
Usuario
ßß 
>
ßß 
Authenticate
ßß  ,
(
ßß, -
string
ßß- 3
email
ßß4 9
,
ßß9 :
string
ßß; A
clave
ßßB G
)
ßßG H
{
®® 	
if
©© 
(
©© 
string
©© 
.
©© 
IsNullOrEmpty
©© $
(
©©$ %
email
©©% *
)
©©* +
)
©©+ ,
{
™™ 
return
´´ 
Result
´´ 
<
´´ 
Usuario
´´ %
>
´´% &
.
´´& '
Failure
´´' .
(
´´. /
$str
´´/ \
)
´´\ ]
;
´´] ^
}
¨¨ 
if
ÆÆ 
(
ÆÆ 
string
ÆÆ 
.
ÆÆ 
IsNullOrEmpty
ÆÆ $
(
ÆÆ$ %
clave
ÆÆ% *
)
ÆÆ* +
)
ÆÆ+ ,
{
ØØ 
return
∞∞ 
Result
∞∞ 
<
∞∞ 
Usuario
∞∞ %
>
∞∞% &
.
∞∞& '
Failure
∞∞' .
(
∞∞. /
$str
∞∞/ O
)
∞∞O P
;
∞∞P Q
}
±± 
var
≥≥ 
usuario
≥≥ 
=
≥≥  
_usuarioRepository
≥≥ ,
.
≥≥, -
FindByEmail
≥≥- 8
(
≥≥8 9
email
≥≥9 >
)
≥≥> ?
;
≥≥? @
if
µµ 
(
µµ 
usuario
µµ 
==
µµ 
null
µµ 
)
µµ  
{
∂∂ 
return
∑∑ 
Result
∑∑ 
<
∑∑ 
Usuario
∑∑ %
>
∑∑% &
.
∑∑& '
Failure
∑∑' .
(
∑∑. /
$str
∑∑/ G
)
∑∑G H
;
∑∑H I
}
∏∏ 
var
∫∫ 
	claveHash
∫∫ 
=
∫∫ 
_hashService
∫∫ (
.
∫∫( )
GenerateHash
∫∫) 5
(
∫∫5 6
clave
∫∫6 ;
.
∫∫; <
Trim
∫∫< @
(
∫∫@ A
)
∫∫A B
)
∫∫B C
;
∫∫C D
if
ºº 
(
ºº 
!
ºº 
usuario
ºº 
.
ºº 
Clave
ºº 
.
ºº 
Equals
ºº %
(
ºº% &
	claveHash
ºº& /
)
ºº/ 0
)
ºº0 1
{
ΩΩ 
return
ææ 
Result
ææ 
<
ææ 
Usuario
ææ %
>
ææ% &
.
ææ& '
Failure
ææ' .
(
ææ. /
$str
ææ/ B
)
ææB C
;
ææC D
}
øø 
return
¡¡ 
Result
¡¡ 
<
¡¡ 
Usuario
¡¡ !
>
¡¡! "
.
¡¡" #
Success
¡¡# *
(
¡¡* +
usuario
¡¡+ 2
)
¡¡2 3
;
¡¡3 4
}
¬¬ 	
private
ÀÀ 
string
ÀÀ 
GenerateToken
ÀÀ $
(
ÀÀ$ %
int
ÀÀ% (
userId
ÀÀ) /
)
ÀÀ/ 0
{
ÃÃ 	
return
ÕÕ 
_jwtService
ÕÕ 
.
ÕÕ 
GenerateJwtToken
ÕÕ /
(
ÕÕ/ 0
userId
ÕÕ0 6
)
ÕÕ6 7
;
ÕÕ7 8
}
ŒŒ 	
private
◊◊ 
VwRolDto
◊◊ 
?
◊◊ 
GetRol
◊◊  
(
◊◊  !
int
◊◊! $
idHomologacionRol
◊◊% 6
)
◊◊6 7
{
ÿÿ 	
var
ŸŸ 
rol
ŸŸ 
=
ŸŸ "
_catalogosRepository
ŸŸ *
.
ŸŸ* +
FindVwRolByHId
ŸŸ+ 9
(
ŸŸ9 :
idHomologacionRol
ŸŸ: K
)
ŸŸK L
;
ŸŸL M
return
€€ 
rol
€€ 
!=
€€ 
null
€€ 
?
‹‹ 
new
‹‹ 
VwRolDto
‹‹ 
{
›› 
IdHomologacionRol
ﬁﬁ )
=
ﬁﬁ* +
rol
ﬁﬁ, /
.
ﬁﬁ/ 0
IdHomologacionRol
ﬁﬁ0 A
,
ﬁﬁA B
Rol
ﬂﬂ 
=
ﬂﬂ 
rol
ﬂﬂ !
.
ﬂﬂ! "
Rol
ﬂﬂ" %
,
ﬂﬂ% & 
CodigoHomologacion
‡‡ *
=
‡‡+ ,
rol
‡‡- 0
.
‡‡0 1 
CodigoHomologacion
‡‡1 C
}
·· 
:
‚‚ 
null
‚‚ 
;
‚‚ 
}
„„ 	
private
ÎÎ $
VwHomologacionGrupoDto
ÎÎ &
?
ÎÎ& '$
GetVwHomologacionGrupo
ÎÎ( >
(
ÎÎ> ?
)
ÎÎ? @
{
ÏÏ 	
var
ÌÌ 
homologacionGrupo
ÌÌ !
=
ÌÌ" #"
_catalogosRepository
ÌÌ$ 8
.
ÌÌ8 9
FindVwHGByCode
ÌÌ9 G
(
ÌÌG H
$str
ÌÌH R
)
ÌÌR S
;
ÌÌS T
return
ÔÔ 
homologacionGrupo
ÔÔ $
!=
ÔÔ% '
null
ÔÔ( ,
?
 
new
 $
VwHomologacionGrupoDto
 ,
{
ÒÒ 

MostrarWeb
ÚÚ "
=
ÚÚ# $
homologacionGrupo
ÚÚ% 6
.
ÚÚ6 7

MostrarWeb
ÚÚ7 A
,
ÚÚA B

TooltipWeb
ÛÛ "
=
ÛÛ# $
homologacionGrupo
ÛÛ% 6
.
ÛÛ6 7

TooltipWeb
ÛÛ7 A
,
ÛÛA B 
CodigoHomologacion
ÙÙ *
=
ÙÙ+ ,
homologacionGrupo
ÙÙ- >
.
ÙÙ> ? 
CodigoHomologacion
ÙÙ? Q
}
ıı 
:
ˆˆ 
null
ˆˆ 
;
ˆˆ 
}
˜˜ 	
private
ÅÅ 
void
ÅÅ #
GenerateEventTracking
ÅÅ *
(
ÅÅ* +%
UsuarioAutenticacionDto
ÇÇ #
?
ÇÇ# $
dto
ÇÇ% (
=
ÇÇ) *
null
ÇÇ+ /
,
ÇÇ/ 0
Usuario
ÉÉ 
?
ÉÉ 
usuario
ÉÉ 
=
ÉÉ 
null
ÉÉ #
,
ÉÉ# $
VwRolDto
ÑÑ 
?
ÑÑ 
rol
ÑÑ 
=
ÑÑ 
null
ÑÑ  
,
ÑÑ  !
string
ÖÖ 
?
ÖÖ 
code
ÖÖ 
=
ÖÖ 
null
ÖÖ 
,
ÖÖ  
bool
ÜÜ 
success
ÜÜ 
=
ÜÜ 
true
ÜÜ 
)
áá 	
{
àà 	
var
ââ 
eventTrackingDto
ââ  
=
ââ! "
new
ââ# &#
paAddEventTrackingDto
ââ' <
{
ää #
CodigoHomologacionRol
ãã %
=
ãã& '
rol
ãã( +
?
ãã+ ,
.
ãã, - 
CodigoHomologacion
ãã- ?
??
ãã@ B
$str
ããC E
,
ããE F
NombreUsuario
åå 
=
åå 
usuario
åå  '
?
åå' (
.
åå( )
Nombre
åå) /
??
åå0 2
dto
åå3 6
.
åå6 7
Email
åå7 <
,
åå< =$
CodigoHomologacionMenu
çç &
=
çç' (
$str
çç) 1
,
çç1 2
NombreControl
éé 
=
éé 
$str
éé  *
,
éé* +
NombreAccion
èè 
=
èè 
$str
èè *
,
èè* +
ParametroJson
êê 
=
êê 
JsonConvert
êê  +
.
êê+ ,
SerializeObject
êê, ;
(
êê; <
usuario
êê< C
==
êêD F
null
êêG K
?
êêL M
dto
êêN Q
:
êêR S
new
êêT W
{
ëë 
Email
íí 
=
íí 
usuario
íí #
?
íí# $
.
íí$ %
Email
íí% *
??
íí+ -
dto
íí. 1
.
íí1 2
Email
íí2 7
,
íí7 8
Success
ìì 
=
ìì 
success
ìì %
,
ìì% &
Code
îî 
=
îî 
code
îî 
}
ïï 
)
ïï 
}
ññ 
;
ññ &
_eventTrackingRepository
òò $
.
òò$ %
Create
òò% +
(
òò+ ,
eventTrackingDto
òò, <
)
òò< =
;
òò= >
}
ôô 	
private
õõ 
void
õõ #
GenerateEventTracking
õõ *
(
õõ* +
AuthValidationDto
úú 
?
úú 
dto
úú "
=
úú# $
null
úú% )
,
úú) *
Usuario
ùù 
?
ùù 
usuario
ùù 
=
ùù 
null
ùù #
,
ùù# $
VwRolDto
ûû 
?
ûû 
rol
ûû 
=
ûû 
null
ûû  
,
ûû  !
bool
üü 
success
üü 
=
üü 
true
üü 
)
†† 	
{
°° 	
var
¢¢ 
eventTrackingDto
¢¢  
=
¢¢! "
new
¢¢# &#
paAddEventTrackingDto
¢¢' <
{
££ #
CodigoHomologacionRol
§§ %
=
§§& '
rol
§§( +
?
§§+ ,
.
§§, - 
CodigoHomologacion
§§- ?
??
§§@ B
$str
§§C E
,
§§E F
NombreUsuario
•• 
=
•• 
usuario
••  '
?
••' (
.
••( )
Nombre
••) /
??
••0 2
$"
••3 5
{
••5 6
dto
••6 9
.
••9 :
	IdUsuario
••: C
}
••C D
"
••D E
,
••E F$
CodigoHomologacionMenu
¶¶ &
=
¶¶' (
$str
¶¶) 1
,
¶¶1 2
NombreControl
ßß 
=
ßß 
$str
ßß  ,
,
ßß, -
NombreAccion
®® 
=
®® 
$str
®® 0
,
®®0 1
ParametroJson
©© 
=
©© 
JsonConvert
©©  +
.
©©+ ,
SerializeObject
©©, ;
(
©©; <
usuario
©©< C
==
©©D F
null
©©G K
?
©©L M
dto
©©N Q
:
©©R S
new
©©T W
{
™™ 
Id
´´ 
=
´´ 
usuario
´´  
?
´´  !
.
´´! "
	IdUsuario
´´" +
??
´´, .
dto
´´/ 2
.
´´2 3
	IdUsuario
´´3 <
,
´´< =
Success
¨¨ 
=
¨¨ 
success
¨¨ %
}
≠≠ 
)
≠≠ 
}
ÆÆ 
;
ÆÆ &
_eventTrackingRepository
∞∞ $
.
∞∞$ %
Create
∞∞% +
(
∞∞+ ,
eventTrackingDto
∞∞, <
)
∞∞< =
;
∞∞= >
}
±± 	
public
∏∏ 
string
∏∏ /
!GenerateVerificationCodeEmailBody
∏∏ 7
(
∏∏7 8
string
∏∏8 >
codigo
∏∏? E
)
∏∏E F
{
ππ 	
string
∫∫ 
templatePath
∫∫ 
=
∫∫  !
_configuration
∫∫" 0
[
∫∫0 1
$str
∫∫1 N
]
∫∫N O
??
∫∫P R
$str
∫∫S U
;
∫∫U V
if
ºº 
(
ºº 
File
ºº 
.
ºº 
Exists
ºº 
(
ºº 
templatePath
ºº (
)
ºº( )
)
ºº) *
{
ΩΩ 
string
ææ 
htmlBody
ææ 
=
ææ  !
File
ææ" &
.
ææ& '
ReadAllText
ææ' 2
(
ææ2 3
templatePath
ææ3 ?
)
ææ? @
;
ææ@ A
return
øø 
string
øø 
.
øø 
Format
øø $
(
øø$ %
htmlBody
øø% -
,
øø- .
codigo
øø/ 5
)
øø5 6
;
øø6 7
}
¿¿ 
else
¡¡ 
{
¬¬ 
throw
√√ 
new
√√ #
FileNotFoundException
√√ /
(
√√/ 0
$str
√√0 v
)
√√v w
;
√√w x
}
ƒƒ 
}
≈≈ 	
}
∆∆ 
}«« ØU
=C:\Users\Dell\source\repos\BuscadorCan\Core\Mappers\Mapper.cs
	namespace 	
Core
 
. 
Mappers 
{ 
public 

class 
Mapper 
: 
Profile !
{ 
public		 
Mapper		 
(		 
)		 
{

 	
	CreateMap 
< 
VwGrilla 
, 
VwGrillaDto  +
>+ ,
(, -
)- .
;. /
	CreateMap 
< 
VwFiltro 
, 
VwFiltroDto  +
>+ ,
(, -
)- .
;. /
	CreateMap 
< 
vwFiltroDetalle %
,% &
vwFiltroDetalleDto' 9
>9 :
(: ;
); <
;< =
	CreateMap 
< 
VwDimension !
,! "
VwDimensionDto# 1
>1 2
(2 3
)3 4
;4 5
	CreateMap 
< 
Homologacion "
," #
	GruposDto$ -
>- .
(. /
)/ 0
;0 1
	CreateMap 
< 
VwRol 
, 
VwRolDto %
>% &
(& '
)' (
;( )
	CreateMap 
< 
VwPais 
, 
	VwPaisDto '
>' (
(( )
)) *
;* +
	CreateMap 
< 
VwMenu 
, 
	VwMenuDto '
>' (
(( )
)) *
;* +
	CreateMap 
< 

vwPanelONA  
,  !
vwPanelONADto" /
>/ 0
(0 1
)1 2
;2 3
	CreateMap 
< 
VwHomologacionGrupo )
,) *"
VwHomologacionGrupoDto+ A
>A B
(B C
)C D
;D E
	CreateMap 
< 
VwHomologacion $
,$ %
VwHomologacionDto& 7
>7 8
(8 9
)9 :
;: ;
	CreateMap 
< 

DataAccess  
.  !
Models! '
.' (
Usuario( /
,/ 0

UsuarioDto1 ;
>; <
(< =
)= >
;> ?
	CreateMap 
< 

UsuarioDto  
,  !
Usuario" )
>) *
(* +
)+ ,
;, -
	CreateMap 
< 
vwONA 
, 
vwONADto %
>% &
(& '
)' (
;( )
	CreateMap 
< 
vwEsquemaOrganiza '
,' ( 
vwEsquemaOrganizaDto) =
>= >
(> ?
)? @
;@ A
	CreateMap 
< 
vw_FiltrosAnidados (
,( )!
vw_FiltrosAnidadosDto* ?
>? @
(@ A
)A B
;B C
	CreateMap 
< 
VwAcreditacionOna '
,' ( 
VwAcreditacionOnaDto) =
>= >
(> ?
)? @
;@ A
	CreateMap 
< !
VwAcreditacionEsquema +
,+ ,$
VwAcreditacionEsquemaDto- E
>E F
(F G
)G H
;H I
	CreateMap 
< 
VwEstadoEsquema %
,% &
VwEstadoEsquemaDto' 9
>9 :
(: ;
); <
;< =
	CreateMap   
<   
	VwOecPais   
,    
VwOecPaisDto  ! -
>  - .
(  . /
)  / 0
;  0 1
	CreateMap!! 
<!! 
VwEsquemaPais!! #
,!!# $
VwEsquemaPaisDto!!% 5
>!!5 6
(!!6 7
)!!7 8
;!!8 9
	CreateMap"" 
<"" 

VwOecFecha""  
,""  !
VwOecFechaDto""" /
>""/ 0
(""0 1
)""1 2
;""2 3
	CreateMap%% 
<%% #
VwProfesionalCalificado%% -
,%%- .&
VwProfesionalCalificadoDto%%/ I
>%%I J
(%%J K
)%%K L
;%%L M
	CreateMap&& 
<&& 
VwProfesionalOna&& &
,&&& '
VwProfesionalOnaDto&&( ;
>&&; <
(&&< =
)&&= >
;&&> ?
	CreateMap'' 
<''  
VwProfesionalEsquema'' *
,''* +#
VwProfesionalEsquemaDto'', C
>''C D
(''D E
)''E F
;''F G
	CreateMap(( 
<(( 
VwProfesionalFecha(( (
,((( )!
VwProfesionalFechaDto((* ?
>((? @
(((@ A
)((A B
;((B C
	CreateMap)) 
<)) 
VwCalificaUbicacion)) )
,))) *"
VwCalificaUbicacionDto))+ A
>))A B
())B C
)))C D
;))D E
	CreateMap,, 
<,, 
VwBusquedaFecha,, %
,,,% &
VwBusquedaFechaDto,,' 9
>,,9 :
(,,: ;
),,; <
;,,< =
	CreateMap-- 
<-- 
VwBusquedaFiltro-- &
,--& '
VwBusquedaFiltroDto--( ;
>--; <
(--< =
)--= >
;--> ?
	CreateMap.. 
<.. 
VwBusquedaUbicacion.. )
,..) *"
VwBusquedaUbicacionDto..+ A
>..A B
(..B C
)..C D
;..D E
	CreateMap// 
<// 
VwActualizacionONA// (
,//( )!
VwActualizacionONADto//* ?
>//? @
(//@ A
)//A B
;//B C
	CreateMap22 
<22 !
VwOrganismoRegistrado22 +
,22+ ,$
VwOrganismoRegistradoDto22- E
>22E F
(22F G
)22G H
;22H I
	CreateMap33 
<33 !
VwOrganizacionEsquema33 +
,33+ ,$
VwOrganizacionEsquemaDto33- E
>33E F
(33F G
)33G H
;33H I
	CreateMap44 
<44  
VwOrganismoActividad44 *
,44* +#
VwOrganismoActividadDto44, C
>44C D
(44D E
)44E F
;44F G
	CreateMap88 
<88 
Esquema88 
,88 

EsquemaDto88 )
>88) *
(88* +
)88+ ,
;88, -
	CreateMap99 
<99 

EsquemaDto99  
,99  !
Esquema99" )
>99) *
(99* +
)99+ ,
;99, -
	CreateMap;; 
<;; 
Homologacion;; "
,;;" #
HomologacionDto;;$ 3
>;;3 4
(;;4 5
);;5 6
;;;6 7
	CreateMap<< 
<<< 
HomologacionDto<< %
,<<% &
Homologacion<<' 3
><<3 4
(<<4 5
)<<5 6
;<<6 7
	CreateMap>> 
<>> 
ONAConexion>> !
,>>! "
ONAConexionDto>># 1
>>>1 2
(>>2 3
)>>3 4
;>>4 5
	CreateMap?? 
<?? 
ONAConexionDto?? $
,??$ %
ONAConexion??& 1
>??1 2
(??2 3
)??3 4
;??4 5
	CreateMapAA 
<AA 
ONAAA 
,AA 
OnaDtoAA !
>AA! "
(AA" #
)AA# $
;AA$ %
	CreateMapBB 
<BB 
OnaDtoBB 
,BB 
ONABB !
>BB! "
(BB" #
)BB# $
;BB$ %
	CreateMapDD 
<DD 
MenusDD 
,DD 

MenuRolDtoDD '
>DD' (
(DD( )
)DD) *
;DD* +
	CreateMapEE 
<EE 

MenuRolDtoEE  
,EE  !
MenusEE" '
>EE' (
(EE( )
)EE) *
;EE* +
	CreateMapGG 
<GG 

MenuRolDtoGG  
,GG  !
MenuRolGG" )
>GG) *
(GG* +
)GG+ ,
;GG, -
	CreateMapHH 
<HH 
MenuRolHH 
,HH 

MenuRolDtoHH )
>HH) *
(HH* +
)HH+ ,
;HH, -
	CreateMapKK 
<KK 
MenuPaginaDtoKK #
,KK# $

MenuPaginaKK% /
>KK/ 0
(KK0 1
)KK1 2
;KK2 3
	CreateMapLL 
<LL 

MenuPaginaLL  
,LL  !
MenuPaginaDtoLL" /
>LL/ 0
(LL0 1
)LL1 2
;LL2 3
	CreateMapQQ 
<QQ 
LogMigracionQQ "
,QQ" #
LogMigracionDtoQQ$ 3
>QQ3 4
(QQ4 5
)QQ5 6
;QQ6 7
	CreateMapRR 
<RR 
LogMigracionDtoRR %
,RR% &
LogMigracionRR' 3
>RR3 4
(RR4 5
)RR5 6
;RR6 7
	CreateMapTT 
<TT 
EsquemaVistaTT "
,TT" #%
EsquemaVistaValidacionDtoTT$ =
>TT= >
(TT> ?
)TT? @
;TT@ A
	CreateMapUU 
<UU %
EsquemaVistaValidacionDtoUU /
,UU/ 0
EsquemaVistaUU1 =
>UU= >
(UU> ?
)UU? @
;UU@ A
	CreateMapWW 
<WW 
EsquemaVistaColumnaWW )
,WW) *"
EsquemaVistaColumnaDtoWW+ A
>WWA B
(WWB C
)WWC D
;WWD E
	CreateMapXX 
<XX "
EsquemaVistaColumnaDtoXX ,
,XX, -
EsquemaVistaColumnaXX. A
>XXA B
(XXB C
)XXC D
;XXD E
	CreateMap[[ 
<[[ 
	Thesaurus[[ 
,[[  
ThesaurusDto[[! -
>[[- .
([[. /
)[[/ 0
;[[0 1
	CreateMap\\ 
<\\ 
	Expansion\\ 
,\\  
ExpansionDto\\! -
>\\- .
(\\. /
)\\/ 0
;\\0 1
	CreateMap]] 
<]] 
ExpansionDto]] "
,]]" #
	Expansion]]$ -
>]]- .
(]]. /
)]]/ 0
;]]0 1
	CreateMap^^ 
<^^ 
Replacement^^ !
,^^! "
ReplacementDto^^# 1
>^^1 2
(^^2 3
)^^3 4
;^^4 5
	CreateMapaa 
<aa 
VwEventUserAllaa $
,aa$ %
VwEventUserAllDtoaa& 7
>aa7 8
(aa8 9
)aa9 :
;aa: ;
	CreateMapbb 
<bb 
VwEventUserAllDtobb '
,bb' (
VwEventUserAllbb) 7
>bb7 8
(bb8 9
)bb9 :
;bb: ;
	CreateMapcc 
<cc 
	EventUsercc 
,cc  
EventUserDtocc! -
>cc- .
(cc. /
)cc/ 0
;cc0 1
	CreateMapdd 
<dd 
EventUserDtodd "
,dd" #
	EventUserdd$ -
>dd- .
(dd. /
)dd/ 0
;dd0 1
}ee 	
}ff 
}gg ¥
IC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IUsuarioService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IUsuarioService $
{ 

UsuarioDto 
? 
FindById 
( 
int  
	idUsuario! *
)* +
;+ ,
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
( 

UsuarioDto 
usuario &
)& '
;' (
bool"" 
Update"" 
("" 

UsuarioDto"" 
usuario"" &
)""& '
;""' (
bool)) 
IsUniqueUser)) 
()) 
string))  
usuario))! (
)))( )
;))) *
List// 
<// 

UsuarioDto// 
>// 
FindAll//  
(//  !
)//! "
;//" #
bool11 

Deactivate11 
(11 
int11 
	idUsuario11 %
)11% &
;11& '
Result77 
<77 
bool77 
>77 
ChangePasswd77 !
(77! "
string77" (
clave77) .
,77. /
string770 6

claveNueva777 A
)77A B
;77B C
}88 
}99 Í
PC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IUsuarioEndpontService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface "
IUsuarioEndpontService +
{ 
ICollection 
< 
UsuarioEndpoint #
># $
FindAll% ,
(, -
)- .
;. /
UsuarioEndpoint 
? 
FindByEndpointId )
() *
int* -

endpointId. 8
)8 9
;9 :
bool 
Create 
( 
UsuarioEndpoint #
UsuarioEndpoint$ 3
)3 4
;4 5
} 
} é	
KC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IThesaurusService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IThesaurusService &
{ 
ThesaurusDto 
ObtenerThesaurus %
(% &
)& '
;' (
string 
AgregarExpansion 
(  
List  $
<$ %
string% +
>+ ,
	sinonimos- 6
)6 7
;7 8
string  
AgregarSubAExpansion #
(# $
string$ *
expansionExistente+ =
,= >
string? E
nuevoSubF N
)N O
;O P
string!! 
ActualizarExpansion!! "
(!!" #
List!!# '
<!!' (
ExpansionDto!!( 4
>!!4 5

expansions!!6 @
)!!@ A
;!!A B
string'' 
EjecutarArchivoBat'' !
(''! "
)''" #
;''# $
string-- 
ResetSQLServer-- 
(-- 
)-- 
;--  
}// 
}00 ÷
IC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IReporteService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IReporteService $
{ 
VwHomologacionDto 
findByVista %
(% &
string& ,
codigoHomologacion- ?
)? @
;@ A
List 
<  
VwAcreditacionOnaDto !
>! "$
ObtenerVwAcreditacionOna# ;
(; <
)< =
;= >
List 
< $
VwAcreditacionEsquemaDto %
>% &(
ObtenerVwAcreditacionEsquema' C
(C D
)D E
;E F
List 
< 
VwEstadoEsquemaDto 
>  "
ObtenerVwEstadoEsquema! 7
(7 8
)8 9
;9 :
List%% 
<%% 
VwOecPaisDto%% 
>%% 
ObtenerVwOecPais%% +
(%%+ ,
)%%, -
;%%- .
List++ 
<++ 
VwEsquemaPaisDto++ 
>++  
ObtenerVwEsquemaPais++ 3
(++3 4
)++4 5
;++5 6
List11 
<11 
VwOecFechaDto11 
>11 
ObtenerVwOecFecha11 -
(11- .
)11. /
;11/ 0
List77 
<77 &
VwProfesionalCalificadoDto77 '
>77' (*
ObtenerVwProfesionalCalificado77) G
(77G H
)77H I
;77I J
List== 
<== 
VwProfesionalOnaDto==  
>==  !#
ObtenerVwProfesionalOna==" 9
(==9 :
)==: ;
;==; <
ListCC 
<CC #
VwProfesionalEsquemaDtoCC $
>CC$ %'
ObtenerVwProfesionalEsquemaCC& A
(CCA B
)CCB C
;CCC D
ListII 
<II !
VwProfesionalFechaDtoII "
>II" #%
ObtenerVwProfesionalFechaII$ =
(II= >
)II> ?
;II? @
ListOO 
<OO "
VwCalificaUbicacionDtoOO #
>OO# $&
ObtenerVwCalificaUbicacionOO% ?
(OO? @
)OO@ A
;OOA B
ListVV 
<VV 
VwBusquedaFechaDtoVV 
>VV  "
ObtenerVwBusquedaFechaVV! 7
(VV7 8
)VV8 9
;VV9 :
List\\ 
<\\ 
VwBusquedaFiltroDto\\  
>\\  !#
ObtenerVwBusquedaFiltro\\" 9
(\\9 :
)\\: ;
;\\; <
Listbb 
<bb "
VwBusquedaUbicacionDtobb #
>bb# $&
ObtenerVwBusquedaUbicacionbb% ?
(bb? @
)bb@ A
;bbA B
Listhh 
<hh !
VwActualizacionONADtohh "
>hh" #%
ObtenerVwActualizacionONAhh$ =
(hh= >
)hh> ?
;hh? @
Listnn 
<nn $
VwOrganismoRegistradoDtonn %
>nn% &(
ObtenerVwOrganismoRegistradonn' C
(nnC D
)nnD E
;nnE F
Listtt 
<tt $
VwOrganizacionEsquemaDtott %
>tt% &(
ObtenerVwOrganizacionEsquematt' C
(ttC D
)ttD E
;ttE F
Listzz 
<zz #
VwOrganismoActividadDtozz $
>zz$ %'
ObtenerVwOrganismoActividadzz& A
(zzA B
)zzB C
;zzC D
}{{ 
}|| ˜
MC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IRecoverUserService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IRecoverUserService (
{ 
Result 
< 
bool 
> 
RecoverPassword $
($ %"
UsuarioRecuperacionDto% ;"
usuarioRecuperacionDto< R
)R S
;S T
} 
} À
WC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IRandomStringGeneratorService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface )
IRandomStringGeneratorService 2
{ 
string

 %
GenerateTemporaryPassword

 (
(

( )
int

) ,
length

- 3
)

3 4
;

4 5
string !
GenerateTemporaryCode $
($ %
int% (
length) /
)/ 0
;0 1
} 
} ®
JC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IPasswordService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IPasswordService %
{ 
string %
GenerateTemporaryPassword (
(( )
int) ,
length- 3
)3 4
;4 5
} 
} µ
UC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IPasswordGenerationStrategy.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface '
IPasswordGenerationStrategy 0
{ 
string 
GeneratePassword 
(  
int  #
length$ *
)* +
;+ ,
} 
} ä
EC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IONAService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IONAService  
{ 
bool 
Update 
( 
ONA 
data 
) 
; 
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
}<< 
}== Â
EC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IOnaMigrate.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IOnaMigrate  
{ 
Task 
< 
List 
< 
OnaMigrateDto 
>  
>  !
postOnaMigrate" 0
(0 1
string1 7
view8 <
,< =
int> A
idOnaB G
,G H
intI L
	idEsquemaM V
)V W
;W X
} 
}		 ∫	
PC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IMigracionExcelService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface "
IMigracionExcelService +
{ 
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
}// 
}00 Ê

MC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IONAConexionService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IONAConexionService (
{ 
bool 
Update 
( 
ONAConexionDto &
data' +
)+ ,
;, -
bool 
Create 
( 
ONAConexionDto &
data' +
)+ ,
;, -
ONAConexionDto 
? 
FindById $
($ %
int% (
Id) +
)+ ,
;, -
ONAConexionDto!! 
?!! 
FindByIdONA!! '
(!!' (
int!!( +
IdONA!!, 1
)!!1 2
;!!2 3
Task(( 
<(( 
ONAConexionDto(( 
?((  
>((  !
FindByIdONAAsync((" 2
(((2 3
int((3 6
IdONA((7 <
)((< =
;((= >
List.. 
<.. 
ONAConexionDto.. 
>..  
FindAll..! (
(..( )
)..) *
;..* +
List55 
<55 
ONAConexionDto55 
>55  (
GetONAConexionByOnaListAsync55! =
(55= >
int55> A
IdONA55B G
)55G H
;55H I
}66 
}77 ‚
FC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IMenuService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IMenuService !
{ 
bool 
Update 
( 

MenuRolDto 
data #
)# $
;$ %
bool 
Create 
( 

MenuRolDto 
data #
)# $
;$ %

MenuRolDto 
? 
FindDataById  
(  !
int! $
idHRol% +
,+ ,
int- 0
idHMenu1 8
)8 9
;9 :

MenuRolDto## 
?## 
FindById## 
(## 
int##  
idHRol##! '
,##' (
int##) ,
idHMenu##- 4
)##4 5
;##5 6
List)) 
<)) 

MenuRolDto)) 
>)) 
FindAll))  
())  !
)))! "
;))" #
List11 
<11 

MenuRolDto11 
>11 
GetListByMenusAsync11 ,
(11, -
int11- 0
idHRol111 7
,117 8
int119 <
idHMenu11= D
)11D E
;11E F
List22 
<22 
MenuPaginaDto22 
>22 %
ObtenerMenusPendingConfig22 5
(225 6
int226 9
idHomologacionRol22: K
)22K L
;22L M
}33 
}44 Ç
NC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\ILogMigracionService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface  
ILogMigracionService )
{ 
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
}SS 
}TT ˜
EC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IJwtService.cs
	namespace 	
Core
 
. 
Services 
; 
public 
	interface 
IJwtService 
{ 
string 

GenerateJwtToken 
( 
int 
userId  &
)& '
;' (
int&& 
GetUserIdFromToken&& 
(&& 
string&& !
token&&" '
)&&' (
;&&( )
string33 

?33
 
GetTokenFromHeader33 
(33 
)33  
;33  !
}66 ≈
EC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IJwtFactory.cs
	namespace 	
Core
 
. 
Services 
{ 
public 

	interface 
IJwtFactory  
{ #
JwtSecurityTokenHandler 
CreateTokenHandler  2
(2 3
)3 4
;4 5
SigningCredentials"" $
CreateSigningCredentials"" 3
(""3 4
string""4 :
secret""; A
)""A B
;""B C%
TokenValidationParameters33 !+
CreateTokenValidationParameters33" A
(33A B
string33B H
secret33I O
)33O P
;33P Q
}66 
}77 ﬁ
OC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IIpCoordinatesService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface !
IIpCoordinatesService *
{ 
Task 
< 
CoordinatesDto 
> 
GetCoordinates +
(+ ,
string, 2
ip3 5
)5 6
;6 7
} 
}		 ™
EC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IImportador.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IImportador  
{ 
bool 
Importar 
( 
string 
[ 
] 
path #
)# $
;$ %
} 
} â
NC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IHomologacionService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface  
IHomologacionService )
{ 
bool 
Update 
( 
HomologacionDto #
data$ (
)( )
;) *
bool 
Create 
( 
HomologacionDto #
data$ (
)( )
;) *
HomologacionDto 
? 
FindById !
(! "
int" %
id& (
)( )
;) *
List   
<   
HomologacionDto   
>   
FindByParent   *
(  * +
)  + ,
;  , -
List'' 
<'' 
HomologacionDto'' 
>'' 
	FindByIds'' '
(''' (
int''( +
[''+ ,
]'', -
ids''. 1
)''1 2
;''2 3
List.. 
<.. 
VwHomologacionDto.. 
>.. *
ObtenerVwHomologacionPorCodigo..  >
(..> ?
string..? E
codigoHomologacion..F X
)..X Y
;..Y Z
List44 
<44 
HomologacionDto44 
>44 
	FindByAll44 '
(44' (
)44( )
;44) *
}55 
}66 £
GC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IHashStrategy.cs
	namespace 	
Core
 
. 
Services 
{ 
public 

	interface 
IHashStrategy "
{ 
string 
ComputeHash 
( 
string !
?! "
input# (
)( )
;) *
} 
} ¢
FC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IHashService.cs
	namespace 	
Core
 
. 
Services 
{ 
public 

	interface 
IHashService !
{ 
string 
GenerateHash 
( 
string "
?" #
input$ )
)) *
;* +
} 
} ª
MC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IGmailClientFactory.cs
	namespace 	
Core
 
. 
Services 
{ 
public 
	interface	 
IGmailClientFactory &
{		 
Task 

<
 
GmailService 
> #
CreateGmailServiceAsync 0
(0 1
)1 2
;2 3
} 
} ∏
GC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IExcelService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IExcelService "
{ 
Task   
<   
bool   
>   
ImportarExcel    
(    !
string  ! '
path  ( ,
,  , -
LogMigracion  . :
	migracion  ; D
,  D E
int  F I
idOna  J O
)  O P
;  P Q
}"" 
}## Ÿ
OC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IEventTrackingService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface !
IEventTrackingService *
{ 
bool 
Create 
( !
paAddEventTrackingDto )
data* .
). /
;/ 0
string 
GetCodeByUser 
( 
string #
nombreUsuario$ 1
,1 2
string3 9!
CodigoHomologacionRol: O
,O P
stringQ W"
CodigoHomologacionMenuX n
)n o
;o p
Menus 
? 
FindDataById 
( 
int 
idHRol  &
,& '
int( +
idHMenu, 3
)3 4
;4 5
List%% 
<%% 
VwEventUserAll%% 
>%% 
GetEventUserAll%% ,
(%%, -
)%%- .
;%%. /
List.. 
<.. 
	EventUser.. 
>.. 
GetEventAll.. #
(..# $
string..$ *
report..+ 1
,..1 2
DateOnly..3 ;
fini..< @
,..@ A
DateOnly..B J
ffin..K O
)..O P
;..P Q
bool66 
DeleteEventAll66 
(66 
DateOnly66 $
fini66% )
,66) *
DateOnly66+ 3
ffin664 8
)668 9
;669 :
bool== 
DeleteEventById== 
(== 
int==  
id==! #
)==# $
;==$ %
ListCC 
<CC %
VwEventTrackingSessionDtoCC &
>CC& '
GetEventSessionCC( 7
(CC7 8
)CC8 9
;CC9 :
ListII 
<II !
PaginasMasVisitadaDtoII "
>II" #
GetEventPagMasVisitII$ 7
(II7 8
)II8 9
;II9 :
ListOO 
<OO 
FiltrosMasUsadoDtoOO 
>OO   
GetEventFiltroMasUsaOO! 5
(OO5 6
)OO6 7
;OO7 8
}PP 
}QQ ©
IC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IEsquemaService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IEsquemaService $
{ 
bool 
Update 
( 
Esquema 
data  
)  !
;! "
bool 
Create 
( 
Esquema 
data  
)  !
;! "
Esquema%% 
?%% 
FindById%% 
(%% 
int%% 
Id%%  
)%%  !
;%%! "
Esquema00 
?00 
FindByViewName00 
(00  
string00  &
esquemaVista00' 3
)003 4
;004 5
Task;; 
<;; 
Esquema;; 
?;; 
>;; 
FindByViewNameAsync;; *
(;;* +
string;;+ 1
esquemaVista;;2 >
);;> ?
;;;? @
ListDD 
<DD 
EsquemaDD 
>DD 
FindAllDD 
(DD 
)DD 
;DD  
ListMM 
<MM 
EsquemaMM 
>MM 
FindAllWithViewsMM &
(MM& '
)MM' (
;MM( )
ListWW 
<WW 
EsquemaWW 
>WW  
GetListaEsquemaByOnaWW *
(WW* +
intWW+ .
idONAWW/ 4
)WW4 5
;WW5 6
boolaa #
UpdateEsquemaValidacionaa $
(aa$ %
EsquemaVistaaa% 1
dataaa2 6
)aa6 7
;aa7 8
boolkk #
CreateEsquemaValidacionkk $
(kk$ %
EsquemaVistakk% 1
datakk2 6
)kk6 7
;kk7 8
booluu ;
/EliminarEsquemaVistaColumnaByIdEquemaVistaAsyncuu <
(uu< =
intuu= @
iduuA C
)uuC D
;uuD E!
EsquemaVistaColumna
ÅÅ 
?
ÅÅ 8
*GetEsquemaVistaColumnaByIdEquemaVistaAsync
ÅÅ G
(
ÅÅG H
int
ÅÅH K
idOna
ÅÅL Q
,
ÅÅQ R
int
ÅÅS V
	idEsquema
ÅÅW `
)
ÅÅ` a
;
ÅÅa b
bool
çç -
GuardarListaEsquemaVistaColumna
çç ,
(
çç, -
List
çç- 1
<
çç1 2!
EsquemaVistaColumna
çç2 E
>
ççE F&
listaEsquemaVistaColumna
ççG _
,
çç_ `
int
çça d
?
ççd e
idOna
ççf k
,
ççk l
int
ççm p
?
ççp q
intidEsquema
ççr ~
)
çç~ 
;çç Ä
}
éé 
}èè Ø
GC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IEmailService.cs
	namespace 	
Core
 
. 
Services 
{ 
public 

	interface 
IEmailService "
{ 
Task 
< 
bool 
> 
SendEmailAsync !
(! "
string" (
to) +
,+ ,
string- 3
subject4 ;
,; <
string= C
bodyD H
)H I
;I J
} 
} º
IC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IDynamicService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IDynamicService $
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
}QQ 
}RR ˜
KC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\ICatalogosService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
ICatalogosService &
{ 
List 
< 
VwGrillaDto 
> 
ObtenerVwGrilla )
() *
)* +
;+ ,
List 
< 
VwFiltroDto 
> 
ObtenerVwFiltro )
() *
)* +
;+ ,

Dictionary!! 
<!! 
string!! 
,!! 
List!! 
<!!  !
vw_FiltrosAnidadosDto!!  5
>!!5 6
>!!6 7"
ObtenerFiltrosAnidados!!8 N
(!!N O
List!!O S
<!!S T'
FiltrosBusquedaSeleccionDto!!T o
>!!o p!
filtrosSeleccionados	!!q Ö
)
!!Ö Ü
;
!!Ü á
List** 
<** !
vw_FiltrosAnidadosDto** "
>**" #%
ObtenerFiltrosAnidadosAll**$ =
(**= >
)**> ?
;**? @
List55 
<55 
VwDimensionDto55 
>55 
ObtenerVwDimension55 /
(55/ 0
)550 1
;551 2
List>> 
<>> 
HomologacionDto>> 
>>> 
ObtenerGrupos>> +
(>>+ ,
)>>, -
;>>- ."
VwHomologacionGrupoDtoII 
?II 
FindVwHGByCodeII  .
(II. /
stringII/ 5
codigoHomologacionII6 H
)IIH I
;III J
ListSS 
<SS 
vwFiltroDetalleDtoSS 
>SS  !
ObtenerFiltroDetallesSS! 6
(SS6 7
stringSS7 =
codigoSS> D
)SSD E
;SSE F
List\\ 
<\\ 
VwRolDto\\ 
>\\ 
ObtenerVwRol\\ #
(\\# $
)\\$ %
;\\% &
VwRolDtoff 
FindVwRolByHIdff 
(ff  
intff  #
idHomologacionRolff$ 5
)ff5 6
;ff6 7
Listoo 
<oo 
	VwMenuDtooo 
>oo 
ObtenerVwMenuoo %
(oo% &
)oo& '
;oo' (
Listxx 
<xx 
OnaDtoxx 
>xx 

ObtenerOnaxx 
(xx  
)xx  !
;xx! "
List
ÅÅ 
<
ÅÅ 
vwONADto
ÅÅ 
>
ÅÅ 
ObtenervwOna
ÅÅ #
(
ÅÅ# $
)
ÅÅ$ %
;
ÅÅ% &
List
ää 
<
ää $
VwHomologacionGrupoDto
ää #
>
ää# $(
ObtenerVwHomologacionGrupo
ää% ?
(
ää? @
)
ää@ A
;
ääA B
List
îî 
<
îî 
vwPanelONADto
îî 
>
îî 
ObtenerVwPanelOna
îî -
(
îî- .
)
îî. /
;
îî/ 0
List
ûû 
<
ûû "
vwEsquemaOrganizaDto
ûû !
>
ûû! "&
ObtenervwEsquemaOrganiza
ûû# ;
(
ûû; <
)
ûû< =
;
ûû= >
}
üü 
}†† 
JC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IBuscadorService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface 
IBuscadorService %
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
,cc; <
stringcc= C
	ipAddressccD M
)ccM N
;ccN O
Taskee 
<ee 
stringee 
>ee 
GetCoordinatesee #
(ee# $
stringee$ *
addressee+ 2
)ee2 3
;ee3 4
bytegg 
[gg 
]gg 
ExportExcelgg 
(gg 
Listgg 
<gg  

Dictionarygg  *
<gg* +
stringgg+ 1
,gg1 2
stringgg3 9
>gg9 :
>gg: ;
datagg< @
)gg@ A
;ggA B
byteii 
[ii 
]ii 
	ExportPdfii 
(ii 
Listii 
<ii 

Dictionaryii (
<ii( )
stringii) /
,ii/ 0
stringii1 7
>ii7 8
>ii8 9
dataii: >
)ii> ?
;ii? @
}jj 
}kk 
NC:\Users\Dell\source\repos\BuscadorCan\Core\Interfaces\IAuthenticateService.cs
	namespace 	
Core
 
. 

Interfaces 
{ 
public 

	interface  
IAuthenticateService )
{ 
Result 
< #
AuthenticateResponseDto &
>& '
Authenticate( 4
(4 5#
UsuarioAutenticacionDto5 L#
usuarioAutenticacionDtoM d
)d e
;e f
Result 
< ,
 UsuarioAutenticacionRespuestaDto /
>/ 0
ValidateCode1 =
(= >
AuthValidationDto> O
authValidationDtoP a
)a b
;b c
} 
} 