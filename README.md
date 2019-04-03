# rappi-challenge

Comentarios: 
- A efectos de simplicar el test por motivos de tiempo, solo cree un modelo "Movie" que unifica informacion tanto de movie como de series.
- No tuve tiempo para hacer los puntos extras.


1. Las capas de la aplicación (por ejemplo capa de persistencia, vistas, red, negocio, etc) y qué clases pertenecen 
a cual.
2. La responsabilidad de cada clase creada.

- Persistencia: DataManager, usando Realm se guardan los datos localmente.
- Servicios: MovieService y TMDbApiService, realiza peticiones a la api de TMDb para obtener los datos requeridos.
- Vistas: MovieSeriesViewController y DetailViewController, son las encargadas de mostrar los datos en sus respectivas vistas, definidas en storyboard.
- Patron utlizado: MVC


Responda y escriba dentro del Readme con las siguientes preguntas:
1. En qué consiste el principio de responsabilidad única? Cuál es su propósito?
El principio de responsabilidad única es el primer principio de SOLID para la programación Orientada a Objetos (Single responsability). Una funcion o módulo debe tener una y solo una responsabilidad, y el proposito fundamental es justamente (y valga la redundancia) que cada cosa deberia solo tener un proposito, solo una responsablidad. Esto permite tener un codigo claro y ordenado, con responsabilidades bien definidas.

2. Qué características tiene, según su opinión, un “buen” código o código limpio?
- Bien documentado
- Separado en capas, responsabilidades bien definidas
- Modularizado, dependencias minimas
- Arquitectura clara
- No existan valores hardcoded
- Facil de leer
- Pruebas unitarias
