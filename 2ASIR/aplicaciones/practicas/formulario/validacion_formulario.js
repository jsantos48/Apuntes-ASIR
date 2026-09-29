const form1 = document.querySelector('form');
const contrasena = document.getElementById('contrasena');
const repetirContrasena = document.getElementById('repetir_contrasena');

const mensaje = document.createElement('span');
mensaje.style.color = 'red';
mensaje.style.fontSize = '12px';
repetirContrasena.parentNode.appendChild(mensaje);

form1.addEventListener('submit', function(event) {
    if (contrasena.value !== repetirContrasena.value) {
        event.preventDefault();
        mensaje.textContent = 'Las contraseñas no coinciden.';
    } else {
        mensaje.textContent = '';
    }
});

const form2 = document.querySelector('form');
const fechaNacimiento = document.getElementById('fecha_nacimiento');

const mensajeFecha = document.createElement('span');
mensajeFecha.style.color = 'red';
fechaNacimiento.parentNode.appendChild(mensajeFecha);

form2.addEventListener('submit', function(event) {
    const fechaLimite = new Date();
    fechaLimite.setFullYear(fechaLimite.getFullYear() - 16);

    if (new Date(fechaNacimiento.value) > fechaLimite) {
        event.preventDefault();
        mensajeFecha.textContent = 'Debes ser mayor de 16 años.';
    } else {
        mensajeFecha.textContent = '';
    }
});