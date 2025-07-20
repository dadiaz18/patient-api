# 💉 **Challenge Backend Engineer – API de Inyecciones para Pacientes**

## 🧠 Contexto

La hemofilia es un trastorno raro en el cual la sangre no coagula correctamente. Esto puede causar sangrados espontáneos o prolongados después de una lesión o cirugía.

El tratamiento consiste en reemplazar el factor de coagulación faltante mediante la **inyección regular de un medicamento** (concentrado del factor) cada *N* días, según el cronograma médico del paciente.

Para este challenge, queremos también calcular un **puntaje de adherencia al tratamiento** (entre 0% y 100%), dependiendo de qué tan bien el paciente respeta su calendario de inyecciones.

**Ejemplo**:
Si un paciente fue creado el 1 de enero y hoy es 12 de enero, y debe inyectarse cada 3 días, esperaríamos inyecciones el 1, 4, 7 y 10 de enero.

---

## 🎯 Objetivos mínimos

Debes implementar una API que permita a pacientes con hemofilia:

1. ✅ Crear un paciente con:

   * Un `id`
   * Una `api_key` generada aleatoriamente y de forma segura.

2. 💉 Registrar una inyección con:

   * Dosis (en mililitros)
   * Número de lote (texto alfanumérico de 6 caracteres)
   * Nombre del medicamento
   * Asociada a un paciente específico

3. 🔍 Consultar todas las inyecciones asociadas a un paciente.

4. 📊 Obtener el puntaje de adherencia al tratamiento del paciente.

### Seguridad:

* Los endpoints de inyecciones y puntaje de adherencia deben estar **disponibles públicamente**, pero **protegidos por la `api_key` del paciente**.

### Pruebas:

* El código debe estar **testeado** (con pruebas unitarias o de integración).

---

## 🌟 Bonus (opcional)

Estos son solo ejemplos de mejoras opcionales. Puedes proponer otras ideas interesantes:

* Documentación de la API (OpenAPI, API Blueprint, RAML, etc.)
* Métricas expuestas (hardware, salud, cantidad de requests, etc.) disponibles para Prometheus.
  ⚠️ Este endpoint **no debe ser público**.
* Uso de CI/CD gratuito en GitHub o GitLab (como GitHub Actions, Travis, CircleCI, etc.) para correr tests y linters automáticamente al hacer push.
* Un frontend simple.

---

## 📦 Entregables

Debes entregar un repositorio **(público o privado)** que contenga:

* `README.md`
* `Dockerfile`
* `docker-compose.yml`
* El código fuente de la aplicación

🔧 El revisor debe poder levantar la API localmente solo con Docker (sin dependencias externas).

El `README.md` debe incluir:

* Instrucciones para correr la app
* Cómo usar la API
* Qué funcionalidades y bonus fueron implementados

---

## 🧰 Requisitos técnicos

* El lenguaje debe ser **Ruby**, ya que es el principal lenguaje de backend en Florio.
* Puedes usar **cualquier framework web**.
* Puedes usar **cualquier base de datos o librerías**, mientras justifiques su uso.
* Puedes usar REST, gRPC o GraphQL.

---

## 🧪 Evaluación

Se evaluará principalmente:

* Correctitud funcional
* Claridad y mantenibilidad del código
* Calidad de los tests
* Bonus implementados

---

## ⏳ Consideraciones finales

Sabemos que tu tiempo es valioso.
No esperamos que empieces el challenge de inmediato ni que hagas todas las tareas extra.

### Tiempo estimado:

* **Hasta 5 horas** para cumplir con los objetivos mínimos.
* **Máximo 3 días** para enviar tu solución desde que recibes el challenge.

¡Esperamos que te diviertas haciéndolo! 😊

