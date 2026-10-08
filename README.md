# bote

## About

bote is an open source hardware 3D-printable Eurorack case by [piruetas](https://piruetas.xyz). It holds 48 hp of 3U modules, with rails at the top and bottom where the panels are screwed in with M3 screws, and an opening in the left wall for the power bus. The design is made in OpenSCAD and uses the shared constants and modules from [popusintes-cajas-paneles](https://github.com/piruetasxyz/popusintes-cajas-paneles), included as a git submodule in `terceros/`. Hardware is licensed under CERN-OHL-P-2.0 and documentation under CC-BY-SA-4.0 (see [LICENSE.md](./LICENSE.md)).

## Acerca de

Caja eurorack imprimible en 3D de [piruetas](https://piruetas.xyz), hecha en OpenSCAD y publicada como hardware de código abierto.

## Características

- 48 hp de ancho para módulos 3U, el máximo par que cabe en la cama de una Bambu Lab X1C.
- Medidas exteriores: 248.24 × 132.8 × 94.4 mm.
- Rieles arriba y abajo con agujeros piloto cada 1 hp, donde los tornillos M3 de 6 a 12 mm hacen su propia rosca en el plástico.
- Rieles con chaflán de 45° por debajo, para imprimir sin soportes con la base sobre la cama.
- Sin lip perimetral: los paneles se apoyan solo sobre los rieles, con 0.4 mm de holgura en el asiento.
- Agujero de 90 × 20 mm en la pared izquierda para pasar el bus de poder, por ejemplo [chufebu](https://github.com/piruetasxyz/chufebu).
- Profundidad útil de 90 mm desde el piso hasta la cara inferior de los paneles.
- Nombre y versión grabados en la base.

## Revisiones

- `v0.1 rev-a`: octubre 2026, primera versión como repositorio propio. Misma geometría que bote `v0.0.11` en popusintes-cajas-paneles, donde vivía antes, pero con la profundidad útil de vuelta en 90 mm (en `v0.0.11` era 45 mm, para una prueba).

## Desarrollo

Clonar el repositorio con su submódulo:

```bash
git clone --recursive https://github.com/piruetasxyz/bote.git
```

Si ya estaba clonado sin `--recursive`:

```bash
git submodule update --init
```

Ejecutar este comando una vez para activar el hook de pre-commit que corrige automáticamente estilo en los archivos `.scad`:

```bash
git config core.hooksPath .githooks
```

Para exportar la caja a `.stl`:

```bash
./scripts/exportar-stl.sh
```

Esto renderiza cada revisión `hardware/bote-v-X-rev-Y/` en su carpeta de fabricación `hardware/bote-v-X-rev-Y-fab/bote_caja.stl`. También se puede exportar una sola revisión, por ejemplo `./scripts/exportar-stl.sh bote-v-0-rev-a`. Requiere tener `openscad` instalado (en Mac, si no está en el `PATH`, el script busca automáticamente `/Applications/OpenSCAD.app`).

Para actualizar la biblioteca compartida a un tag nuevo de popusintes-cajas-paneles:

```bash
git -C terceros/popusintes-cajas-paneles fetch --tags
git -C terceros/popusintes-cajas-paneles checkout <tag>
```

y después volver a exportar y revisar que la caja no cambió sin querer.

## Estructura del repositorio

- [hardware/bote-v-0-rev-a](./hardware/bote-v-0-rev-a): archivos fuente de OpenSCAD de la caja. La versión y el ancho en hp están en [versiones.scad](./hardware/bote-v-0-rev-a/versiones.scad).
- [hardware/bote-v-0-rev-a-fab](./hardware/bote-v-0-rev-a-fab): `.stl` para imprimir la caja.
- [terceros/popusintes-cajas-paneles](https://github.com/piruetasxyz/popusintes-cajas-paneles): submódulo de git con las constantes eurorack y las funciones y módulos de OpenSCAD compartidos entre las cajas y paneles de popusintes.
- [scripts](./scripts): scripts para linting, revisión de sintaxis y exportado a `.stl`.
- [branding](./branding): logo de piruetas.
- [LICENSES](./LICENSES): textos completos de las licencias.

## Créditos

- Aarón Montoya-Moraga: concepto, programación, fabricación y documentación.
- Bernardita Jesús: revisión de parámetros, pruebas de fabricación, programación.

## Licencia

bote es (c) 2026 piruetas SpA / Aarón Montoya-Moraga.

- Hardware (`hardware/`): [CERN-OHL-P-2.0](./LICENSES/CERN-OHL-P-2.0.txt).
- Documentación (`README.md`): [CC-BY-SA-4.0](./LICENSES/CC-BY-SA-4.0.txt).
- Scripts (`scripts/`, `.githooks/`): [MIT](./LICENSES/MIT.txt).
- El nombre, logo y marca de piruetas no están cubiertos por estas licencias: ver [LicenseRef-piruetas-branding](./LICENSES/LicenseRef-piruetas-branding.txt).
- Biblioteca compartida (`terceros/popusintes-cajas-paneles`): submódulo con su propia licencia, MIT.

Ver [LICENSE.md](./LICENSE.md) para los detalles. El repositorio sigue la especificación [REUSE](https://reuse.software/).
