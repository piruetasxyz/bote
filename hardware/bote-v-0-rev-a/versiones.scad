// versiones.scad

// version de bote, grabada en la base de la caja. sigue el esquema de
// chufe y chufebu: v<mayor>.<menor> rev-<letra>
VERSION = "v0.1 rev-a";

BOTE_TEXTO = "bote";

// 48 hp es el maximo par que cabe en la cama de una bambu lab x1c
BOTE_HP = 48;

// versiones
//
// v0.1 rev-a: octubre 2026. primera version como repositorio propio.
// misma geometria que bote en popusintes-cajas-paneles v0.0.11, con
// rieles arriba y abajo con agujeros piloto M3 cada 1 hp, sin lip
// perimetral, 0.4 mm de holgura en el asiento y agujero de 90 x 20 mm
// en la pared izquierda para el bus de poder. la profundidad util
// vuelve a 90 mm, despues de la prueba de 45 mm de v0.0.11
