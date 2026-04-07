function calcular(operacion) {
    var n1 = parseFloat(document.getElementById("n1").value);
    var n2 = parseFloat(document.getElementById("n2").value);
    var resultado = 0;

    if (isNaN(n1) || isNaN(n2)) {
        alert("Introduce números válidos");
        return;
    }

    switch (operacion) {
        case '+':
            resultado = n1 + n2;
            break;
        case '-':
            resultado = n1 - n2;
            break;
        case '*':
            resultado = n1 * n2;
            break;
        case '/':
            if (n2 !== 0) {
                resultado = n1 / n2;
            } else {
                resultado = "Error";
            }
            break;
    }

    document.getElementById("resultado-display").innerText = resultado;
}

function limpiar() {
    document.getElementById("n1").value = "";
    document.getElementById("n2").value = "";
    document.getElementById("resultado-display").innerText = "";
}