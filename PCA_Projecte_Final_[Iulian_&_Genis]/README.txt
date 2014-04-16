//////////////////////////////// fitxer README ////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/****** MAKEFILE ******/

Per a fer servir el fitxer Makefile cal que prèviament estiguin tots els
directoris de la pràtcica correctament instal·lats, i situar aquest fitxer
Makefile dins del directori finalProject1213q2/sources/3D_Dock/progs. D'altra
banda, cal especificar també la ruta absoluta del directori on es troben les
llibreries fftw. Per a tal propòsit cal modificar la variable FFTW_DIR definida
dins del Makefile amb la ruta adequada. Per defecte, la ruta relativa és
finalProject1213q2/sources/fftw-2.1.3/installation

El seu ús a través de la línia de comandes, cal especificar un valor per a la
la variable del Makefile anomenat CC_SELECT_FLAGS. La sintaxis és:

make CC_SELECT_FLAGS="valor"

Els valors vàlids són els següents:

  - opt -> Compila el programa amb els millors flags per aconseguir el màxim
           rendiment del programa.

  - gprof -> Compila el programa amb els flags adients per poder fer profiling
             amb l'eina gprof.

  - oprofile -> Compila el programa amb els flags adients per poder fer 
                profiling amb l'eina Oprofile.

  - gdb -> Compila el programa amb els flags adient per a poder fer debugging
           amb l'eina gdb.

Si no s'especifica cap valor per a CC_SELECT_FLAGS, el programa es compila amb
els flags que venien per defecte a la versió original del programa.

Per conèxier en detall quins flags s'activen en funció del valor que pren
CC_SELECT_FLAGS a la linia de comandes consulteu directament el propi Makefile.

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/****** SCRIPT TIMING_AND_STDDEV.SH ******/

El script cal copiar-lo dins del mateix directori on es trobi l'executable
del programa ftdock (per defecte, finalProject1213q2/sources/3D_Dock/progs).
La sintaxi per a la línia de comandes és la següent:

./timimng_and_stddev input nexec step

Els tres paràmetres tenen el següent significat:

  - input -> Especifica amb quin dels tres tests executem el programa. Els
             valors vàlids són els següent:

             - test1 -> -static 2pka.parsed -mobile 5pti.parsed
             - test2 -> -static 1hba.parsed -mobile 5pti.parsed
             - test3 -> -static 4hhb.parsed -mobile 5pti.parsed

  - nexec -> Especifica el nombre de vegades que s'executarà el programa

  - step -> Especifica el número de la versió/optimització aplicada al programa
            que el script executarà. Aquest valor és necessari per a que el
            script pugui crear els directoris on col·locar els fitxers de 
            sortida corresponents, amb noms significatius.

Una vegada acabada l'execució del script, s'haurà creat un directori anomenat
"optstep" (e.g. si step=1 quan hem executat el script, la carpeta es dirà 
"opt1"), i dins d'aquest hi haurà un fitxer de text anomenat 
"step_output_test", que conté la sortida del programa per a la seva primera
execució, on step prendrà el valor que li haguem donat a través de la línia
de comandes, i el mateix per a test (i.e. test1, test2 o test3).

Per a més informació sobre com utilitzar el script, podeu executeu-lo sense cap
paràmetre i apareixerà la funció usage en la qual s'explica el seu
funcionament, o bé podeu obrir el script amb un editor de text per estudiar la
seva implementació en més detall.

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/****** INSTAL·LACIÓ DELS CODIS OPTIMITZATS ******/

A dins del directori "codis_optimitzats" adjunt al comprimit de la pràctica es
troben els codis font necessaris per a compilar i executar la versió
optimitzada del programa ftdock. Per a poder executar tal versió, cal copiar
tots els fitxers d'aquest directori cap al directori
finalProject1213q2/sources/3D_Dock/progs, reemplaçant-los pels ja existents
(amb la premissa que la pràctica ja està correctament instal·lada al vostre
ordinador). Alehores, cal copiar i reemplaçar també el fitxer Makefile adjunt
al comprimit de la pràctica cap al mateix directori on heu copiat els codis
optimitzats, i compilar i executar el programa (consulteu l'apartat anterior
MAKEFILE per a aprendre a compilar el programa amb el fitxer Makefile).

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


