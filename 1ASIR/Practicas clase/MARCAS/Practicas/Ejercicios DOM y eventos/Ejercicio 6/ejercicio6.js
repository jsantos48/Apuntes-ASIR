let numeroSecreto = Math.floor(Math.random()*101);
let intentos = 0;
let maxIntentos = 10;
let numerosIntentados = [];

function jugar(){
let numero = parseInt(document.getElementById("numero").value);
let resultado = document.getElementById("resultado");
let contador = document.getElementById("contador");
let tabla = document.getElementById("tablaIntentos").children;

if(intentos >= maxIntentos) return;

intentos++;
numerosIntentados.push(numero); 
contador.textContent = numerosIntentados.join(" ");
tabla[intentos-1].textContent = "X";

if(numero === numeroSecreto){

resultado.textContent = "HAS ACERTADO";
resultado.className = "resultado verde";

}

else if(intentos === maxIntentos){

resultado.textContent = "HAS PERDIDO";
resultado.className = "resultado amarillo";

}

else if(numero > numeroSecreto){

resultado.textContent = numero + " ES MAYOR";
resultado.className = "resultado rojo";

}

else{

resultado.textContent = numero + " ES MENOR";
resultado.className = "resultado rojo";

}

}