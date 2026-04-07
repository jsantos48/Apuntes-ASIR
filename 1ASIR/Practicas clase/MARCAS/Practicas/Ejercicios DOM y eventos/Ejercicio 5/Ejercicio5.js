let opcion = 0;

document.getElementById("btnUp").addEventListener("click", IrArriba);
document.getElementById("btnDown").addEventListener("click", IrAbajo);
document.getElementById("btnCalcular").addEventListener("click", Calcular);

function IrArriba(){
    if (opcion > 0){ 
        opcion = opcion - 1;
        PintarOpcion();
    }
}

function IrAbajo(){
    if (opcion < 3){
        opcion = opcion + 1;
        PintarOpcion();
    }
}

function PintarOpcion(){
    document.getElementById("opt0").style.borderColor = "white";
    document.getElementById("opt0").style.backgroundColor = "white";

    document.getElementById("opt1").style.borderColor = "white";
    document.getElementById("opt1").style.backgroundColor = "white";

    document.getElementById("opt2").style.borderColor = "white";
    document.getElementById("opt2").style.backgroundColor = "white";

    document.getElementById("opt3").style.borderColor = "white";
    document.getElementById("opt3").style.backgroundColor = "white";

    switch(opcion){
        case 0:
            document.getElementById("opt0").style.borderColor = "black";
            document.getElementById("opt0").style.backgroundColor = "red";
            break;
        case 1:
            document.getElementById("opt1").style.borderColor = "black";
            document.getElementById("opt1").style.backgroundColor = "red";
            break;
        case 2:
            document.getElementById("opt2").style.borderColor = "black";
            document.getElementById("opt2").style.backgroundColor = "red";
            break;
        case 3:
            document.getElementById("opt3").style.borderColor = "black";
            document.getElementById("opt3").style.backgroundColor = "red";
            break;
    }
}

function Calcular(){
    let num = parseInt(document.getElementById("num").value);
    let strResultado = '';

    if (num > 0){
        switch(opcion){
            case 0: 
                strResultado = EsPar(num);
                break;
            case 1:
                strResultado = EsImpar(num);
                break;
            case 2:
                strResultado = EsPrimo(num);
                break;
            case 3:
                strResultado = Divisores(num);
                break;
        }
    } else {
        strResultado = "Número debe ser > 0";
    }
    
    document.getElementById("resultado").value = strResultado;
}

function EsImpar(num){
    let strResult = '';
    if ((num % 2) !== 0){
        strResult = "Número " + num.toString() + " es IMPAR";
    } else {
        strResult = "Número " + num.toString() + " no es IMPAR";
    }
    return strResult;
}

function EsPar(num){
    let strResultPar = '';
    if ((num % 2) === 0){
        strResultPar = "Número " + num.toString() + " es PAR";
    } else {
        strResultPar = "Número " + num.toString() + " no es PAR";
    }
    return strResultPar;
}

function EsPrimo(num) {
    let divisor = 2;
    let contadorDivisores = 0;
    let strResult = '';

    while (divisor < num) {
        if ((num % divisor) == 0) {
            contadorDivisores = contadorDivisores + 1;
        }
        divisor = divisor + 1;
    }

    if (contadorDivisores == 0) {
        strResult = 'Número ' + num.toString() + ' es PRIMO';
    } else {
        strResult = 'Número ' + num.toString() + ' no es PRIMO';
    }
    return strResult;
}

function Divisores(num) {
    let divisor = 1;
    let strDivisores = 'DIV:';

    while (divisor <= num) {
        if ((num % divisor) == 0) {
            strDivisores = strDivisores + ' ' + divisor.toString();
        }
        divisor = divisor + 1;
    }
    return strDivisores;
}