#!/bin/bash


#Variables
opcion=-1
subopcion_var=-1
ayuda_var=-1
#Funciones
function menu() {
	clear
	
	echo "==============MENU=============="
	echo "1) Gestión por apt"
	echo "2) Gestión por dpkg"
	echo "3) Synaptic"
	echo "4) Ayuda/Info"
	echo "5) Salir"
	echo "================================"
	
	read -p "Seleccione una opción [1-*]: " opcion
	echo "================================"	
}


function apt() {
	echo "Ha seleccionado la opción 1"
	read -p "¿Desea hacer un update? s/n: " update
	echo "================================"
	
	if [ $update == "S" ] 2</dev/null || [ $update == "s" ] 2</dev/null
	then
		sudo apt update 2</dev/null
		
		if [ $? == 0 ]
		then 
			echo
			echo "Update realizado correctamente"
		else
			echo "Algo ha salido mal"
		fi
		
	elif [ $update == "N" ] 2</dev/null || [ $update == "n" ] 2</dev/null
	then
		echo "El update no se va ha ejecutar"
	else
		echo "No es una opción válida"
	fi
	
	echo "===================================="
	read -p "¿Desea instalar un programa? s/n: " inst
	echo "===================================="
	
	if [ $inst == "S" ] 2</dev/null || [ $inst == "s" ] 2</dev/null
	then
		read -p "Seleccione la aplicación a instalar: " app
		echo "====================================="
		
		sudo apt install $app 2</dev/null
	
			if [ $? -eq 0 ]
			then 
				echo 
				echo "Instalación ejecutada correctamente"			
				read -p "Pulse ENTER para comprobar la instalación..." comprobar
				echo "============================================"
	
				whereis $app
			else
				echo "Esa aplicación no existe"
			fi

	elif [ $inst == "N" ] 2</dev/null || [ $inst == "n" ] 2</dev/null
	then
		echo "La instalación no se va a ejecutar"
	else
		echo "No es una opción válida"
	fi
	
	echo "===================================="
	read -p "¿Desea eliminar un programa? s/n: " elim
	echo "===================================="
	
	if [ $elim == "S" ] 2</dev/null || [ $elim == "s" ] 2</dev/null
	then		
		read -p "Seleccione la aplicación a eliminar: " elim
		echo "====================================="
		
		sudo apt purge $elim 2</dev/null	
			
			if [ $? == 0 ]
			then 
				echo
				echo "Eliminación ejecutada correctamente"			
				read -p "Pulse ENTER para comprobar la eliminación..." comprobar
				echo "============================================"
	
				whereis $elim
			else
				echo "Esa aplicación no existe"
			fi
			
	elif [ $elim == "N" ] 2</dev/null || [ $elim == "n" ] 2</dev/null
	then
		echo "La eliminacion no se va a ejecutar"
	else
		echo "No es una opción válida"
	fi
	read -p "Pulse ENTER para continuar..."
}

function dpkg_menu() {
	
	echo "Ha seleccionado la opción 2."
	echo "1) Instalar"
	echo "2) Desinstalar"
	echo "3) Volver"
	echo "============================"
	
	read -p "Seleccione una opción: " subopcion
	echo "============================"
}

function dpkg_inst() {

	read -p "Indique la ruta de la carpeta: " archivo
	
	if [ -d $archivo ]
	then
		cd $archivo 2>/dev/null
	 
		ls -la *.deb 2>/dev/null
		
		if [ $? -ne 0 ]
		then
			echo "No se ha podido mostrar"
		fi
		
		echo "==================================================="
		read -p "Seleccione un archivo .deb a instalar: " inst
		echo "==================================================="
		
		if [ -f $inst ]
		then
			sudo dpkg -i $inst 2>/dev/null
			
			if [ $? -ne 0 ]
			then 
				
				echo "Operación fallida"
			else
				echo "====================================================="
				read -p "Pulse ENTER para comprobar la instalación" 
				echo "====================================================="
				clear
				comprobar=$(sudo dpkg -I $inst | grep -i "package" | tr -d " " | cut -d":" -f2)
				
				sudo dpkg -s $comprobar	2>/dev/null
			
				if [ $? -ne 0 ]
				then 
					echo "No existe ese paquete"
				fi
			fi
			
		else
			echo "Ese archivo no existe"
		fi
			
			echo "==============================================================================="
	else
		echo "Esa carpeta no existe"
		echo "==============================================="
	fi	
	read -p "Pulse ENTER para continuar..."
}

function dpkg_elim() {
	read -p "Indique la ruta de la carpeta: " archivo
	
	if [ -d $archivo ]
	then
		cd $archivo 2>/dev/null
	 
		ls -la *.deb 2>/dev/null
		
		if [ $? -ne 0 ]
		then
			echo "No se ha podido mostrar"
		fi
		
		echo "==============================================="
		read -p "Seleccione el archivo .deb a eliminar: " elim
		echo "==============================================="
		if [ -f $elim ]
		then
			eliminar=$(sudo dpkg -I $elim| grep -i "package" | tr -d " " | cut -d":" -f2)
			sudo dpkg -P $eliminar 2</dev/null
			
			if [ $? -ne 0 ]
			then 
				
				echo "Operación fallida"
			else
				echo "====================================================="
				read -p "Pulse ENTER para comprobar la instalación" 
				echo "====================================================="
								
				sudo dpkg -s $eliminar	2>/dev/null
			
				if [ $? -ne 0 ]
				then 
					echo "Ese programa no está instalado"
				fi
			fi
			
		else
			echo "Ese archivo no existe"
		fi
			
			echo "==============================================="
	else
		echo "Esa carpeta no existe"
		
	fi
	read -p "Pulse ENTER para continuar..."
}

function synaptic() {
	sudo synaptic
	
}

function ayuda() {
	echo "========AYUDA========"
	echo "1) Info apt"
	echo "2) Info dpkg"
	echo "3) Info synaptic"
	echo "4) Volver"
	echo "====================="
	
	read -p "Seleccione una opción: " ayuda
}

function ayuda_apt() {
	echo "Esta opción te dara información sobre apt y sus diferentes comandos correspondientes"
	read -p "Pulse ENTER para continuar..."
	sudo apt help
	read -p "Pulse ENTER para continuar..."
}

function ayuda_dpkg() {
	echo "Esta opción te dara información sobre diferentes comandos correspondientes al dpkg"
	read -p "Pulse ENTER para continuar..."
	sudo dpkg --help
	read -p "Pulse ENTER para continuar..."
}

function info_synaptic() {
	echo "Esta opción te dara información sobre synaptic"
	read -p "Pulse ENTER para continuar..."
	man synaptic
}

function salir() {
	echo "Hasta luego"
	exit
}


#Programa
while [ $opcion -lt 6 ] 2</dev/null
do
	cd
	menu

	case $opcion in
		1)
			apt
			;;
		2)
			while [ $subopcion_var -lt 4 ] 2</dev/null
			do
				cd
				dpkg_menu
				
				case $subopcion in
					1)
						dpkg_inst
						;;
					2)
						dpkg_elim
						;;
					3)
						break
						;;
					*)
						echo "Esa opcion no es válida"
						read -p "Pulse ENTER para continuar..."
						;;
				esac				
				clear
			done
			;;
		3)
			synaptic
			;;
		4)
			while [ $ayuda_var -lt 5 ] 2</dev/null
			do
				cd
				ayuda
				
				case $ayuda in
					1)
						ayuda_apt
						;;
					2)
						ayuda_dpkg
						;;
					3)
						info_synaptic
						;;
					4)
						break
						;;
					*)
						echo "Esa opcion no es válida"
						read -p "Pulse ENTER para continuar..."
						;;
				esac							
				clear
			done
			;;						
		5) 
			salir
			;;	
		*) 
			echo "Esa opción no es válida"
			;;			
	esac
done
