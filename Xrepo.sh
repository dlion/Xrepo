#!/bin/bash
########################################################################
#                    by PINPEREPETTE (the Pirate)                      #
########################################################################
# This program is free software; you can redistribute it and/or modify #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation; either version 2 of the License, or    #
# (at your option) any later version.                                  #
#                                                                      #
# This program is distributed in the hope that it will be useful,      #
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the         #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with this program; if not, write to the Free Software          #
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,           #
# MA 02110-1301, USA.                                                  #
############################# DISCALIMER ###############################
# Usage of this software for probing/attacking targets without prior   #
# mutual consent, is illegal. It's the end user's responsability to    #
# obey alla applicable local laws. Developers assume no liability and  #
# are not responible for any missue or damage caused by thi program    #
########################################################################
############################# SUBROUTINES ##############################
########################################################################
########################################################################
prog="Xrepo"
txr=$(tput setaf 1)
sxb=$(tput setab 4)
cxl=$(tput sgr0)
txg=$(tput setab 3)
gxo=$(tput bold)
clear
# Definizioni delle funzioni utilizzate nello script
# ----------------------------------------------------------------------

repo_struttura() {
	clear
	div
    echo -n "Immetti il nome da assegnare alla REPO: "
    read REPO
    echo la tua repo si chiama REPO=$REPO
    mkdir $REPO
    mkdir $REPO/debs
    cd $REPO
    > Release
}
deb_struttura() {
	clear
	div
	echo -n "Immetti il nome da assegnare al DEB: "
	read DEB
	mkdir $DEB
	mkdir $DEB/DEBIAN
	cd $DEB/DEBIAN
	> control
	> Preinst
	> Postinst
	> Prerm
	> Postrm
}
div() {
	echo "${txr}${sxb}${gxo}                                  X-REPO                                  ${cxl}"
} 
Relise() {
	clear
	div
    echo "iniziamo a editare il file Relise"
    echo -n "il campo Origin specifica il proprietario del repository: " 
    read Origin
    echo "Origin:" $Origin > Release
    clear
    div
    echo -n "il campo Label identifica il repository: potete inserire descrizioni, ecc:" 
    read Label
    echo "Label:" $Label >> Release
    clear
    div
    echo -n "il campo Suite identifica l'archivio Debian a cui i pacchetti appartengono (ad es.: stable, testing. ecc.).:" 
    read Suite
    echo "Suite:" $Suite >> Release
    clear
    div
    echo -n "il campo Codename specifica il nome in codice della release. :" 
    read Codename
    echo "Codenamel:" $Codenamel >> Release
    clear
    div
    echo -n "il campo Architectures elenca le architetture dei pacchetti contenuti nel repository (ad es.: i386, sparc, source, iphoneos-arm, ecc.).:" 
    read Architectures
    echo "Architectures:" $Architectures >> Release
    clear
    div
    echo -n "il campo Components indica il tipo di componente (ad es.: main, contrib, non-free):" 
    read Components
    echo "Components:" $Components >> Release
    clear
    div
    echo -n "nel campo Description mettete una breve descrizione del repo:" 
    read Description
    echo "Description:" $Description >> Release
    clear
    div
}
control() {
	clear
	div
	echo "iniziamo a editare il file control"
	echo "Il valore di questo campo determina il nome del pacchetto,"
	echo "ed  è usato  dalla  maggior parte degli strumenti di"
	echo "installazione per generare i nomi dei file."
	echo -n "Package: "
	read Package
	echo "Package:" $Package > control
	clear
	div
	echo "Tipicamente, questo è il numero  della  versione  originale  del pacchetto"
	echo "in  qualsiasi  forma usata dall’autore del programma."
	echo -n "Version:"
	read Version
	echo "Version:" $Version >> control
	clear
	div	
	echo "Questo è il campo mail, generalmente di chi ha fatto il pacchetto"
	echo "oppure dell’autore del programma."
	echo -n "Maintainer:"
	read Maintainer
	echo "Maintainer:" $Maintainer >> control
	clear
	div	
	echo "Questo è il campo descrizione del programma."
	echo -n "Description:"
	read Description
	echo "Description:" $Description >> control
	clear
	div
	echo "-----------------------------------------------------------------"
	echo "da qui in poi i campi sono opzionali, vedete voi XD"	
	echo "-----------------------------------------------------------------"
    echo "Questo è un campo generale che assegna al pacchetto una categoria"
    echo "tipo:‘utils’,‘net’,‘mail’,‘text’,‘x11’, etc."
    echo -n "Section:"
    read Section
    echo "Section:" $Section >> control
    clear
    div
    echo "Imposta l’importanza di questo pacchetto in relazione all’intero sistema."
    echo "Priorita‘ comuni sono: required, standard, optional, extra,etc"
    echo -n "Priority:"
    read Priority
    echo "Priority:" $Priority >> control
    clear
    div	
    echo "Mettete yes oppure no "
    echo "Questo campo è usualmente necessario solo quando la risposta è si"
    echo "Esso denota un pacchetto che è richiesto per il corretto funzionamento dell' OS"
    echo "Dpkg o qualsiasi altro strumento  di installazione non permettera‘ "
    echo "che  un pacchetto Essential sia rimosso (se non con un opzione di forzatura) "
    echo -n "Essential:"
    read Essential
    echo "Essential:" $Essential >> control
    clear
    div		
    echo "L’architettura specifica per quale tipo di hardware questo"
    echo "pacchetto è stato compilato. Architetture comuni sono: i386,"
    echo "m68k ,sparc,alpha ,powerpc, etc. Notare che l’opzione all"
    echo "è pensata per pacchetti che sono indipendenti dall’architettura."
    echo "tipo script shell o Perl, o documentazione."
    echo -n "Architecture:"
    read Architecture
    echo "Architecture:" $Architecture >> control
    clear
    div	
    echo "Il nome del pacchetto sorgente da cui deriva questo pacchetto"
    echo "binario, se è differente rispetto al nome del pacchetto stesso."
    echo -n "Source:"
    read Source
    echo "Source:" $Source >> control
    clear
    div	
    echo "Se il Vs deb ha delle dipendenze, dovete metterle qui :)"
    echo -n "Depends:"
    read Depends
    echo "Depends:" $Depends >> control
    clear
    div		    	    	
}
Package() {
	clear
	div
	echo -n "inserire il percorso del repo:"
	read RP
	cd $RP
	dpkg-scanpackages -m . /dev/null > Packages
	sleep 2
	clear
}
Menu() {
	echo "${txr}${sxb}${gxo}                                                                         ${cxl}"
	echo "${txr}${sxb}${gxo}                            OPZIONI X-Repo                               ${cxl}"
	echo "${txr}${sxb}${gxo}                                                                         ${cxl}"
	echo "${txg}${sxb}${gxo} 1) Crea Nuovo Repo                                                      ${cxl}"
	echo "${txr}${sxb}${gxo}                                                                         ${cxl}"
	echo "${txg}${sxb}${gxo} 2) Aggiorna Packages                                                    ${cxl}"
	echo "${txr}${sxb}${gxo}                                                                         ${cxl}"
	echo "${txg}${sxb}${gxo} 3) Crea Struttura Deb                                                   ${cxl}"
	echo "${txr}${sxb}${gxo}                                                                         ${cxl}"
	echo ""
	echo -n "Cosa vuoi fare ? "
	read CS
case "$CS" in
	1) 
	repo_struttura
	Relise
	Menu
	;;
	2)
	Package
	Menu
	;;
	3)
	deb_struttura
	control
    Menu
	;;	*)
	clear
	echo "CoccoDio !!! Devi scegliere un numero nella lista"
	Menu
	;;
esac	
}
Menu 
