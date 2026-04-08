/* SECCION 1 */

/*
Fragmento 1: Selección y Manipulación 
    Al cambiar el color a tantos parrafos en caso de que los haya, seria conveniente
    usar un bucle para que vaya uno por uno, ya que al haber tantos podría colapsar o 
    dar lugar a error. 


Fragmento 2: Manejo de eventos
    Tiene un fallo en la segunda linea del comando, ya que no se debe poner miFuncion() dentro del listener, 
    ya que indicas que se ejecute en el momento y no que espere al click:
        btn.addEventListener("onclick", miFuncion);

Fragmento 3: Validación de formularios
    El return false no detendrá el envio del formualrio, se enviará de todas formas
    y el mensaje desaparecerá. Habría que añadir un event.preventDefault para cancelar
    la opción por defecto de enviar el formulario aunque no haya nombre
*/

/* SECCION 2 */

const preguntas = [
    {
        pregunta: "¿Cual es la capital de España?",
        opciones: ["Londres", "Bulgaria", "Madrid", "España"],
        correcta: 2
    },
    {
        pregunta: "¿Cuantos dedos tiene una persona?",
        opciones: ["10", "20", "100", "2"],
        correcta: 1
    },
    {
        pregunta: "¿Que cae al llover?",
        opciones: ["Agua", "Leche", "Lava", "Ácido"],
        correcta: 0
    },
    {
        pregunta: "¿Que pasa por las venas?",
        opciones: ["Barbacoa", "Ácido", "El Nilo", "Sangre"],
        correcta: 0
    }
];

let indicePreguntaActual = 0;
let puntaje = 0;

const pProgreso = document.getElementById('progreso');
const h2Pregunta = document.getElementById('pregunta');
const divOpciones = document.getElementById('opciones');
const btnSiguiente = document.getElementById('btn-siguiente');
const divResultado = document.getElementById('resultado');
const pPuntajeFinal = document.getElementById('puntaje-final');
const btnReiniciar = document.getElementById('btn-reiniciar');

function mostrarPregunta() {
    const preguntar = preguntas[indicePreguntaActual];

    pProgreso.innerText = `Pregunta ${indicePreguntaActual + 1} de ${preguntas.length}`;
    h2Pregunta.innerText = preguntar.pregunta;
}