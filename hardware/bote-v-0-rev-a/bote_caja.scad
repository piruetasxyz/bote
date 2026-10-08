// bote_caja.scad
// caja de varios modulos, con rieles arriba y abajo donde se
// atornillan los paneles. a diferencia de caja() de
// popusintes-cajas-paneles no tiene lip perimetral: los paneles
// se apoyan solo sobre los rieles

include <../../terceros/popusintes-cajas-paneles/comun/comun.scad>
include <./versiones.scad>

// profundidad util para los modulos, desde el piso hasta
// la cara inferior del panel
BOTE_PROFUNDIDAD_UTIL = 90;

// cuanto entra cada riel desde la pared, deja ~116 mm libres
// entre rieles para los pcb. el agujero piloto termina a 4.3 mm
// de la pared, quedan 1.7 mm de material
BOTE_RIEL_ANCHO = 6;

// espesor del riel bajo el panel. los agujeros piloto atraviesan
// tambien el chaflan, asi que caben tornillos M3 de 6 a 12 mm
BOTE_RIEL_ESPESOR = 5;

// juego total del asiento de los paneles, en x y en y
BOTE_HOLGURA = 0.4;

// agujero en la pared izquierda para pasar el bus de poder,
// centrado en la pared. [largo en y, alto en z]
BOTE_AGUJERO_BUS = [90, 20];

// el tornillo izquierdo de cada panel queda a MARGEN_X del borde
// y el derecho a MARGEN_X del otro borde, por eso los derechos
// caen desplazados de la grilla de los izquierdos en esta cantidad
// (0.24 mm). los agujeros piloto se alargan en x para cubrir ambos
BOTE_DESFASE_TORNILLOS = 3 * MODULO_ANCHO - 2 * MARGEN_X;

module bote_caja(
    hp,
    texto = BOTE_TEXTO,
    version = VERSION,
    pared = CAJA_PARED,
    radio_esquina = 1.5,
    tamano_texto = MODULO_ALTURA_3U * 0.05,
    tamano_version = MODULO_ALTURA_3U * 0.035
) {

  ancho_int  = MODULO_ANCHO * hp + BOTE_HOLGURA;
  altura_int = MODULO_ALTURA_3U + BOTE_HOLGURA;

  ancho_ext  = 2 * pared + ancho_int;
  altura_ext = 2 * pared + altura_int;

  // cara superior de los rieles = cara inferior de los paneles
  z_rieles = pared + BOTE_PROFUNDIDAD_UTIL;
  // los paneles quedan al ras del borde de la caja
  profundidad_ext = z_rieles + PANEL_PROFUNDIDAD;

  // origen de los paneles, centrados en la holgura
  x_paneles = pared + BOTE_HOLGURA / 2;
  y_paneles = pared + BOTE_HOLGURA / 2;

  // riel con chaflan de 45 grados por debajo, para imprimir sin
  // soportes con la base sobre la cama. y_pared es la y de la pared
  // donde se apoya, sentido es +1 (riel inferior) o -1 (superior)
  module riel(y_pared, sentido) {
    y_bloque = sentido > 0 ? y_pared : y_pared - BOTE_RIEL_ANCHO;
    y_filo   = sentido > 0 ? y_pared : y_pared - 0.01;
    hull() {
      translate([pared, y_bloque, z_rieles - BOTE_RIEL_ESPESOR])
        cube([ancho_int, BOTE_RIEL_ANCHO, BOTE_RIEL_ESPESOR]);
      translate([pared, y_filo, z_rieles - BOTE_RIEL_ESPESOR - BOTE_RIEL_ANCHO])
        cube([ancho_int, 0.01, BOTE_RIEL_ANCHO]);
    }
  }

  // agujeros piloto cada 1 hp, para que los tornillos M3 hagan
  // su propia rosca en el plastico
  module agujeros_piloto() {
    ultimo = floor((ancho_int - BOTE_HOLGURA - 2 * MARGEN_X - BOTE_DESFASE_TORNILLOS) / MODULO_ANCHO + 0.001);
    for (k = [0 : ultimo])
      for (y = [MARGEN_Y, MODULO_ALTURA_3U - MARGEN_Y])
        hull()
          for (dx = [0, BOTE_DESFASE_TORNILLOS])
            translate([x_paneles + MARGEN_X + k * MODULO_ANCHO + dx, y_paneles + y, z_rieles - BOTE_RIEL_ESPESOR - BOTE_RIEL_ANCHO - 1])
              cylinder(h = BOTE_RIEL_ESPESOR + BOTE_RIEL_ANCHO + 2, d = ROSCA_DIAMETRO_PILOTO, $fn = 24);
  }

  difference() {
    union() {
      difference() {
        caja_redondeada(ancho_ext, altura_ext, profundidad_ext, radio_esquina);
        translate([pared, pared, pared])
          cube([ancho_int, altura_int, profundidad_ext]);
      }
      riel(pared, 1);
      riel(pared + altura_int, -1);
    }

    agujeros_piloto();

    // agujero del bus de poder en la pared izquierda
    translate([-1,
               altura_ext/2 - BOTE_AGUJERO_BUS[0]/2,
               profundidad_ext/2 - BOTE_AGUJERO_BUS[1]/2])
      cube([pared + 2, BOTE_AGUJERO_BUS[0], BOTE_AGUJERO_BUS[1]]);

    // grabados en la base
    texto_base(texto,   tamano_texto,   ancho_ext/2, 40*altura_ext/100);
    texto_base(version, tamano_version, ancho_ext/2, 60*altura_ext/100);
  }
}
