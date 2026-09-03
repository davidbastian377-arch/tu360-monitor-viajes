# Tu360 Viajes — Monitor de Competitividad
## Etapa 3 · Monitor online gratuito v0.8

Núcleo técnico para monitorear diariamente la competitividad de Tu360 Viajes en vuelos, hoteles y paquetes.

### Alcance inicial
- 5 vuelos ida y regreso.
- 5 vuelos solo ida.
- 5 consultas de hoteles.
- 7 a 10 consultas de paquetes.
- Foco nacional: Bogotá, Medellín, Cartagena, Santa Marta y San Andrés.
- Comparación separada entre:
  1. **Competitividad del canal:** precio estándar sin beneficios bancarios exclusivos.
  2. **Competitividad financiera/comercial:** promociones y beneficios verificados.

### Principios
1. Solo se comparan productos equivalentes.
2. `NO_DISPONIBLE` es distinto de `ERROR_TECNICO`.
3. El precio principal es el precio final verificable antes de confirmar/pagar.
4. Cashback, descuentos, cuotas y puntos se modelan por separado.
5. Toda observación puede conservar URL y evidencia.
6. El motor adaptativo nunca elimina la cobertura estructural mínima.
7. Toda etiqueta visible al negocio está en español.

### Inicio rápido

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
pip install -e .
docker compose up -d
cp .env.example .env
python scripts/inicializar_bd.py
python scripts/generar_escenarios.py
python scripts/cargar_demo.py
streamlit run dashboard/app.py
```

En Windows:

```powershell
.venv\Scripts\activate
```

### Supabase
La misma estructura funciona en PostgreSQL administrado por Supabase. Solo se reemplaza `DATABASE_URL`.

### Próximo hito
Conectar tres escenarios reales de vuelos mediante adaptadores por fuente, empezando por el vuelo canónico de la aerolínea directa y luego Tu360 + competidores.

Esta versión no evade CAPTCHA, controles de acceso ni restricciones técnicas de los sitios. Cada fuente debe pasar revisión técnica y de términos antes de automatizarse.


## Etapa 3.2 — Piloto controlado

Se añadió `config/piloto_tres_vuelos.json` con tres escenarios controlados y un motor de coincidencia exacta.

Ejecutar:

```bash
python scripts/piloto_tres_vuelos.py
```

Para instalar Chromium de Playwright:

```bash
playwright install chromium
```

La navegación real por fuente debe habilitarse únicamente después de la revisión de términos y del DOM actual del sitio.


## Regla v0.3: búsqueda real obligatoria

El ranking rechaza automáticamente banners, landings de ruta, precios cacheados y ofertas indexadas.

Se añadió:

- `sql/005_busqueda_real.sql`
- `src/tu360_monitor/validacion_busqueda.py`
- `src/tu360_monitor/evidencia.py`
- `config/reglas_aceptacion_precio.json`
- `docs/REGLA_BUSQUEDA_REAL.md`

El precio de resultados puede almacenarse con fines diagnósticos, pero el ranking principal usa el precio de detalle/checkout cuando la búsqueda reproducida coincide con el escenario.


## Etapa 3.4

- URL oficial de Tu360 fijada.
- Adaptador inicial de Tu360 sin bypass.
- Adaptador ejecutable inicial de Viajes Éxito.
- Política de cumplimiento por fuente.
- Captura manual validada como respaldo.
- Orquestador del primer escenario.
- Fuentes no autorizadas nunca generan precios simulados.


## Etapa 3.5 — Primera fila

Producto canónico fijado:
- JA5118 BOG–MDE · 27/09/2026 · 05:25
- JA5111 MDE–BOG · 30/09/2026 · 09:45

La fila no entra al ranking hasta confirmar precio final, tarifa, equipaje y evidencia.


## Etapa 3.6 — Captura verificada

Se añadió:
- registro de inteligencia no válida para ranking;
- estado auditable de la primera fila;
- validador de observaciones finales;
- página Streamlit de captura verificada;
- cálculo de incremento entre precio de resultados y precio final.

El sistema conserva el dato promocional para análisis, pero impide que contamine
el ranking principal.


## Versión online v0.7

Esta versión queda preparada para despliegue web:

- Streamlit Community Cloud para el dashboard.
- Supabase para PostgreSQL y evidencias.
- Cloud Run Jobs + Cloud Scheduler para automatización diaria.
- Dockerfiles separados para dashboard y trabajos de captura.

Consultar `docs/DESPLIEGUE_ONLINE.md`.


## Piloto gratuito v0.8

La arquitectura del piloto ahora utiliza exclusivamente niveles gratuitos:

- GitHub privado
- GitHub Actions
- Streamlit Community Cloud
- Supabase

GitHub Actions programa el monitoreo a las 08:00 en `America/Bogota`.

Consultar:
- `docs/PILOTO_GRATUITO_PASO_A_PASO.md`
- `docs/ARQUITECTURA_GRATUITA.md`
