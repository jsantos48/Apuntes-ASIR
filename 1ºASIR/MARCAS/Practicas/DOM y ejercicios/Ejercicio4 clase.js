function Sumar(){
    let numero1 = parseFloat(document.getElementById("idNum1").value)
    let numero2 = parseFloat(document.getElementById("idNum2").value)

    let resultado = numero1 + numero2

    if(resultado == 0 || resultado){
        document.getElementById("idNumResultado").value = resultado
    } else {
        document.getElementById("idNumResultado").value = "Debes poner algo"
    }
}

function Restar(){
    let numero1 = parseFloat(document.getElementById("idNum1").value)
    let numero2 = parseFloat(document.getElementById("idNum2").value)

    let resultado = numero1 - numero2
    
    document.getElementById("idNumResultado").value = resultado
}

function Producto(){
    let numero1 = parseFloat(document.getElementById("idNum1").value)
    let numero2 = parseFloat(document.getElementById("idNum2").value)

    let resultado = numero1 * numero2
    
    document.getElementById("idNumResultado").value = resultado
}

function Dividir(){
    let numero1 = parseFloat(document.getElementById("idNum1").value)
    let numero2 = parseFloat(document.getElementById("idNum2").value)

    let resultado = numero1 / numero2
    if (numero2 == 0) {
        resultado = "Error"
        alert("No se puede dividir por 0");
    }
    document.getElementById("idNumResultado").value = resultado
}

function Limpiar(){
    document.getElementById("idNum1").value = "";
    document.getElementById("idNum2").value = "";
    document.getElementById("idNumResultado").value = "";
}